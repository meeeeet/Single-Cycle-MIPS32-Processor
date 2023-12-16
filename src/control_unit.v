module control_unit(
	input [5:0] Opcode,
	input rst,
	output reg RegDst, RegWrite, ALUSrc,
	output reg MemtoReg, MemRead, MemWrite,
	output reg Branch,
	output reg [1:0] ALUOp);
	
	always @(*) begin
		if (!rst) begin
			RegDst 		<= 0;
			ALUSrc 		<= 0;
			MemtoReg	<= 0;
			RegWrite	<= 0;
			MemRead		<= 0;
			MemWrite	<= 0;
			Branch		<= 0;
			ALUOp		<= 2'b00;
		end
		case(Opcode)
		6'b000000: begin
				RegDst 		<= 1;
				ALUSrc 		<= 0;
				MemtoReg	<= 0;
				RegWrite	<= 1;
				MemRead		<= 0;
				MemWrite	<= 0;
				Branch		<= 0;
				ALUOp		<= 2'b10;
			end
		6'b100011: begin
				RegDst 		<= 0;
				ALUSrc 		<= 1;
				MemtoReg	<= 1;
				RegWrite	<= 1;
				MemRead		<= 1;
				MemWrite	<= 0;
				Branch		<= 0;
				ALUOp		<= 2'b00;
			end
		6'b101011: begin
				RegDst 		<= 0;
				ALUSrc 		<= 1;
				MemtoReg	<= 0;
				RegWrite	<= 0;
				MemRead		<= 0;
				MemWrite	<= 1;
				Branch		<= 0;
				ALUOp		<= 2'b00;
			end
		6'b000100: begin
				RegDst 		<= 0;
				ALUSrc 		<= 0;
				MemtoReg	<= 0;
				RegWrite	<= 0;
				MemRead		<= 0;
				MemWrite	<= 0;
				Branch		<= 1;
				ALUOp		<= 2'b01;
			end
		default: begin
			RegDst 		<= 0;
			ALUSrc 		<= 0;
			MemtoReg	<= 0;
			RegWrite	<= 0;
			MemRead		<= 0;
			MemWrite	<= 0;
			Branch		<= 0;
			ALUOp		<= 2'b00;
		end
		endcase
	end
endmodule
