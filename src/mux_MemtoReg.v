module mux_MemtoReg (read_data, ALURes, MemtoReg, out);

    input [31:0] read_data,ALURes;
    input MemtoReg;
    output [31:0]out;
    
    assign B=(MemtoReg)? read_data:ALURes;
    
    endmodule