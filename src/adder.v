module adder
    (
        input [31:0]pc,
        output reg [31:0] pc_next
    );

assign pc_next=pc+1;
endmodule