//////////////数字转换成数码管编码模块//////////////
module num_to_code(num,code,data,rst);
input data;      //输入0-999的数据 
input num;      //十进制位数
input rst
output code;    //输出数据的每一位数码管段码
reg [11:0] data;  
reg [11:0] code;
reg num;
reg [31:0] fuck; 
	
always @ (data)  //当数字变动一次就进行一次转换
  begin
    fuck <= data; 
    if(!rst)
      reg a = 0;
    while(a < 3)
      begin
	case(fuck[3:0])
	  4'h0 : code[11:9] <= 8'hfc; //显示"0"
	  4'h1 : code[11:9] <= 8'h60; //显示"1"
	  4'h2 : code[11:9] <= 8'hda; //显示"2"
	  4'h3 : code[11:9] <= 8'hf2; //显示"3"
	  4'h4 : code[11:9] <= 8'h66; //显示"4"
	  4'h5 : code[11:9] <= 8'hb6; //显示"5"
	  4'h6 : code[11:9] <= 8'hbe; //显示"6"
	  4'h7 : code[11:9] <= 8'he0; //显示"7"
	  4'h8 : code[11:9] <= 8'hfe; //显示"8"
	  4'h9 : code[11:9] <= 8'hf6; //显示"9"
	  default : code[11:9] <= 8'h00; 
        endcase 
        a = a + 1;
	code <= code>>4;
	fuck <= fuck<<4;
      end
    a = 0;
 end
 
endmodule 
