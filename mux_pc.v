module mux_pc_source (
    input [31:0] pc_plus_4,
    input [31:0] branch_target,
    input [31:0] jump_target,
    input [31:0] special_target,  // jmn or pmc
    input [1:0]  sel,              // هتتحكم فيه من control logic خاص
    output reg [31:0] next_pc
);
    always @(*) begin
        case (sel)
            2'b00: next_pc = pc_plus_4;
            2'b01: next_pc = branch_target;
            2'b10: next_pc = jump_target;
            2'b11: next_pc = special_target;
            default: next_pc = pc_plus_4;
        endcase
    end
endmodule