module data_mem(
    clk, rst, MemWrite, MemRead, addr, write_data, read_data
);

input clk,rst,MemWrite, MemRead;
input [31:0] addr, write_data;
output [31:0] read_data;

reg [31:0] Dmemory [0:63];

assign read_data=(MemRead) ? Dmemory[addr] : 32'd0;

always @(negedge clk) begin
    if (!rst) begin
        for (int i=0; i<64; ++i) begin
            Dmemory[i]<=32'd0;
        end
    end

    else if (MemWrite) Dmemory[addr]=write_data;
end

endmodule