module control_unit (
    input  [3:0]  opcode,      // [31:28]
    input  [3:0]   func,         // [12:9] في R-type
    output reg        RegDst,
    output reg        ALUSrc,
    output reg        MemtoReg,
    output reg        RegWrite,
    output reg        MemRead,
    output reg        MemWrite,
    output reg        Branch,
    output reg        Jump,
    output reg [3:0]  ALU_Control,
    output reg        PMC_En,
    output reg        JMN_En,
    output reg        SWI_En
);

always @(*) begin
    // Default
    RegDst=0; ALUSrc=0; MemtoReg=0; RegWrite=0; MemRead=0; MemWrite=0;
    Branch=0; Jump=0; ALU_Control=4'b0000;
    PMC_En=0; JMN_En=0; SWI_En=0;

    case (opcode)
        4'b0000: begin                 // R-type فقط
            RegDst   = 1;
            RegWrite = 1;   
            case (func)
                4'b0000: ALU_Control = 4'b0000; // add
                4'b0001: ALU_Control = 4'b0001; // sub
                4'b0010: ALU_Control = 4'b0010; // and
                4'b0011: ALU_Control = 4'b0011; // or
                4'b1000: ALU_Control = 4'b0111; // slt
            endcase
        end

4'b0001: begin // addi
                RegWrite = 1;
                ALUSrc   = 1;
                ALU_Control = 4'b0000; // add
            end

            4'b0010: begin // andi
                RegWrite = 1;
                ALUSrc   = 1;
                ALU_Control = 4'b0010; // and
            end

            4'b0011: begin // lw
                RegWrite = 1;
                MemRead  = 1;
                MemtoReg = 1;
                ALUSrc   = 1;
                ALU_Control = 4'b0000; // add (للـ address)
            end

            4'b0100: begin // sw
                MemWrite = 1;
                ALUSrc   = 1;
                ALU_Control = 4'b0000;
            end

            4'b0101: begin // j
                Jump = 1;
            end

            4'b0110: begin // beq
                Branch = 1;
                ALU_Control = 4'b0001; // sub عشان zero flag
            end

            4'b0111: begin // jmn
                JMN_En = 1;
                Jump   = 1;
            end

            4'b1000: begin // swi
                SWI_En   = 1;
                MemWrite = 1;
                ALUSrc   = 1;
                ALU_Control = 4'b0000;
            end

            4'b1001: begin // pmc
                PMC_En = 1;
                // هنا مش هانكتب في ريجستر عادي، هنعمل logic منفصل
            end

            default: begin
    RegDst=0; ALUSrc=0; MemtoReg=0; RegWrite=0; MemRead=0; MemWrite=0;
    Branch=0; Jump=0; ALU_Control=4'b0000;
    PMC_En=0; JMN_En=0; SWI_En=0;
            end
        endcase
    end
endmodule