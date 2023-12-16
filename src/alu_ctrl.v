module alu_ctrl ( ALUOp, func, alu_ctrl);

input [1:0] ALUOp;
input [5:0] func;
output reg [3:0] alu_ctrl;

always @(ALUOp, func) begin
	if(ALUOp == 0)
		alu_ctrl <= 2;    //LW and SW use add
	else if(ALUOp == 1)
		alu_ctrl <= 6;		// branch use subtract
	else
		case(func)
			32: alu_ctrl <= 2; //add
			34: alu_ctrl <= 6; //subtract		
			36: alu_ctrl <= 0; //and	
			37: alu_ctrl <= 1; //or	
			39: alu_ctrl <= 12; //nor
			42: alu_ctrl <= 7; //slt
			default: alu_ctrl <= 15; //should not happen
		endcase
	end

endmodule