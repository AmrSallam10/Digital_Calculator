module clockDivider #(parameter n = 5 )  (input clk, rst, output reg clk_out);

    reg [31:0]count;
    always @ (posedge(clk), posedge(rst))
     begin
        if (rst)
            begin
                count <= 32'b0;
                clk_out <= 1'b0;
            end
        else
            begin
                if (count == n-1) begin
                    count <= 32'b0;
                    clk_out <= ~clk_out; end
                else begin
                    count <= count + 1;
                    clk_out <= clk_out;
                end
            end
    end
endmodule
