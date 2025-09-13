`default_nettype none

module sky130_dff (
	input  wire d,
	output wire q,
	output wire q_n,
	input  wire clk,
	input  wire rst_n
);

	sky130_fd_sc_hd__dfrbp_2 cell0_I (
`ifdef WITH_POWER
		.VPWR (1'b1),
		.VGND (1'b0),
		.VPB  (1'b1),
		.VNB  (1'b0),
`endif
		.D       (d),
		.Q       (q),
		.Q_N     (q_n),
		.CLK     (clk),
		.RESET_B (rst_n)
	);

endmodule