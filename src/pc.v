module pc(
    input clk, rst,
    output reg [31:0] pc_out,
    input [31:0] pc_in
);

always @(negedge clk) begin
    if (rst==1) pc_out=pc_in;
    else pc_out=32'h00000000;
end

endmodule