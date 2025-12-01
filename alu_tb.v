module alu_tb();
    parameter SIZE2 = 4;  // opcode width
    parameter SIZE4 = 32; 
    reg  [SIZE4-1:0] x_tb                  ;  
    reg  [SIZE4-1:0] y_tb                  ;         
    reg  [SIZE2-1:0] opcode_tb             ;       
    reg [SIZE4-1:0] ALU_result_expected;
    reg ALU_ZEROS_expected              ;
    wire [SIZE4-1:0] ALU_result_dut ;
    wire ALU_ZEROS_dut              ;

integer  i;
    alu DUT(
        .x(x_tb),
        .y(y_tb),
        .opcode(opcode_tb),
        .ALU_result(ALU_result_dut),
        .ALU_ZEROS(ALU_ZEROS_dut)
    );
    initial begin
    for(i=0;i<100;i=i+1) begin
        x_tb = $random;
        y_tb = $random;
        opcode_tb = $random %9;
       case(opcode_tb)
            4'b0000: ALU_result_expected = x_tb + y_tb;                  // add
            4'b0001: ALU_result_expected = x_tb  - y_tb;                  // sub
            4'b0010: ALU_result_expected = x_tb & y_tb;                  // and
            4'b0011: ALU_result_expected = x_tb | y_tb;                  // or
            4'b0101: ALU_result_expected = x_tb & y_tb;                  // andi
            4'b0110: ALU_result_expected = x_tb + y_tb;                  // addi
            4'b1000: ALU_result_expected = (x_tb < y_tb) ? 32'b1 : 32'b0; // slt
            default: ALU_result_expected = 32'b0;                                   // default
            endcase
            if(ALU_result_expected == 0) begin
              ALU_ZEROS_expected = 1;
            end else begin
              ALU_ZEROS_expected = 0;
            end
            #10
            if(ALU_result_expected!=ALU_result_dut || ALU_ZEROS_expected!=ALU_ZEROS_dut) begin
              $display("Error-There is Error in the ALU");
              $stop;
            end 
    end
    $display("Your ALU Register is Working Perfect");
    $stop;    
    end
initial begin
    $monitor("X = %d,Y = %d, OPCODE = %d, Expected Result = %d, Actual Result = %d, Expeceted Zero: %b, Actual Zero = %b",x_tb,y_tb,opcode_tb,ALU_result_expected,ALU_result_dut,ALU_ZEROS_expected,ALU_ZEROS_dut);
end

endmodule