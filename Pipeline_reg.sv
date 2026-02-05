module pipeline_reg #(
    parameter DATA_WIDTH = 32
)(
    input  logic                  clk,
    input  logic                  rst_n,

    // Input interface
    input  logic                  in_valid,
    output logic                  in_ready,
    input  logic [DATA_WIDTH-1:0] in_data,

    // Output interface
    output logic                  out_valid,
    input  logic                  out_ready,
    output logic [DATA_WIDTH-1:0] out_data
);

    // Storage register
    logic [DATA_WIDTH-1:0] data_reg;
    logic                  valid_reg;

    // Ready logic:
    // Can accept new data if pipeline is empty
    // OR if downstream is ready to accept current data
    assign in_ready = ~valid_reg || out_ready;

    // Output assignments
    assign out_valid = valid_reg;
    assign out_data  = data_reg;

    // Sequential logic
    always_ff @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            valid_reg <= 1'b0;
            data_reg  <= '0;
        end else begin
            // Accept new data when handshake occurs
            if (in_valid && in_ready) begin
                data_reg  <= in_data;
                valid_reg <= 1'b1;
            end
            // Clear valid when output handshake occurs without refill
            else if (out_ready && out_valid) begin
                valid_reg <= 1'b0;
            end
        end
    end

endmodule
