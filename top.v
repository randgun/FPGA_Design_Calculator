module seg_clock(clock, ps2_clk, ps2_data, rst, seg_d, seg_w); 
input  clock;     //系统时钟50MHZ晶振输入
input rst;
output seg_d;     //数码管的段选
output seg_w;     //数码管的位选

wire[7:0] seg_d;  //段选8位
wire[3:0] seg_w;  //位选4位
reg [3:0] key;
reg flag;
wire   clk1;      //分频后的时钟1 因为分频器输出为reg类型，故这里用wire
wire   clk2;      //同上
wire [23:0] num_reg1,
wire [23:0] num_reg2,
wire [3:0] opcode;
wire [11:0] num_out;
wire cnt1;
wire cnt2;
wire [3:0] state_nxt;
wire [11:0] result;
wire [11:0] code;
wire [3:0] ps2_byte;

initial   //初始化数据
 begin
  flag = 0;
  
 end

////////////实例化分频模块////////////////
clock_div   clock_div(
                       .clk(clock),
		       .clk_out1(clk1),
		       .clk_out2(clk2)
		     );

////////////实例化ps2模块////////////////
PS2scan    Ps2scan(
                    .clk(clock),
	            .rst_n(rst),
	            .ps2_clk(ps2_clk),
	            .ps2_data(ps2_data),
	            .ps2_byte(ps2_byte)
                  );

////////////实例化数据转换模块////////////	
trans   trans(
                .ps2_byte(ps2_byte),
                .key_value(key)

             );

////////////实例化控制模块///////////////
in_ctrl control(
                  .CLK_1K(clock),
                  .RST(rst),
                  .key_value(key),
                  .flag(flag),
                  .num_result(result),
                  .num_reg1(num_reg1),
                  .num_reg2(num_reg2),
                  .opcode(opcode),
                  .num_out(num_out),
                  .cnt1(cnt1),
                  .cnt2(cnt2),
                  .state_nxt(state_nxt)
                );
 
////////////实例化计算模块///////////////
calculate calculate(
                     .reg_num1(num_reg1),
                     .reg_num2(num_reg2),
                     .sym(opcode),
                     .cnt1(cnt1),
                     .cnt2(cnt2),
                     .result(result)

);

////////////实例化段码转换模块////////////						 
to_code  num_to_code(
                      .data(num_out),
		      .code(code)
		    );

////////////实例化显示模块////////////////								
Display   display(
                   .clk(clk2),
		   .seg(code),		      
		   .seg_d(seg_d),
                   .seg_w(seg_w)
		 );		

always@(ps2_byte)
  flag <= 1;

endmodule
