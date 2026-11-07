// có các tính năng như tự sửa lỗi và theo chu kì
module VrRingCounter (
     input CLK, INIT , CNTEN,
     output reg [7:0] Q
);
    always @(posedge CLK) begin
        if (INIT) begin
            Q <= 8'b00000001; // Khởi tạo giá trị ban đầu
        end 
        else if (CNTEN) begin
            Q <= {Q[6:0], &(~Q[6:0])}; //self correcting , dùng cổng AND dể kiểm tra xem có bit nào đang ở mức cao hay không, nếu không thì đặt bit đầu tiên thành 1
        end
    end
endmodule