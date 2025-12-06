module mux_memtoreg (
    input      [31:0] alu_result,    // من الـ ALU
    input      [31:0] mem_data,      // من الـ Data Memory (لما lw)
    input             sel,           // MemtoReg من الـ Control Unit
    output     [31:0] out
);
    assign out = (sel == 1'b1) ? mem_data : alu_result;
endmodule