# sv-valid-pipeline

Single-stage SystemVerilog pipeline register implementing a standard
valid/ready handshake with correct backpressure handling.

## Overview
This repository contains a synthesizable SystemVerilog implementation of a
single-stage pipeline register. The module sits between an upstream producer
and a downstream consumer and uses a conventional valid/ready protocol to
transfer data reliably.

## Functional Description
- Input data is accepted when both `in_valid` and `in_ready` are asserted.
- Accepted data is stored internally in a single pipeline register.
- Stored data is presented on the output with `out_valid`.
- Data remains stable and `out_valid` stays asserted until the downstream
  logic asserts `out_ready`.
- The design correctly handles backpressure without data loss or duplication.

## Key Features
- Fully synthesizable SystemVerilog (RTL)
- Standard valid/ready handshake semantics
- Proper backpressure handling
- No data loss or duplication
- Clean reset to an empty pipeline state
- Parameterizable data width

## Reset Behavior
- Active-low reset (`rst_n`)
- Clears internal storage and deasserts `out_valid`

## Files
- `rtl/pipeline_reg.sv` – Single-stage pipeline register RTL

## Usage
This module can be used as a building block in pipelined datapaths or
streaming interfaces (e.g., AXI-style designs) where flow control and
backpressure handling are required.

## Author
John Munigala 
