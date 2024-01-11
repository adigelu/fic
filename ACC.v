module ACC(
  input [15:0] in, //datele primite
  input clk,rst,w, //enable pt write
  output reg [15:0] out); //scriem datele primite
  
  always @(negedge clk, negedge rst)
  begin
     if (!rst) begin
        out <= 16'd0;
     end   
   else if (w) begin //daca avem enable pt write
        out <= in; //scriem datele primite in registru
   end
  end
  
endmodule
