module edge_det(clk, rst, level, tick);

    input clk, rst, level;
    output reg tick;
    reg [1:0] state, nextState;
    parameter [1:0] zero = 2'b00, ed = 2'b01, one = 2'b10;
    
    always @(level, state) begin
        case (state)
            zero: nextState = level? ed : zero;
            ed: nextState = level? one : zero;
            one: nextState = level? one : zero;
            default: nextState = 2'bxx;
        endcase
        
        if (state == ed) tick = 1;
        else tick = 0;
        
    end
        
        always @(posedge clk, posedge rst) begin
            if (rst)
                state <= zero;
            else
                state <= nextState;
         end

endmodule
