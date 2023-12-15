`include "pc.v"
`include "instr_mem.v"
`include "Reg.v"
`include "alu.v"

module top(
    input clk,rst
);

wire [31:0] pc_imem,instr_out,Mem_ALU_RD1,Mem_ALU_RD2,ALU_DATA_out;
wire [3:0] ALUCtrl;
wire [1:0] ALUOPTOP;

wire Branch,MemRead,MemWrite,MemtoReg,ALUsrc,RegWrite;
pc program_counter (
    .clk(clk),
    .rst(rst),
    .pc_in(),
    .pc_out(pc_imem)
);

instr_mem imem (
    .rst(rst),
    .reg_addr(pc_imem),
    .mem_out(instr_out)
);

mux_RegDst mux1(
    .Rrd(),
    .Irt(),
    .RegDst(),
    .regwrite()
);

registers regs(
    .clk(clk),
    .rst(rst), 
    .RegWrite(RegWrite),
    .rs1(instr_out[19:15]),
    .rs2(instr_out[24:20]),
    .rd(instr_out[11:7]), 
    .write_data(ALU_DATA_out),
    .read_data1(Mem_ALU_RD1),
    .read_data2(Mem_ALU_RD2)
);



alu a1(
    .a(Mem_ALU_RD1),
    .b(Mem_ALU_RD2),
    .alu_opcode(ALUCtrl),
    .alu_out(ALU_DATA_out),
    .zero()
)

data_mem d1(
    .clk(clk), 
    .rst(rst), 
    .MemWrite(MemWrite), 
    .MemRead(MemRead), 
    .addr(ALU_DATA_out), 
    .write_data(), 
    .read_data()
);

alu_ctrl alu_control( 
    .ALUOp_in(ALUOPTOP), 
    .func7(instr_out[31:25]), 
    .func3(instr_out[14:12]), 
    .alu_ctrl(ALUCtrl)
);

control_unit ctrl (
    .Opcode(instr_out[7:0]), 
    .ALUop(ALUOPTOP), 
    .Branch(),
    .MemRead(), 
    .MemtoReg(),
    .MemWrite(),
    .ALUsrc(),
    .RegWrite()
);

endmodule