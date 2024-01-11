module DM(
  input signed [15:0] in,
  input [8:0] addr,
  input clk,rst,w,
  output reg signed [15:0] out
);

reg signed [15:0] ram [511:0]; //memoria de 512 de adrese a cate 16 biti fiecare

always @(negedge rst) begin
  if (!rst) begin
    out <= ram[0]; //scriem din memorie de la adresa 0 la iesire
 end
end

always @(*) begin
  out <= ram[addr]; //scriem din memorie de la adresa addr la iesire
end

always @(negedge clk) begin
  if (w) begin //daca avem enable pt scriere
    ram[addr] <= in; //scriem in memorie datele primite
 end
end

endmodule