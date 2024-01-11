module REG_DM_ADDRESS_MUX(
  input [8:0] in_LS_immediate,
  input [8:0] in_SP_val,
  input LOAD,STORE,STACK_PSH,STACK_POP,
  output reg [8:0] in
);

always @(*) begin
  if ((LOAD || STORE) && ~(STACK_PSH || STACK_POP)) //fara stiva
    in <= in_LS_immediate;
  else if (STACK_PSH || STACK_POP) //avem stiva
    in <= in_SP_val;
end

endmodule


