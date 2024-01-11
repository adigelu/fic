module SP(
  input clk,rst,inc,dec,
  output reg [15:0] out);
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'b0000000111111111;
     end   
   else if (dec) begin //op de decrementare a sp-ului este asociată cu adăugarea de date pe stivă (push)
        out <= out - 16'd1;
   end 
  end
  
  always @(posedge clk) begin
    #1
    if (inc && out < 16'b0000000111111111) begin //op de incrementare este asociată cu eliminarea datelor de pe stivă (pop)
        out <= out + 16'd1;  
   end
  end
  
endmodule
