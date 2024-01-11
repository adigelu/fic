module ALU(
  input signed [15:0] ACC,X,Y,Immediate,
  input [5:0] opcode,
  input en,clk,rst,RA,
  output reg signed [15:0] res,
  output reg [3:0] flags);
  
  reg [15:0] val_before_op;
  reg sign_before_op, same_sign;
  reg [15:0] rotate_cnt;

  localparam ADD = 6'b001101;
  localparam SUB = 6'b001110;
  localparam LSR = 6'b001111;
  localparam LSL = 6'b010000;
  localparam MUL = 6'b010001;
  localparam DIV = 6'b010010;
  localparam MOD = 6'b010011;
  localparam CMP = 6'b010100;
  localparam INC = 6'b010101;
  localparam DEC = 6'b010110;
  localparam AND = 6'b010111;
  localparam OR  = 6'b011000;
  localparam XOR = 6'b011001;
  localparam NOT = 6'b011010;
  localparam RSR = 6'b011011;
  localparam RSL = 6'b011100;
  localparam FCT = 6'b011101;
  
  always @(negedge rst) begin
    if (!rst) begin
      res <= 16'd0;
      flags <= 4'd0;
    end
end

always @(*) begin
    if (clk && en) begin
      case (opcode)
        ADD: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC + X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC + Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15]) /* overflow */
              flags[0] = 1'd1;
            else
              flags[0] = 1'd0; 
            if (res < val_before_op) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = Immediate + X;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Immediate + Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
LSL: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC << X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC << Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X << Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y << Immediate;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        SUB: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC - X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC - Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > val_before_op) // borrow
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - Immediate;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        LSR: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC >> X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC >> Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X >> Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y >> Immediate;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        MUL: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC * X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC * Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < val_before_op) // carry
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = Immediate * X;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Immediate * Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        DIV: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            if (X == 16'd0)
              res = ACC;
            else
              res = ACC / X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            if (Y == 16'd0)
              res = ACC;
            else
              res = ACC / Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            if (Immediate == 16'd0)
              res = X;
            else
             res = X / Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            if (Immediate == 16'd0)
              res = Y;
            else
             res = Y / Immediate;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        MOD: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            if (X == 16'd0)
              res = ACC;
            else
              res = ACC % X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            if (Y == 16'd0)
              res = ACC;
            else
              res = ACC % Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            if (Immediate == 16'd0)
              res = X;
            else
              res = X % Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            if (Immediate == 16'd0)
              res = Y;
            else
              res = Y % Immediate;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
       DEC: begin
          sign_before_op = 1'b0;
          val_before_op = 16'd1;
          if (RA == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - 16'd1;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       CMP: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC - X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC - Y;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15]) /* overflow */
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > val_before_op) // borrow
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X - Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y - Immediate;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res > val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
        INC: begin
          sign_before_op = 1'b0;
          val_before_op = 16'd1;
          if (RA == 1'd0) begin
            if (1'd0 == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X + 16'd1;
         end
          else begin
            if (1'd0 == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y + 16'd1;
          end
          if (same_sign == 1'd1 && sign_before_op != res[15])
              flags[0] = 1'd1;
        else
              flags[0] = 1'd0; 
            if (res < val_before_op) 
              flags[1] = 1'd1;
            else
              flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
    NOT: begin
          if (RA == 1'd0) begin
            res = ~X;
         end
          else begin
            res = ~Y;
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    AND: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC & X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC & Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X & Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y & Immediate;
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
     OR: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC | X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC | Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X | Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y | Immediate;
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
      XOR: begin
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = ACC ^ X;
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC ^ Y;
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X ^ Immediate;
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y ^ Immediate;
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
     RSR: begin // Rotate right
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[0], res[15:1]}; 
                rotate_cnt = rotate_cnt - 16'd1;
 
           
  end
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC;
            rotate_cnt = Y;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};
              rotate_cnt = rotate_cnt - 16'd1;
  
         
  end
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};  
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[0], res[15:1]};
              rotate_cnt = rotate_cnt - 16'd1;
  
         
  end
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
     RSL: begin // Rotate left
          if (Immediate == 16'd0) begin
          sign_before_op = ACC[15];
          val_before_op = ACC;
          if (RA == 1'd0) begin
            if (ACC[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
              res = ACC;
              rotate_cnt = X;
              while (rotate_cnt > 0) begin
                res = {res[14:0],res[15]}; 
                rotate_cnt = rotate_cnt - 16'd1;
 
           
  end
         end
          else begin
            if (ACC[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = ACC;
            rotate_cnt = Y;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
          end
            flags[0] = 1'd0;
            flags[1] = 1'd0;
            if  (res ==  16'd0) //  zero
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1) /* negative */
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
       end
    else begin
          sign_before_op = Immediate[15];
          val_before_op = Immediate;
          if (RA == 1'd0) begin
            if (Immediate[15] == X[15])
              same_sign = 1'd1;
            else
              same_sign = 1'd0;
            res = X;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
         end
          else begin
            if (Immediate[15] == Y[15])
              same_sign = 1'd1;
          else
              same_sign = 1'd0;
            res = Y;
            rotate_cnt = Immediate;
            while (rotate_cnt > 0) begin
              res = {res[14:0],res[15]}; 
              rotate_cnt = rotate_cnt - 16'd1;
         
  end
          end
             flags[0] = 1'd0;
             flags[1] = 1'd0;
             if  (res ==  16'd0) 
              flags[3] = 1'd1;
          else 
              flags[3] = 1'd0;
            if (res[15] == 1'd1)
              flags[2] = 1'd1;
          else
              flags[2] = 1'd0;
    end
       end
      endcase
    end
  end
  
endmodule