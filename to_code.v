//////////////数字转换成数码管编码模块//////////////
module num_to_code(num,code,data,rst);
input data;      //输入0-999的数据 
input num;      //十进制位数
input rst
output code;    //输出数据的每一位数码管段码
reg [31:0] data;  
reg [31:0] code;
reg num;
reg [31:0] fuck; 
	
always @ (data)  //当数字变动一次就进行一次转换
  begin
    fuck <= data; 
    if(!rst)
      reg a = 0;
    while(a < num)
      begin
	case(fuck[3:0])
	  4'h0 : code[a*4:+3] <= 8'hc0; //显示"0"
	  4'h1 : code[a*4:+3] <= 8'hf9; //显示"1"
	  4'h2 : code[a*4:+3] <= 8'ha4; //显示"2"
	  4'h3 : code[a*4:+3] <= 8'hb0; //显示"3"
	  4'h4 : code[a*4:+3] <= 8'h99; //显示"4"
	  4'h5 : code[a*4:+3] <= 8'h92; //显示"5"
	  4'h6 : code[a*4:+3] <= 8'h82; //显示"6"
	  4'h7 : code[a*4:+3] <= 8'hf8; //显示"7"
	  4'h8 : code[a*4:+3] <= 8'h80; //显示"8"
	  4'h9 : code[a*4:+3] <= 8'h90; //显示"9"
	  default : code[a*4:+3] <= 8'hff; 
        endcase 
        a = a + 1;
      end
    a = 0;
 end
 
endmodule 
