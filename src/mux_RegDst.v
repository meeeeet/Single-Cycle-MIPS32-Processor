module mux_RegDst(Rrd,Irt,RegDst,RegWrite);

    input [15:11] Rrd; //Rs of R-type Instruction
    input [20:16] Irt; //Rt of I-type Instruction
    input RegDst; // Ctrl signal
    output [4:0] RegWrite; // to registers memory

    assign RegWrite=(RegDst)? Rrd:Irt;

endmodule