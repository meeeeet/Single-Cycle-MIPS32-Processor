module shift2 (ShiftIn, ShiftOut);

	input [31:0] ShiftIn;
	output reg [31:0] ShiftOut;
	
	always @(ShiftIn) begin
		ShiftOut = ShiftIn << 0;
	end 
	
endmodule