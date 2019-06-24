module in_ctrl(
input CLK_1K,
input RST,
input [3:0] key_value,
input flag,
input [23:0] num_result,
output reg[23:0] num_reg1,
output reg[23:0] num_reg2,
output reg[3:0] opcode,
output [23:0] num_out
output cnt1,
output cnt2,
output state_nxt
);

localparam IDLE = 4'b000;
localparam S0 = 4'b001;
localparam S1 = 4'b010;
localparam S2 = 4'b100;
assign num_out = num_reg2 ? num_reg2 : num_reg1;
reg [3:0] state_now,state_nxt;
reg [3:0] opcode_reg;
reg delay;

always@(posedge CLK_1K or negedge RST)
begin
if(~RST)
  state_now <= S0;
else
  state_now <= state_nxt;
end

always@(posedge CLK_1K or negedge RSTN)
begin
  if(~RST)
    begin
      num_reg1 <= 0;
      num_reg2 <= 0;
      opcode_reg <= 0;
      opcode <= 0;
      cnt1 = 0;
      cnt2 = 0;
    end
  else if(flag)
   
    case(state_now)
    
    S0:if((key_value >= 4'h0)&&(key_value <= 4'h9))
        begin
          num_reg1 <= {num_reg1[19:0],key_value};
          cnt1 <= cnt1 + 1;
        end
      else if(key_value>=4'ha && key_value <= 4'hd)
        begin
          state_nxt<=S1;
          opcode_reg <= key_value;
        end
      
    S1:if(key_value >= 4'ha && key value<= 4'hd)
        opcode_reg <= key_value;
      else if(key_value >= 4'h0 && key_value <= 4'h9)
        begin
          num_reg2 <= {num_reg2(19:0],key_value[3:0]};
          opcode<=opcode_reg;
          cnt2 <= cnt2 + 1;
        end
      else if(key_value == 4'he)
        begin
         
       //   num_reg2 <= 0;
          opcode_reg <= 0;
          state_nxt <= S2;
          delay = 20;
          while(delay)
            delay = delay - 1;
          num_reg1 <= num_result;
        end
                                
    S2:if(key_value>=4'h0 && key_value<=4'h9)
        begin
          cnt1 <= 1;
          cnt2 <= 0;
          num_reg2 <= 0;
          num_reg1 <= key_value;
          state_nxt <= S0;
        end
   //     else if((key_value >= 4'ha) && (key_value <= 4'hd))
   //       begin
   //         opcode_reg <= key_value;
   //         state_nxt <= S1;
   //       end
    endcase
end
endmodule
