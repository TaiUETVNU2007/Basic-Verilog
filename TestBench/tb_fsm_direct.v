`timescale 1ns/1ps

module tb_fsm_pipelined_direct ();
    reg  clk;
    reg  rst;
    reg  A;
    wire Z1; 
    fsm_pipelined_lookahead UUT (
        .clk (clk),
        .rst (rst),
        .A   (A),
        .Z1  (Z1) 
    );
    initial begin
        clk = 0;
        forever #5 clk = ~clk;
    end
    task checkZ (
        input integer stepnum,
        input reg     in_a,
        input reg     expectZ
    );
        begin
            A = in_a; 
            @(posedge clk); // Đưa A vào và chờ cạnh lên clock
            #1;             // Chờ 1ns cho logic ổn định hẳn
            if (Z1 !== expectZ) begin
                $display("%t [ERROR] Step %0d: Expected Z1=%b, Got Z1=%b", 
                         $time, stepnum, expectZ, Z1);
                $stop(1);   // Dừng mô phỏng nếu có lỗi
            end
        end
    endtask
    initial begin
        $monitor("Time=%0t ns | rst=%b | A=%b | Z1=%b", $time, rst, A, Z1);
        rst = 1; A = 0;
        #20;
        rst = 0; 
        checkZ(1, 1, 1'b0); 
        checkZ(2, 0, 1'b1); 
        checkZ(3, 0, 1'b0); 
        checkZ(4, 1, 1'b0); 
        checkZ(5, 1, 1'b1); 
        $display("Test Direct oke");
        $finish;
    end
endmodule