module seg_clock(clock, rst, seg_d, seg_w,w_key,val); 
input  clock;     //系统时钟50MHZ晶振输入
input  rst;
input [3:0] val;
input [4:0] w_key;
output seg_d;     //数码管的段选
output seg_w;     //数码管的位选

wire[7:0] seg_d;  //段选8位
wire[3:0] seg_w;  //位选4位
wire [3:0] key;

wire   clk2;      //500HZ时钟
wire [11:0] num_reg1;
wire [11:0] num_reg2;
wire [3:0] opcode;
wire [11:0] num_out;
wire [7:0] result;
wire [23:0] my_code;
wire [3:0] byte;
wire [11:0] p1;
wire [11:0] p2;
wire state;
wire a;

reg cnt;
	always @(posedge clock or negedge rst) begin
		if (!rst) 
			cnt <= 1'b0;
		else 
			cnt <= cnt + 1'b1;
	end
	
	wire clk_50m;
	assign clk_50m = cnt;

////////////实例化分频模块////////////////
clock_div   clock_div(
                       .clk(clk_50m),
		         
		               .clk_out2(clk2)
		     );

////////////实例化ps2模块////////////////
the_key    the_key(
                  .clk(clock),
	                .rst(rst),
	                .val(val),
	                .w_key(w_key),
	                .byte(byte),
	                .state(state),
	                .a(a)
                  );

bcd  bcd2 (
             .b(result),
             .p(p2)
);

////////////实例化控制模块///////////////
in_ctrl control(
                  .CLK_1K(clock),
                  .RST(rst),
                  .key_value(byte),
                  .num_result(p2),
                  .reg1(num_reg1),
                  .reg2(num_reg2),
                  .opcodedd(opcode),
                  .num_out(num_out),
                  .flag(state)
                );
 
////////////实例化计算模块///////////////
calculate calculate(
                     .num_reg1(num_reg1),
                     .num_reg2(num_reg2),
                     .rst(rst),
                     .sym(opcode),
                     .clk(clock),
                     .eval_flag(a),
                     .result(result)

);

////////////实例化段码转换模块////////////						 
num_to_code  to_code(  
                      .my_code(my_code),
                      .my_data(num_out),
                      .rst(rst)
		              
		    );

////////////实例化显示模块////////////////								
display   Display(
                   .clk(clk2),
                   .rst(rst),
		               .seg(my_code),		      
		               .seg_d(seg_d),
                   .seg_w(seg_w)
		 );		

endmodule

