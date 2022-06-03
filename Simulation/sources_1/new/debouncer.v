module debouncer(clk, in, out );
    input clk, in;
    output  out;
    reg q1,q2,q3, qsync, qmeta;
   
    always @(posedge clk) begin 
    
        qmeta <= in;
        qsync <= qmeta; 
        
        q1 <= qsync;
        q2 <= q1;
        q3 <= q2;
    end
    
    
    assign out = q1 & q2 & q3;
endmodule