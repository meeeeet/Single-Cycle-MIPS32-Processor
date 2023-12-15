module mux_ALUSrc (read_data2, Imm_data, ALUSrc, B);

input [31:0] read_data2,Imm_data;
input ALUSrc;
output [31:0]B;

assign B=(ALUSrc)? Imm_data:read_data2;

endmodule