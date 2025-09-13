/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_saa_trng (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);

  // All output pins must be assigned. If not used, assign to 0.
  //assign uo_out  = ui_in + uio_in;  // Example: ou_out is the sum of ui_in and uio_in
  assign uio_out = 0;
  assign uio_oe  = 0;

  assign uo_out[0] = random_bit;
  assign uo_out[1] = slow_oscillator;
  assign uo_out[2] = fast_oscillator;
  assign uo_out[7:3] = 0;

  wire [1:0] clk_div_sel = ui_in[1:0];
  wire [1:0] ro_feedback_sel = ui_in[3:2];
  wire ro_enable = ui_in[4];

  wire fast_oscillator;
  wire slow_oscillator;
  wire random_bit;

   clock_div#(
    .STAGES(5)
   )
   clk_div (
    .clk_in(clk),
    .rst_n(rst_n),
    .sel(clk_div_sel),
    .clk_out(fast_oscillator)
   );

  ring_oscillator#(
    .STAGES(799),
    .TAP0(799),
    .TAP1(599),
    .TAP2(399),
    .TAP3(199)
  )
  ro (
    .enable(ro_enable),
    .feedback_idx(ro_feedback_sel),
    .ro_out(slow_oscillator)
  );

`ifndef SIM
  sky130_dff dff(
    .d(fast_oscillator),
    .q(random_bit),
    .q_n( ), // unconencted
    .clk(slow_oscillator),
    .rst_n(rst_n)
  );
`else
`endif

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, ui_in[7:5], 1'b0};

endmodule
