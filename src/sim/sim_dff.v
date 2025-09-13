`default_nettype none

module sim_dff (
	input  wire d,
	output reg  q,
	output reg  q_n,
	input  wire clk,
	input  wire rst_n
);

	always @(posedge clk or negedge rst_n)
		if (~rst_n) begin
			q   <= 1'b0;
			q_n <= 1'b1;
		end else begin
			q   <=  d;
			q_n <= ~d;
		end

endmodule