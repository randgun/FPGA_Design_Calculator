module calculate(
  input [11:0]reg_num1,
  input [11:0]reg_num2,
  input sym,
  //input cnt1,
  //input cnt2,
  input clk,
  output result
);
  reg a;
  reg b;
  reg [11:0] key1;
  reg [11:0] key2;
  reg [11:0] sum;
  //reg [7:0] num;
  reg [11:0] binary;
  reg [3:0] Hundreds;
  reg [3:0] Tens;
  reg [3:0] Ones;
  reg [11:0] hh;
  wire [11:0] result; 

assign result = hh;
always @(clk)
begin
  //a<=0;
  sum<=0;
  //num<=0;
  sum <= sum + reg_num1[11:8]
  sum <= sum * 10;
  sum <= (sum + reg_num1[7:4])*10;
  sum <= sum + reg_num1[3:0];
  /*
  while(a<cnt1)
    while(b<4)
      case (b)
        2'b0: num <= num + reg_num1[4*a+b]*1;
        2'b1: num <= num + reg_num1[4*a+b]*2;
        2'b2: num <= num + reg_num1[4*a+b]*4;
        2'b3: num <= num + reg_num1[4*a+b]*8;
      endcase
      b<=b+1;
    end
    case (a)
      2'b0: sum <= sum + num;
      2'b1: sum <= sum + num*10;
      2'b2: sum <= sum + num*100;
      2'b3: sum <= sum + num*1000;
    endcase
    a<=a+1;
  end
  */
  key1<=sum;
  sum<=0;
  sum <= sum + reg_num2[11:8]
  sum <= sum * 10;
  sum <= (sum + reg_num2[7:4])*10;
  sum <= sum + reg_num2[3:0];
  //num<=0;
  /*while(a<cnt2)
    while(b<4)
      case (b)
        2'b0: num <= num + reg_num2[4*a+b]*1;
        2'b1: num <= num + reg_num2[4*a+b]*2;
        2'b2: num <= num + reg_num2[4*a+b]*4;
        2'b3: num <= num + reg_num2[4*a+b]*8;
      endcase
      b<=b+1;
    end
    case (a)
      2'b0: sum <= sum + num;
      2'b1: sum <= sum + num*10;
      2'b2: sum <= sum + num*100;
      2'b3: sum <= sum + num*1000;
    endcase
    a<=a+1;
  end
  */
  key2<=sum;
  //用a、b、c、d、e分别代表加减乘除和等于
  case (sym)
    8'h61: binary <= key1 + key2;
    8'h62: binary <= key1 - key2;
    8'h63: binary <= key1 * key2;
    8'h64: binary <= key1 / key2;
  endcase
end

always@(binary)
  begin
  //set 100's,10's,and 1's to 0
    Hundreds=4'd0;
    Tens=4'd0;
    Ones=4'd0;
    for (i=7;i>=0;i=i-1)
      begin
      //add 3 to columns>=5
        if(Hundreds >= 5)
          Hundreds = Hundreds + 3;
        if(Tens >= 5)
          Tens=Tens+3:
          if(Ones >= 5)
          Ones = Ones+3;
        //shift left one
        Hundreds = Hundreds << 1;
        Hundreds[0] = Tens[3];
        Tens = Tens << 1;
        Tens[0] = Ones[3];
        Ones = Ones <<1;
        Ones[0] = binary[i];
      end
    hh = {Hundreds,Tens,Ones};
end
endmodule
