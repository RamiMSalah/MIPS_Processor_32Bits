module alu #(
    parameter SIZE2 = 4,   // opcode width
    parameter SIZE4 = 32   // data width
)(
    input  [SIZE4-1:0] x                  ,  
    input  [SIZE4-1:0] y                  ,         
    input  [SIZE2-1:0] opcode             ,       
    output reg [SIZE4-1:0] ALU_result     ,
    output reg ALU_ZEROS
);


    always @(*) begin

        case(opcode)
            4'b0000: ALU_result = x + y;                  // add
            4'b0001: ALU_result = x - y;                  // sub
            4'b0010: ALU_result = x & y;                  // and
            4'b0011: ALU_result = x | y;                  // or
            4'b0101: ALU_result = x & y;                  // andi
            4'b0110: ALU_result = x + y;                  // addi
            4'b1000: ALU_result = (x < y) ? 32'b1 : 32'b0; // slt
            default: ALU_result = 32'b0;                                   // default
        endcase
        if (ALU_result==0) begin
            ALU_ZEROS=1;
        end else
            ALU_ZEROS = 0;
    end

endmodule
