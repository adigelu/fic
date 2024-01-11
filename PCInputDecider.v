module PCInputDecider(
   input [15:0] POP_input,
   input [15:0] BRA_input, //aici punem adresa dupa ce am extins o
   input STACK_POP, BRA,
   output reg [15:0] PC_in
);

always @(*) begin
    if (STACK_POP) begin //se face pop din stiva si se pune in PC
      PC_in <= POP_input; 
    end
    else if (BRA) begin //daca avem branch punem adresa de branch
      PC_in <= BRA_input;
    end
end

endmodule
