//////////////数码管显示模块//////////////
module display(clk, seg, seg_d, seg_w,rst);
input seg;                     //输入的23位段码数据
input clk;                     //扫描时钟
input rst;                     //读取复位信号
output [7:0]seg_d;              //输出到管脚的段码数据
output [3:0]seg_w;             //输出到管脚的位选数据

wire[23:0] seg; 
reg[7:0] seg_d0;
reg[3:0] seg_w0;
reg[3:0] scan_cnt; //位选扫描

wire[7:0] seg1,seg2,seg3; 

assign seg_d = seg_d0;
assign seg_w = seg_w0;

assign seg3 = seg[23:16];
assign seg2 = seg[15:8];
assign seg1 = seg[7:0];
  
always @ (posedge clk or negedge rst)  //数码管扫描
 begin
  if(!rst)
    scan_cnt <= 0;
  else
    begin
      scan_cnt <= scan_cnt+1;
      if (scan_cnt == 3'd3)
        scan_cnt <=  0;
    end
 end
  
always @ (scan_cnt)   //数码管位选
 begin
  case (scan_cnt)
    3'd0 : seg_w0 = 4'b0100;
    3'd1 : seg_w0 = 4'b0010;
	3'd2 : seg_w0 = 4'b0001;
	default :seg_w0 = 4'b0000;
  endcase
 end 
  
always @ (scan_cnt)  //数码管显示数据
 begin
  case (scan_cnt)
    3'd0 : seg_d0 = seg3; 
	3'd1 : seg_d0 = seg2;
	3'd2 : seg_d0 = seg1;
	default :seg_d0 = 8'h00;
  endcase  
 end

endmodule 
