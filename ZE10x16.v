module ZE10x16(
  input [9:0] in, //adresa
  output reg [15:0] out //adresa extinsa
);

always @(*) begin
  out <= { {6{1'b0}}, in[9:0] }; //extindem adresa de branch prin concatenarea a 6 biti de 0
end

endmodule

