`include "top.v"

module top_tb;
    reg clk,rst;

    top main_cpu (
        .clk(clk),
        .rst(rst)
    );

    initial begin
        clk=0;
        rst=0;
        #11 rst=1;
    end

    initial begin
        repeat (10) #10 clk=~clk;
        $finish;
    end

    initial begin
        $dumpfile("wave.vcd"); 
        $dumpvars;
    end
endmodule