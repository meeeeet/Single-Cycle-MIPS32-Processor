module alu(
    input [31:0] a,
    input [31:0] b,
    input [3:0] alu_opcode,
    output reg [31:0] alu_out,
    output zero
);

parameter ALU_AND=4'b0000, //0
          ALU_OR=4'b0001, //1
          ALU_ADD=4'b0010, //2
          ALU_SUB=4'b0110, //6
          ALU_SLT=4'b0111, //7
          ALU_NOR=4'b1100; //12

assign zero=(alu_out==32'd0)? 1:0;

always @(*) begin
    case(alu_opcode)
        ALU_AND: alu_out<=a&b;
        ALU_OR: alu_out<=a|b; 
        ALU_ADD: alu_out<=a+b; 
        ALU_SUB: alu_out<=a-b; 
        ALU_SLT: alu_out<=(a<b)? 1:0;
        ALU_NOR: alu_out<=~(a|b);
        default: alu_out<=a;
    endcase    
end

endmodule