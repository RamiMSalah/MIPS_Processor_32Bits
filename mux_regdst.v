module mux_regdst (
    input      [4:0] rt,      // من الإنستركشن [22:18]
    input      [4:0] rd,      // لو كان فيه R-type (مش مستخدم عندنا)
    input            sel,     // RegDst من الـ Control Unit (هنخليه 0 دايماً)
    output     [4:0] out
);
    assign out = (sel == 1'b1) ? rd : rt;
endmodule