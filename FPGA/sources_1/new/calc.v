module calculator (clk, rst, B, ssgAnode, ssg);

    input clk, rst;
    input [8:0] B;
    wire [8:0] in;
    wire [7:0] out1, out2, out3, out4, out5, out6, out7, out8;
    wire [31:0] count;
    wire clk_out;

    reg flag, error;
    reg mode = 1, pos;
    wire [8:0] key;
    reg [3:0] num1 = 0, num2 = 0, num3 = 0, num4 = 0;
    reg [13:0] result;
    reg [6:0] n1, n2;
    reg [3:0] dig1, dig2, dig3, dig4;
    reg [1:0] two_bit_counter = 2'b00;

    output reg [3:0] ssgAnode;
    output reg [7:0] ssg;
   
    clockDivider #(50000) QD2 (clk, rst, clk_out, count);     //100Hrz

    debouncer ins0 (clk, B[0], in[0]);
    debouncer ins1 (clk, B[1], in[1]);
    debouncer ins2 (clk, B[2], in[2]);
    debouncer ins3 (clk, B[3], in[3]);
    debouncer ins4 (clk, B[4], in[4]);
    debouncer ins5 (clk, B[5], in[5]);
    debouncer ins6 (clk, B[6], in[6]);
    debouncer ins7 (clk, B[7], in[7]);
    debouncer ins8 (clk, B[8], in[8]);
   
   edge_det ed0 (clk, rst, in[0], key[0]);
   edge_det ed1 (clk, rst, in[1], key[1]);
   edge_det ed2 (clk, rst, in[2], key[2]);
   edge_det ed3 (clk, rst, in[3], key[3]);
   edge_det ed4 (clk, rst, in[4], key[4]);
   edge_det ed5 (clk, rst, in[5], key[5]);
   edge_det ed6 (clk, rst, in[6], key[6]);
   edge_det ed7 (clk, rst, in[7], key[7]);
   edge_det ed8 (clk, rst, in[8], key[8]);
   
   BCD seg1 (num1, 0, out1);
   BCD seg2 (num2, 1, out2);
   BCD seg3 (num3, 0, out3);
   BCD seg4 (num4, 0, out4);
   BCD seg5 (dig1, 0, out5);
   BCD seg6 (dig2, 0, out6);
   BCD seg7 (dig3, 0, out7);
   BCD seg8 (dig4, 0, out8);
   
    
    always @(posedge clk) begin
    if (rst)
    begin
        num1 = 0;
        num2 = 0;
        num3 = 0;
        num4 = 0;
        dig1 = 0;
        dig2 = 0;
        dig3 = 0;
        dig4 = 0;
        result = 0;
        mode = 1;
        error = 0;
        flag = 0;
      end
      else begin
        case (key)
           
            //reset
                
            //incrementation
            9'b100_000_000: if (mode) num1 = (num1 == 4'd9)? 4'd0 : num1 + 4'd1;
            9'b010_000_000: if (mode) num2 = (num2 == 4'd9)? 4'd0 : num2 + 4'd1;
            9'b001_000_000: if (mode) num3 = (num3 == 4'd9)? 4'd0 : num3 + 4'd1;
            9'b000_100_000: if (mode) num4 = (num4 == 4'd9)? 4'd0 : num4 + 4'd1;
           
            //operations
            9'b000_010_000:  //add
                begin
                    flag = 0;
                    error = 0;
                    result = (num1*10 + num2) + (num3*10 + num4);
                    mode = 0;
                end
            9'b000_001_000:  //subtract                              
                begin
                    error = 0;
                    flag =0;
                    flag = (num1*10 + num2 < num3*10 + num4);
                    result = (~flag)? (num1*4'd10 + num2) - (num3*4'd10 + num4):(num3*4'd10 + num4) - (num1*4'd10 + num2);
                    if (flag) pos = (result > 9);
                    mode = 0;
                end
            9'b000_000_100: //multiply
            begin
                flag = 0;
                error = 0;
                result = (num1*4'd10 + num2) * (num3*4'd10 + num4);
                mode = 0;
            end
            9'b000_000_010:  //division
                begin
                    flag = 0;
                    error = (num3*4'd10 + num4 == 0);
                    if (~error)
                        result = (num1*4'd10 + num2) / (num3*4'd10 + num4);
                    mode = 0;
                end
               
            9'b000_000_001: mode = ~mode;  //mode switching
           
        endcase
        end
       
        if (result > 0) 
            dig4 = result %10;
        else dig4 = 4'd0;
        
        if (result > 0) 
            dig3 = (result/10) %10;     
        else dig3 = 4'd0;
       
        if (result > 0)       
            dig2 = (result/100) %10;
        else dig2 = 4'd0;  
        
        if (result > 0) 
            dig1 = (result/1000) %10;  
        else dig1 = 4'd0;
 
   end

    always @(posedge clk_out) begin
        if (mode) begin
            if (two_bit_counter == 2'b00)
                begin
                    ssg = out1;
                    ssgAnode = 4'b1110;
                end
               
                else if (two_bit_counter == 2'b01)
                begin
                    ssg = out2;
                    ssgAnode = 4'b1101;
                end
       
                else if (two_bit_counter == 2'b10)
                begin
                    ssg = out3;
                    ssgAnode = 4'b1011;
                end
       
                else if (two_bit_counter == 2'b11)
                begin
                    ssg = out4;
                    ssgAnode = 4'b0111;
                end
        end
        else
            begin
                if (error)
                    begin
                        if (two_bit_counter == 2'b00)
                        begin
                            ssg = 8'b11110000;
                            ssgAnode = 4'b0111;
                        end
                       
                        else if (two_bit_counter == 2'b01)
                        begin
                            ssg = 8'b00000010;
                            ssgAnode = 4'b1011;
                        end
                       
                        else if (two_bit_counter == 2'b10)
                        begin
                            ssg = 8'b11110000;
                            ssgAnode = 4'b1101;
                        end
                       
                        else if (two_bit_counter == 2'b11)
                        begin
                            ssg = 8'b01100000;
                            ssgAnode = 4'b1110;
                        end
                    end
               
                else
                begin
                    if (two_bit_counter == 2'b00)
                        begin
                            ssg = out5;
                            ssgAnode = 4'b1110;
                        end
                       
                        else if (two_bit_counter == 2'b01)
                        begin
                            ssg = (pos & flag)? 8'b11111101 : out6;
                            ssgAnode = 4'b1101;
                        end
               
                        else if (two_bit_counter == 2'b10)
                        begin
                            ssg = (~pos & flag)? 8'b11111101 : out7;
                            ssgAnode = 4'b1011;
                        end
               
                        else if (two_bit_counter == 2'b11)
                        begin
                            ssg = out8;
                            ssgAnode = 4'b0111;
                        end
                end
            end
       
        two_bit_counter  <= two_bit_counter  + 1;  
    end

endmodule