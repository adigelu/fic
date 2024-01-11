module FLAGS(
  input [3:0] in,
  input clk,rst,w,
  output reg ZERO,NEGATIVE,CARRY,OVERFLOW
);

//initializarea flag-urilor
always @(negedge rst) begin
    if (!rst) begin
      ZERO <= 1'd0;
      NEGATIVE <= 1'd0;
      CARRY <= 1'd0;
      OVERFLOW <= 1'd0;   
   end
end

//se seteaza flag-urile
always @(*) begin
  if (clk && w) begin
      ZERO <= in[3];
      NEGATIVE <= in[2];
      CARRY <= in[1];
      OVERFLOW <= in[0];
   end
end

endmodule
