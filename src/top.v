`include "macros.v"

module top(
    input clk,rst
);
wire [31:0] PC_IN;
wire [31:0] pc_imem,pc_next,Instr_main,ALU_A,Mem_ALU_RD2,ALU_DATA_out,ALU_B;
wire [3:0] ALUCtrl;

wire [4:0] RegDst_MUX;
wire [31:0]SignEx;
wire [31:0] ReadData_Dmem,MemData_RegWrite,ShiftOut;
wire zero;

//ctrl signals
wire Branch,MemRead,MemWrite,MemtoReg,ALUsrc,RegWrite,RegDst;
wire [1:0] ALUOPTOP;

pc program_counter (
    .clk(clk),
    .rst(rst),
    .pc_in(PC_IN),
    .pc_out(pc_imem)
);

pc_adder pa1(
    .pc_in(pc_imem),
    .pc_out(pc_next)
);

instr_mem im1(
    .clk(clk),
    .rst(rst),
    .reg_addr(pc_imem),
    .mem_out(Instr_main)
);

mux_RegDst mux1(
    .Rrd(Instr_main[15:11]),
    .Irt(Instr_main[20:16]),
    .RegDst(RegDst),
    .RegWrite(RegDst_MUX)
);

registers regs(
    .clk(clk),
    .rst(rst), 
    .RegWrite(RegWrite),
    .rs1(Instr_main[25:21]),
    .rs2(Instr_main[20:16]),
    .rd(RegDst_MUX), 
    .write_data(MemData_RegWrite),
    .read_data1(ALU_A),
    .read_data2(Mem_ALU_RD2)
);

sign_extend se1(
    .instr_in(Instr_main[15:0]),
    .out(SignEx)
);

mux_ALUSrc mux2(
    .read_data2(Mem_ALU_RD2),
    .Imm_data(SignEx),
    .ALUSrc(ALUsrc),  //ctrl
    .B(ALU_B)
);

alu a1(
    .a(ALU_A),
    .b(ALU_B),
    .alu_opcode(ALUCtrl),
    .alu_out(ALU_DATA_out),
    .zero(zero)
);

data_mem d1(
    .clk(clk), 
    .rst(rst), 
    .MemWrite(MemWrite), 
    .MemRead(MemRead), 
    .addr(ALU_DATA_out), 
    .write_data(Mem_ALU_RD2), 
    .read_data(ReadData_Dmem)
);

mux_MemtoReg mux3(
    .read_data(ReadData_Dmem),
    .ALURes(ALU_DATA_out),
    .MemtoReg(MemtoReg),  //ctrl
    .out(MemData_RegWrite)
);

shift2 shiftleft2(
    .ShiftIn(SignEx),
    .ShiftOut(ShiftOut)
);

mux_beq mb0(
    .pc_reg(pc_next),
    .shifted(ShiftOut),
    .pc_new(PC_IN),
    .Zero(zero),
    .Branch(Branch)
);

alu_ctrl alu_control( 
    .ALUOp(ALUOPTOP), 
    .func(Instr_main[5:0]), 
    .alu_ctrl(ALUCtrl)
);

control_unit ctrl (
    .rst(rst),
    .Opcode(Instr_main[31:26]), 
    .ALUOp(ALUOPTOP), 
    .Branch(Branch),
    .MemRead(MemRead), 
    .MemtoReg(MemtoReg),
    .MemWrite(MemWrite),
    .ALUSrc(ALUsrc),
    .RegWrite(RegDst)
);

endmodule