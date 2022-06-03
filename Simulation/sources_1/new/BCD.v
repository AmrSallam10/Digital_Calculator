module BCD (in, dot, out);
    input [3:0] in;
    input dot;
    output reg [7:0] out;
    always @(*)
     begin
     if (dot) 
         case (in) 
             0 : out = 8'b00000010;
             1 : out = 8'b10011110;
             2 : out = 8'b00100100;
             3 : out = 8'b00001100;
             4 : out = 8'b10011000;
             5 : out = 8'b01001000;
             6 : out = 8'b01000000;
             7 : out = 8'b00011110;
             8 : out = 8'b00000000;
             9 : out = 8'b00001000;
             default : out = 8'b11111111;      
     endcase
     
     else 
        case (in) 
                  0 : out = 8'b00000011;
                  1 : out = 8'b10011111;
                  2 : out = 8'b00100101;
                  3 : out = 8'b00001101;
                  4 : out = 8'b10011001;
                  5 : out = 8'b01001001;
                  6 : out = 8'b01000001;
                  7 : out = 8'b00011111;
                  8 : out = 8'b00000001;
                  9 : out = 8'b00001001;
                  default : out = 8'b11111111;      
          endcase
     end
endmodule 