module mux_swi_rs (
    input      [31:0] original_rs,
    input      [31:0] incremented_rs,  // original_rs + imm
    input             swi_en,
    output     [31:0] new_rs_value
);
    assign new_rs_value = (swi_en) ? incremented_rs : original_rs;
endmodule