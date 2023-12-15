module registers(
    input clk,rst, RegWrite,
    input [19:15] rs1, // source 2
    input [24:20] rs2, // source 1
    input [11:7] rd, // write addr
    input [31:0] write_data,
    output [31:0] read_data1,
    output [31:0] read_data2
);

reg [31:0] Register [0:31];  //32 Reg, each 32 bit wide

assign read_data1=Register[rs1];
assign read_data2=Register[rs2];

always @ (negedge clk) begin
    // Reset function
    if (!rst) begin
        for (int i=0; i<32; ++i) begin
            Register[i]<=32'd0;
        end
    end

    //writing data
    else if (RegWrite) begin
        Register[rd]<=write_data;
    end
end
endmodule