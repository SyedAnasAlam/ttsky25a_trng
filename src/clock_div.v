`default_nettype none

module clock_div #(
  parameter integer STAGES = 5,
  parameter integer TAP0 = 5,
  parameter integer TAP1 = 3,
  parameter integer TAP2 = 2,
  parameter integer TAP3 = 1
) (
  input wire clk_in,
  input wire rst_n,
  input wire [1:0] sel,
  output wire clk_out
);

  wire [STAGES-1:0] d;
  wire [STAGES-1:0] q_n;
  wire [STAGES-1:0] clk;
  reg output_tap;

  assign clk_out = output_tap;

  generate
    genvar i;
    
    for(i = 0; i < STAGES; i++) 
    begin
      assign clk[i] = i == 0 ? clk_in : q_n[i-1];

    `ifndef SIM
      sky130_dff dff(
        .d(q_n[i]),
        .q(), // unconnected
        .q_n(q_n[i]),
        .clk(clk[i]),
        .rst_n(rst_n)
      );
    `else 
      sim_dff dff(
        .d(q_n[i]),
        .q(), // unconnected
        .q_n(q_n[i]),
        .clk(clk[i]),
        .rst_n(rst_n)
      );
    `endif       
    end
  endgenerate

    // Multiplexer selecting the feedback point
  always @(*) 
  begin
    case(sel)
        2'b00: output_tap = q_n[TAP0-1];
        2'b01: output_tap = q_n[TAP1-1];
        2'b10: output_tap = q_n[TAP2-1];
        2'b11: output_tap = q_n[TAP3-1];
        default: output_tap = q_n[STAGES-1];
    endcase
  end

endmodule