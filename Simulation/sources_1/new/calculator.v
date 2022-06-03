module calculator (clk, rst, B, result, n1, n2, mode, neg, out1, out2, out3, out4, out5, out6, out7, out8);

    input clk, rst;
    input [8:0] B;
    output reg [6:0] n1, n2;
    output reg [13:0] result;
     reg [3:0] ssgAnode;
     reg [7:0] ssg;
    output reg mode; 
    
    wire [8:0] in;
    output wire [7:0] out1, out2, out3, out4, out5, out6, out7, out8;
    wire clk_out;
    wire [8:0] key;

    output reg neg;
    reg error;
    reg  pos;
    reg [3:0] num1, num2, num3, num4;
    reg [3:0] dig1, dig2, dig3, dig4;
    reg [1:0] two_bit_counter = 2'b00;
    

    clockDivider #(50000) QD2 (clk, rst, clk_out);     //100Hrz

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
   

    always @(posedge clk) 
    begin
        if (rst)
            begin
                num1 = 0;
                num2 = 0;
                num3 = 0;
                num4 = 0;
                result = 0;
                mode = 1;
                error = 0;
                neg = 0;
            end
      else 
          begin
          
            //incrementation  
            if (B[8]) if (mode) num1 = (num1 == 4'd9)? 4'd0 : num1 + 4'd1;
            if (B[7]) if (mode) num2 = (num2 == 4'd9)? 4'd0 : num2 + 4'd1;
            if (B[6]) if (mode) num3 = (num3 == 4'd9)? 4'd0 : num3 + 4'd1;
            if (B[5]) if (mode) num4 = (num4 == 4'd9)? 4'd0 : num4 + 4'd1;
               
            //operations
            if (B[4])  //add
                begin
                    neg = 0;
                    error = 0;
                    result = (num1*'d10 + num2) + (num3*'d10 + num4);
                    mode = 0;
                end
            if (B[3])  //subtract                              
                begin
                    error = 0;
                    neg =0;
                    neg = (num1*'d10 + num2 < num3*'d10 + num4);
                    result = (~neg)? (num1*4'd10 + num2) - (num3*4'd10 + num4):(num3*4'd10 + num4) - (num1*4'd10 + num2);
                    if (neg) pos = (result > 'd9);
                    mode = 0;
                end
            if (B[2]) //multiply
            begin
                neg = 0;
                error = 0;
                result = (num1*4'd10 + num2) * (num3*4'd10 + num4);
                mode = 0;
            end
            if (B[1])  //division
                begin
                    neg = 0;
                    error = (num3*4'd10 + num4 == 0);
                    if (~error)
                        result = (num1*4'd10 + num2) / (num3*4'd10 + num4);
                    mode = 0;
                end
               
                if (B[0]) mode = ~mode;  //mode switching           
            end
       
        n1 = num1*4'd10 + num2;
        n2 = num3*4'd10 + num4; 
             
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

    always @(posedge clk_out) 
    begin
        if (mode) 
            begin
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
                            ssg = (pos & neg)? 8'b11111101 : out6;
                            ssgAnode = 4'b1101;
                        end
               
                        else if (two_bit_counter == 2'b10)
                        begin
                            ssg = (~pos & neg)? 8'b11111101 : out7;
                            ssgAnode = 4'b1011;
                        end
               
                        else if (two_bit_counter == 2'b11)
                        begin
                            ssg = out8;
                            ssgAnode = 4'b0111;
                        end
                end
            end
       
        two_bit_counter  <= two_bit_counter  + 'd1;  
    end

endmodule
