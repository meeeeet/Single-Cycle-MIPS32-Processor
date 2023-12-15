module instr_mem(
    input rst,
    input [31:0] reg_addr,
    output [31:0] mem_out
);

reg [31:0] mem [0:63];

assign mem_out = mem[reg_addr];

always @ (negedge rst) begin
    for (int k=0; k<64; ++k) begin
        mem[k]<=32'h00000000;
    end
end
endmodule