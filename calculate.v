module calculate(
  input reg_num1,
  input reg_num2,
  input sym,
  input cnt1,
  input cnt2,
  output result
);
  reg a;
  reg b;
  reg [23:0] key1;
  reg [23:0] key2;
  reg [31:0] sum;
  reg [7:0] num;

always @(reg_num2)
begin
  a<=0;
  sum<=0;
  num<=0;
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
  key1<=sum;
  a<=0;
  sum<=0;
  num<=0;
  while(a<cnt2)
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
  key2<=sum;
  
  case (sym)
    8'h61: result <= key1 + key2;
    8'h62: result <= key1 - key2;
    8'h63: result <= key1 * key2;
    8'h64: result <= key1 / key2;
  endcase
end
endmodule
