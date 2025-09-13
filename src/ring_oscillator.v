`default_nettype none

module ring_oscillator #(
  parameter integer STAGES = 799,
  parameter integer TAP0 = 799,
  parameter integer TAP1 = 599,
  parameter integer TAP2 = 399,
  parameter integer TAP3 = 199
) (
  input wire enable,
  input wire [1:0] feedback_idx,
  output wire ro_out
);

  wire [STAGES-1:0] inv_chain;
  reg feedback_tap;
  wire inv_chain_input = enable & feedback_tap;

  assign ro_out = feedback_tap;

  // Inverter chain
  generate
    genvar i;
    for(i = 0; i < STAGES; i++) 
    begin
    
      wire a = i == 0 ? inv_chain_input : inv_chain[i-1];

    `ifndef SIM
      sky130_inv inv(
        .a(a),
        .y(inv_chain[i])
      );
    `else 
        sim_inv inv(
          .a(inv_chain[i-1]),
          .y(inv_chain[i])
        );
    `endif 
    end
  endgenerate

  // Multiplexer selecting the feedback point
  always @(*) 
  begin
    case(feedback_idx)
        2'b00: feedback_tap = inv_chain[TAP0-1];
        2'b01: feedback_tap = inv_chain[TAP1-1];
        2'b10: feedback_tap = inv_chain[TAP2-1];
        2'b11: feedback_tap = inv_chain[TAP3-1];
        default: feedback_tap = inv_chain[STAGES-1];
    endcase
  end


endmodule 


