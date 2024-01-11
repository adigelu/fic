module REG_DM_IN_MUX(
  input [15:0] in_X,
  input [15:0] in_Y,
  input [15:0] in_ACC,
  input [15:0] in_PC,
  input X_select,Y_select,ACC_select,PC_select,STORE,
  output reg [15:0] in
);

//selectam de unde punem datele

always @(*) begin
  if (STORE && X_select) //punem din registrul x
    in <= in_X;
  else if (STORE && Y_select) //punem din registrul y
    in <= in_Y;
  else if (STORE && ACC_select) //punem din acumulator
    in <= in_ACC; 
  else if (STORE && PC_select) //scriem in pc cand facem branch
    in <= in_PC;
end

endmodule

