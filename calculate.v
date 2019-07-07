module calculate(
  input [11:0]num_reg1,
  input [11:0]num_reg2,
  input[3:0]sym,
  input eval_flag,
  input rst,
  input clk,
  output [7:0 ]result
);

reg flag;
reg [7:0] sum1;
reg [7:0] sum2;
reg [7:0] binary;
reg [1:0]b;

assign result = binary;

always @(posedge clk or negedge rst )
begin
  if(!rst)
    b <= 2'b00;
  else 
b <= {b[0],eval_flag};
end

always @(posedge clk )
begin
    if(eval_flag == 1)

    case (sym)//用a、b、c、d、e分别代表加减乘除和等于
           4'ha: binary <= (num_reg1[11:8]*100+num_reg1[7:4]*10+num_reg1[3:0]) + (num_reg2[11:8]*100+num_reg2[7:4]*10+num_reg2[3:0]);

           4'hb: binary <= (num_reg1[11:8]*100+num_reg1[7:4]*10+num_reg1[3:0]) - (num_reg2[11:8]*100+num_reg2[7:4]*10+num_reg2[3:0]);

           4'hc: binary <= (num_reg1[11:8]*100+num_reg1[7:4]*10+num_reg1[3:0]) * (num_reg2[11:8]*100+num_reg2[7:4]*10+num_reg2[3:0]);

           4'hd: binary <= (num_reg1[11:8]*100+num_reg1[7:4]*10+num_reg1[3:0]) / (num_reg2[11:8]*100+num_reg2[7:4]*10+num_reg2[3:0]);

     default: binary <= binary;
endcase
  
end
endmodule

