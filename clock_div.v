module clock_div(clk,clk_out2);
input  clk;
output clk_out2;

reg    clk_out2;
reg [27:0] DIV_cnt2 =0;
parameter  period2=100000;  //100000频率为1000hz

//////////////分频2////////////////
always @ (posedge clk)  
 begin
  DIV_cnt2 <= DIV_cnt2 + 1;
  if(DIV_cnt2 == (period2>>1)-1)//高电平
    clk_out2 <= #1 1'b1;
  else if(DIV_cnt2 == period2-1)//低电平
    begin
	  clk_out2  <= #1 1'b0;
	  DIV_cnt2  <= #1 1'b0;
    end
 end
 
endmodule
