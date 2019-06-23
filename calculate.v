module calculate(
input p1,
input p2,
input sym,
output [23:0] result
);
reg a;
reg [7:0] key1;
reg [7:0] key2;

always @(*)
begin
  case (p1)
    8'h30: key1 = 8'h00;    //0
    8'h31: key1 = 8'h01;    //1
    8'h32: key1 = 8'h02;    //2
    8'h33: key1 = 8'h03;    //3
    8'h34: key1 = 8'h04;    //4
    8'h35: key1 = 8'h05;    //5
    8'h36: key1 = 8'h06;    //6
    8'h37: key1 = 8'h07;    //7
    8'h38: key1 = 8'h08;    //8
    8'h39: key1 = 8'h09;    //9
  endcase
  
  case (p2)
    8'h30: key2 = 8'h00;    //0
    8'h31: key2 = 8'h01;    //1
    8'h32: key2 = 8'h02;    //2
    8'h33: key2 = 8'h03;    //3
    8'h34: key2 = 8'h04;    //4
    8'h35: key2 = 8'h05;    //5
    8'h36: key2 = 8'h06;    //6
    8'h37: key2 = 8'h07;    //7
    8'h38: key2 = 8'h08;    //8
    8'h39: key2 = 8'h09;    //9
  endcase
  
  case (sym)
    8'h2b: result = key1 + key2;
    8'h2d: result = key1 - key2;
    8'h2a: result = key1 * key2;
    8'h2f: result = key1 / key2;
  endcase
end
endmodule
