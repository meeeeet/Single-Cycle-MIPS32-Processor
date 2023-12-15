module alu_ctrl ( ALUOp_in, func7, func3, alu_ctrl);

input [1:0] ALUOp_in;
input [31:25] func7;
input [14:12] func3;
output reg [3:0] alu_ctrl;

always @ (*) begin
    case({ALUop_in,func7,func3})
     12'b00_xxxxxxx_xxx: alu_ctrl<=4'b0010;
     12'bx1_xxxxxxx_xxx: alu_ctrl<=4'b0110;
     12'b1x_0000000_000: alu_ctrl<=4'b0010;
     12'b1x_0100000_000: alu_ctrl<=4'b0110;
     12'b1x_0000000_111: alu_ctrl<=4'b0000;
     12'b1x_0000000_110: alu_ctrl<=4'b0001;
    endcase
end

endmodule