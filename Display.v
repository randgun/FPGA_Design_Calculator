//////////////数码管显示模块//////////////
module display(clk, seg, num, seg_d, seg_w);
input seg;                     //输入的2*num位段码数据
input clk;                     //扫描时钟
input num;                     //读取的运算位数
output seg_d;                  //输出到管脚的段码数据
output seg_w;                  //输出到管脚的位选数据

reg[23:0] seg; 
reg[7:0] seg_d;
reg[3:0] seg_w;
reg[7:0] scan_cnt; //位选扫描
reg num;
  
wire[7:0] seg1,seg2,seg3; 
reg[7:0] seg_d;
reg[3:0] seg_w;
reg[3:0] scan_cnt; //位选扫描

assign seg3 = seg[23:16];
assign seg2 = seg[15:8];
assign seg1 = seg[7:0];
  
always @ (posedge clk)  //数码管扫描
 begin
  scan_cnt = scan_cnt+1;
   if (scan_cnt == 3'd3)
   scan_cnt <=  0;
 end
  
always @ (scan_cnt)   //数码管位选
 begin
  case (scan_cnt)
    3'd0 : seg_w <= 4'b0100;
	  3'd1 : seg_w <= 4'b0010;
	  3'd2 : seg_w <= 4'b0001;
	  default :seg_w <= 4'b0000;
  endcase
 end 
  
always @ (scan_cnt)  //数码管显示数据
 begin
  case (scan_cnt)
    3'd0 : seg_d<=seg3; //
	  3'd1 : seg_d<=seg2;//
	  3'd2 : seg_d<=seg1;
	  default :seg_d <= 8'h00;
  endcase  
 end

/*
always @ (posedge clk)  //数码管扫描
  begin
    scan_cnt <= scan_cnt+1;
    if (scan_cnt == num)
      scan_cnt <=  0;
  end
 
always @ (scan_cnt)   //数码管位选
  begin
    if(!rst)
      begin
        reg cnt <= 0;
        reg[7:0] fuck <= 8'b00000001;
      end
    while(cnt < scan_cnt)
      begin
        fuck <= fuck<<1;
        cnt <= cnt + 1;
      end
    seg_d <= fuck;
    cnt <= 0;
    fuck <= 8'b00000001;
  end 
 
always @ (scan_cnt)  //数码管显示数据
  begin
    seg_w <= seg[4*scan_cnt:+3];
  end
  */
endmodule 
