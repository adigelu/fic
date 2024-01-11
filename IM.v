module IM(
  input [9:0] addr,
  input rst,
  output reg [15:0] out
);

reg [15:0] rom [1023:0]; //1024 de adrese a cate 16 biti fiecare

always @(negedge rst) begin
  if (!rst) begin
    out <= rom[0]; //punem la iesire ce e in memorie la adresa 0
 end
end

always @(*) begin
	 if (rst) begin
		out <= rom[addr]; //punem la iesire ce e in memorie la adresa addr
	 end
end

endmodule
