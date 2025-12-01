module register_file #(
parameter SIZE2 = 5                            ,  
parameter SIZE4 = 32                           
) (
    input        clk,
    input        RegWrite,     
    input  [SIZE2-1:0] rs,           
    input  [SIZE2-1:0] rt,           
    input  [SIZE2-1:0] rd,           
    input  [SIZE4-1:0] write_data,  
    output [SIZE4-1:0] read_data1, 
    output [SIZE4-1:0] read_data2   
);

    reg [SIZE4-1:0] regs [0:SIZE4-1];

    // synchronous write
    always @(posedge clk) begin
        if (RegWrite)
            regs[rd] <= write_data;
    end


    assign read_data1 = regs[rs];
    assign read_data2 = regs[rt];

endmodule
