module mux_alusrc (
    input      [31:0] read_data2,   // من الـ Register File (rt)
    input      [31:0] sign_ext_imm, // من الـ Sign Extend
    input             sel,          // ALUSrc من الـ Control Unit
    output     [31:0] out
);
    assign out = (sel == 1'b1) ? sign_ext_imm : read_data2;
endmodule