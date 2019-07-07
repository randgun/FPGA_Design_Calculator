module in_ctrl(
input CLK_1K,
input RST,
input [3:0] key_value,
input flag,
input [11:0] num_result,
output [11:0] reg1,
output [11:0] reg2,
output [3:0] opcodedd,
output [11:0] num_out
);
localparam IDLE = 4'b0000;
localparam S0 = 4'b0001;
localparam S1 = 4'b0010;
localparam S2 = 4'b0100;
reg [11:0]num_reg1;
reg [11:0]num_reg2;
assign reg1 = num_reg1;
assign reg2 = num_reg2;
reg [3:0] state_now, next;
reg [3:0] opcode_reg;
reg [3:0] opcode;

reg done;
reg [1:0] flag_in_r;
wire flag_in_pos;
reg flag_1;
assign num_out = reg2 ? reg2 : reg1;
assign opcodedd = opcode;

always@(posedge CLK_1K or negedge RST)
begin
if(~RST)
  state_now <= S0;
else
  state_now <= next;
end

always@(posedge CLK_1K or negedge RST)
begin
  if(~RST)
    begin
      num_reg1 <= 0;
      num_reg2 <= 0;
      opcode_reg <= 0;
      opcode <= 0;
      next <= 4'b0001;
      done<= 0;
    end
    
  else if(flag_1&!done)
    begin
    case(state_now)
    
    S0:if((key_value >= 4'h0)&&(key_value <= 4'h9))
          num_reg1 <= {num_reg1[7:0],key_value};
      else if(key_value>=4'ha && key_value <= 4'hd)
        begin
          next<=S1;
          opcode_reg <= key_value;
        end
     
    S1:if(key_value >= 4'ha && key_value<= 4'hd)
         opcode_reg <= key_value;
       else if(key_value >= 4'h0 && key_value <= 4'h9)
         begin
          num_reg2 <= {num_reg2[7:0],key_value[3:0]};
          opcode<=opcode_reg;
         end
       else if(key_value == 4'he)
         begin
           next <= S2;       
         end
                                
     S2:if(key_value>=4'h0 && key_value<=4'h9)
        begin 
          num_reg2 <= 0;
          opcode_reg <=0;
          num_reg1 <= key_value;
          next <= S0;
        end
        else if((key_value >= 4'ha) && (key_value <= 4'hd))
          begin
            num_reg1 <= num_result;
            num_reg2 <= 0;
         //   opcode_reg <= 0; 
            opcode_reg <= key_value;
            next <= S1;
          end
          
     endcase
     done = 1;
   end
   else if(flag_in_pos)
     done = 0;
end



always@(posedge CLK_1K or negedge RST)
begin
  if(!RST)
    flag_in_r <= 2'b0;
  else
    flag_in_r <= {flag_in_r[0], flag};
end

assign flag_in_pos = ~flag_in_r[1] & flag_in_r[0];

always@(posedge CLK_1K or negedge RST)
begin
  if(!RST)
    flag_1 <= 0;
  else if (flag_in_pos)
  begin
    //done<=0;
    flag_1 <= 1'b1;
  end
  else if(done)
    flag_1 = 0;
  else 
    flag_1 <= flag_1;
end

endmodule
