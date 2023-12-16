module mux_beq(pc_reg, shifted, Zero, Branch, pc_new);
    input [31:0] pc_reg, shifted;
    output [31:0] pc_new;
    input Zero,Branch;

    wire sel;

    assign sel=Zero&Branch;

    assign pc_new=(sel)? (shifted+pc_reg) : pc_reg;
endmodule