//////////////数码管显示模块//////////////
module display(clk, seg, num, seg_d, seg_w);
input seg;                     //输入的2*num位段码数据
input clk;                     //扫描时钟
input num;                     //读取的运算位数
output seg_d;                  //输出到管脚的段码数据
output seg_w;                  //输出到管脚的位选数据

reg[31:0] seg; 
reg[7:0] seg_d;
reg[3:0] seg_w;
reg[7:0] scan_cnt; //位选扫描
reg[7:0] fuck = 8'b00000001;
reg[1:0] cnt = 0;
reg num;

always @ (posedge clk)  //数码管扫描
  begin
    scan_cnt <= scan_cnt+1;
    if (scan_cnt == num)
      scan_cnt <=  0;
  end
 
always @ (scan_cnt)   //数码管位选
  begin
    while(cnt < scan_cnt)
    begin
      fuck = fuck<<1;
      cnt = cnt + 1;
    end
    seg_d = fuck;
    cnt = 0;
    fuck = 8'b00000001;
  end 
 
always @ (scan_cnt)  //数码管显示数据
  begin
    seg_w = seg[4*scan_cnt:+3];
  end
 
endmodule 
