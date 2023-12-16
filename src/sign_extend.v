module sign_extend(instr_in,out);
    input [15:0] instr_in;
    output reg [31:0] out;

    always @(*) begin 
        if(instr_in[15]) out[31:16]<=16'hffff;
        else out[31:16]<=16'h0000;
        out[15:0]<=instr_in; 
    end

endmodule
