module PC(
  input [15:0] in, //adresa curenta
  input clk,rst,w,BRA,STACK_POP,
  output reg [15:0] out //adresa urmatoare
);

always @(negedge clk, negedge rst) begin
  if (!rst) begin
    out <= 16'd0;
  end
  else if (w && STACK_POP) begin 
    #1
    out <= in;
  end
  else if (w && BRA) begin //daca avem branch
    out <= in;
  end
  else begin
    out <= out + 16'd1;//daca nu avem branch trecem la adresa urmatoare
  end
end

endmodule