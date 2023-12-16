// `include "Instructions.mem"
module instr_mem(
    input clk,
    input rst,
    input [31:0] reg_addr,
    output  [31:0] mem_out
);

reg [31:0] mem [0:63];

assign mem_out = mem[reg_addr];

// always @ (negedge clk) begin
//     if(rst) begin
//         mem_out <= mem[reg_addr];
//     end

// Temporary
    // else begin
    //     for (int k=0; k<64; ++k) begin
    //         mem[k]<=32'h00000000;
    //     end
    // end
// end


initial begin
    $readmemh("Instructions.mem",mem,0,5);
    // $display("%h",mem[2]);
end
endmodule