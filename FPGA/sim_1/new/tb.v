`timescale 1ns / 1ps

module calc_tb();
    reg clk, rst;
    reg [8:0] B;
    wire [7:0] ssg;
    wire [3:0] ssgAnode;
    wire  [13:0] result;
    integer i;
    wire  [6:0] n1, n2;
    
    calculator dut(clk, rst, B, ssgAnode, ssg, result, n1, n2);
    initial begin
        clk=0;
               rst=0; #10;
         rst=1; #10;
           rst=0;
        forever #5 clk=~clk;
    end
    
    initial begin
           B=0; #10;
           B[0]=1;
            for(i=0;i<10;i=i+1) begin
                B = 9'b111100000; #10;
                B = 0; #10;
            end
            #20;
            B[2]=1; #10;  //multiply
            B[2]=0;
            B[4]=1; #10;   //add
            B[4]=0;
            B[3]=1; #10;  //sub
            B[3]=0;
            B[1]=1; #10;  //div
            B[1]=0;
            B=0; #10;
            B[0]=1; #10; //return to input
    
           /////////
            for(i=0;i<9;i=i+1) begin
                B= 9'b000100001; #10;
                B=0; #10;
            end
            #20;
            B[3]=1; #10; //sub
            B[3]=0;
            B[1]=1; #10; //div
            B[1]=0;
            B[0]=1; #10;
            B=0; #10;
           ////////
            for(i=0;i<3;i=i+1) begin
                B= 9'b110000001; #10;
                B=0; #10;
            end
            B[8]=1; #10;
            B=0; #10;
            #20;
            B[3]=1; #10; //sub
            B[3]=0;
            B[1]=1; #10; //div
            B[1]=0;
            B[2]=1; #10; //mul
            B[2]=0;
            B[0]=1; #10;
            B=0; #10;
            ////////////////////////
            for(i=0;i<2;i=i+1) begin
            B= 9'b001100000; #10;
            B=0; #10;
            end
            #20;
            B[1]=1; #10;
            B[1]=0;
            B=0; #10;
    
    end
          
endmodule