`timescale 1ns/1ps

module register_file_tb;

    // Parameters
    parameter SIZE2 = 5;   // 32 registers
    parameter SIZE4 = 32;  // 32-bit data

    // Signals
    reg clk;
    reg RegWrite;
    reg [SIZE2-1:0] rs, rt, rd;
    reg [SIZE4-1:0] write_data;
    wire [SIZE4-1:0] read_data1, read_data2;

    integer i, file;

    // Instantiate DUT
    register_file #(SIZE2, SIZE4) DUT (
        .clk(clk),
        .RegWrite(RegWrite),
        .rs(rs),
        .rt(rt),
        .rd(rd),
        .write_data(write_data),
        .read_data1(read_data1),
        .read_data2(read_data2)
    );

    // Clock generation
    initial clk = 0;
    always #5 clk = ~clk;  // 10ns period

    // Task: save all registers to file
    task save_regs_to_file;
        begin
            file = $fopen("registers.txt","a"); // append
            $fdisplay(file,"------- Register File -------");
            for (i = 0; i < 32; i = i + 1) begin
                $fdisplay(file,"reg[%0d] = %032b", i, DUT.regs[i]); // 32-bit binary
            end
            $fdisplay(file,"-----------------------------\n");
            $fclose(file);
        end
    endtask

    // Test sequence
    initial begin
        // Initialize
        RegWrite = 0;
        rs = 0; rt = 0; rd = 0; write_data = 0;

        // Wait a bit
        #10;

        // 1️⃣ Write first value to register 3
        RegWrite = 1;
        rd = 3;
        write_data = 32'hAAAA_AAAA;
        #10;
        save_regs_to_file(); // Save after first write

        // 2️⃣ Write second value to register 7
        rd = 7;
        write_data = 32'h5555_5555;
        #10;
        save_regs_to_file(); // Save after second write

        // Disable writing
        RegWrite = 0;
        #10;

        // 3️⃣ Read registers 3 and 7
        rs = 3;
        rt = 7;
        #10;
        $display("Read1: reg3 = %h, reg7 = %h", read_data1, read_data2);
        save_regs_to_file(); // Save after read

        // 4️⃣ Modify register 7
        RegWrite = 1;
        rd = 7;
        write_data = 32'hFFFF_FFFF;
        #10;
        save_regs_to_file(); // Save after modification

        // Disable writing
        RegWrite = 0;
        #10;

        // 5️⃣ Read again registers 3 and 7
        rs = 3;
        rt = 7;
        #10;
        $display("Read2: reg3 = %h, reg7 = %h", read_data1, read_data2);
        save_regs_to_file(); // Save final state

        $stop;
    end

endmodule
