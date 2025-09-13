`default_nettype none

module sky130_inv (
	input  wire a,
  output wire y
);

  sky130_fd_sc_hd__inv_2 sky130_inv (
    .A     (a),
    .Y     (y)
  );

endmodule 