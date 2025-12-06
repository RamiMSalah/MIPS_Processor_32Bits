module sign_extend (
    input      [17:0] imm_in,      // الـ immediate من الإنستركشن [17:0]
    output     [31:0] imm_out      // النسخة الموسعة signed لـ 32 بت
);

    // لو الـ sign bit (bit 17) = 1 → نملي الباقي بواحدات
    // لو = 0 → نملي بصفرات
    assign imm_out = {{14{imm_in[17]}}, imm_in[17:0]};

    // التفصيل:
    // imm_in[17]   → الـ sign bit
    // {{14{...}}   → نعمل 14 نسخة من الـ sign bit (عشان نوصل من 18 → 32)
    // imm_in[17:0] → الـ 18 بت الأصليين

endmodule