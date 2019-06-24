module ps2scan(
	clk, rst_n,
	ps2_clk, ps2_data,
	ps2_byte, ps2_state
    );
	
	input clk;
	input rst_n;
	input ps2_clk;
	input ps2_data;
	output [7:0] ps2_byte;	// ps2扫描值
	output ps2_state;

//捕捉ps2时钟下降沿
reg ps2_clk_r0,ps2_clk_r1,ps2_clk_r2;
wire neg_ps2_clk;
    
always @(posedge clk or negedge rst_n) begin
if (!rst_n)  begin
        ps2_clk_r0 <= 1'b0;
        ps2_clk_r1 <= 1'b0;
        ps2_clk_r2 <= 1'b0;
    end
    else begin
        ps2_clk_r0 <= ps2_clk;
        ps2_clk_r1 <= ps2_clk_r0;
        ps2_clk_r2 <= ps2_clk_r1;
    end    
end // end always
    
assign neg_ps2_clk = ps2_clk_r2 & (~ps2_clk_r1);


// 接受来自PS/2键盘的数据存储器
reg [7:0] ps2_byte_r;        // 来自PS/2的数据寄存器
reg [7:0] temp_data;         // 当前接受数据寄存器
reg [3:0] num;
    
always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
        num <= 4'd0;
        temp_data <= 8'd0;
    end
    else if (neg_ps2_clk) begin
        case (num)
            4'd0: begin
                num <= num + 1'b1;
            end
            4'd1: begin
                num <= num + 1'b1;
                temp_data[0] <= ps2_data;
            end
            4'd2: begin
                num <= num + 1'b1;
                temp_data[1] <= ps2_data;
            end
            4'd3: begin
                num <= num + 1'b1;
                temp_data[2] <= ps2_data;
            end
            4'd4: begin
                num <= num + 1'b1;
                temp_data[3] <= ps2_data;
            end
            4'd5: begin
                num <= num + 1'b1;
                temp_data[4] <= ps2_data;
            end
            4'd6: begin
                num <= num + 1'b1;
                temp_data[5] <= ps2_data;
            end
            4'd7: begin
                num <= num + 1'b1;
                temp_data[6] <= ps2_data;
            end
            4'd8: begin
                num <= num + 1'b1;
                temp_data[7] <= ps2_data;
            end
            4'd9: begin
                num <= num + 1'b1;
            end
            4'd10: begin
                num <= 4'b0;
            end
            default: num <= 4'd0;
        endcase
    end
end 


//通过当前按键状态，判断通码还是断码，并保存在ps2_byte_r的8位寄存器内。
reg key_f0;                // 松键标志位
reg ps2_state_r;        // 当前状态,高电平表示有键按下
    
always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            key_f0 <= 1'b0;
            ps2_state_r <= 1'b0;
            ps2_byte_r <= 8'd0;
        end
        else if (num == 4'd10) begin    // 刚传输一个字节
	    if (temp_data == 8'hf0) // 断码的第一个字节
	    begin 
                key_f0 <= 1'b1;
            end    
            else begin
                if (key_f0) begin    // 存储通码
                    ps2_state_r <= 1'b1;
                    ps2_byte_r <= temp_data;
                    key_f0 <= 1'b0;
                end
                else begin
                    ps2_state_r <= 1'b0;
                    key_f0 <= 1'b0;
                end
            end    
        end
        else    ps2_state_r <= 1'b0;
    end // end always
    

//---------------------------------------
//利用case判断不同的通码，来决定字符的ASCII
    reg [7:0] ps2_ascii;    //接收相应的ascii
    
    always @(posedge clk) 
    begin
        case (ps2_byte_r)
            8'h16: ps2_ascii = 8'h31;    //1
            8'h1e: ps2_ascii = 8'h32;    //2
            8'h26: ps2_ascii = 8'h33;    //3
            8'h25: ps2_ascii = 8'h34;    //4
            8'h2e: ps2_ascii = 8'h35;    //5
            8'h36: ps2_ascii = 8'h36;    //6
            8'h3d: ps2_ascii = 8'h37;    //7
            8'h3e: ps2_ascii = 8'h38;    //8
            8'h46: ps2_ascii = 8'h39;    //9
            8'h45: ps2_ascii = 8'h30;    //0                      
            8'h5a: ps2_ascii = 8'h0a;    //enter

            default    ps2_ascii = 8'hfe;
        endcase    
    end
    
    assign ps2_byte = ps2_ascii;
    assign ps2_state = ps2_state_r;

endmodule
