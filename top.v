module top(
  input clk, rst
);

wire [15:0] PC_value;
wire [15:0] instruction_from_mem;
wire [15:0] current_instruction;
wire [5:0] current_instruction_opcode;
wire current_instruction_RA;
wire [1:0] current_instruction_RA_stack;
wire [8:0] current_instruction_immediate;
wire [9:0] current_instruction_BA;
wire signed [15:0] ACC_value;
wire signed [15:0] X_value;
wire signed [15:0] Y_value;
wire [15:0] SP_value;
wire ALU, BRA, COND_BRA, COND_BRA_Z, COND_BRA_N, COND_BRA_C, COND_BRA_OF, LOAD, STORE, TR, STACK_PSH, STACK_POP, MOV, flag_select, ACC_select, X_select, Y_select, PC_select;
wire signed [15:0] ALU_result;
wire [3:0] ALU_flags;
wire ZERO_flag, NEGATIVE_flag, CARRY_flag, OVERFLOW_flag;
wire [15:0] Extended_Immediate;
wire [15:0] Extended_BranchAddress;
wire [15:0] REG_input;
wire [15:0] DM_input;
wire [8:0] DM_addr;
wire [15:0] DM_output;
wire [15:0] PC_input;
PC ProgramCounter(.in(PC_input),.clk(clk),.rst(rst), .BRA(BRA), .STACK_POP(STACK_POP), .w((PC_select & !STORE) | (BRA & ~COND_BRA) | (COND_BRA & COND_BRA_Z & ZERO_flag) | (COND_BRA & COND_BRA_N & NEGATIVE_flag) | (COND_BRA & COND_BRA_C & CARRY_flag) | (COND_BRA & COND_BRA_OF & OVERFLOW_flag)),.out(PC_value));
IM InstructionMemory(.addr(PC_value[9:0]),.rst(rst),.out(instruction_from_mem));
IR InstructionRegister(.in(instruction_from_mem),.clk(clk),.rst(rst),.w(1'd1),.out(current_instruction),.opcode(current_instruction_opcode),.RA(current_instruction_RA),.RA_stack(current_instruction_RA_stack),.IMM(current_instruction_immediate),.BA(current_instruction_BA));
CU ControlUnit(.opcode(current_instruction_opcode),.RA(current_instruction_RA),.RA_stack(current_instruction_RA_stack),.Immediate(current_instruction_immediate),.clk(clk),.rst(rst),.ALU(ALU),.BRA(BRA),.COND_BRA(COND_BRA),.COND_BRA_Z(COND_BRA_Z),.COND_BRA_N(COND_BRA_N),.COND_BRA_C(COND_BRA_C),.COND_BRA_OF(COND_BRA_OF),.LOAD(LOAD),.STORE(STORE),.TR(TR),.STACK_PSH(STACK_PSH),.STACK_POP(STACK_POP),.MOV(MOV),.flag_select(flag_select),.ACC_select(ACC_select),.X_select(X_select),.Y_select(Y_select),.PC_select(PC_select));
ACC Acumulator(.in(REG_input),.clk(clk),.rst(rst),.w(ACC_select & !STORE),.out(ACC_value));
X Xreg(.in(REG_input),.clk(clk),.rst(rst),.w(X_select & !STORE),.out(X_value));
Y Yreg(.in(REG_input),.clk(clk),.rst(rst),.w(Y_select & !STORE),.out(Y_value));
REG_WR_MUX RegisterWriteDecider(.in_ALU(ALU_result),.in_MOV(Extended_Immediate),.in_DM(DM_output),.in_ACC_TRANSFER(ACC_value),.ALU(ALU),.MOV(MOV),.LOAD(LOAD),.TR(TR),.in(REG_input));
ALU ArithmeticLogicUnit(.ACC(ACC_value),.X(X_value),.Y(Y_value),.Immediate(Extended_Immediate), .opcode(current_instruction_opcode),.en(ALU),.clk(clk),.rst(rst),.RA(current_instruction_RA),.res(ALU_result),.flags(ALU_flags));
FLAGS FlagsRegister(.in(ALU_flags),.clk(clk),.rst(rst),.w(flag_select),.ZERO(ZERO_flag),.NEGATIVE(NEGATIVE_flag),.CARRY(CARRY_flag),.OVERFLOW(OVERFLOW_flag));
SE9x16 ImmediateExtender(.in(current_instruction_immediate),.out(Extended_Immediate));
REG_DM_IN_MUX DataMemoryInputDecider(.in_X(X_value),.in_Y(Y_value),.in_ACC(ACC_value),.in_PC(PC_value),.X_select(X_select),.Y_select(Y_select),.ACC_select(ACC_select),.PC_select(PC_select),.STORE(STORE),.in(DM_input));
DM DataMemory(.in(DM_input),.addr(DM_addr),.clk(clk),.rst(rst),.w(STORE),.out(DM_output));
SP StackPointer(.clk(clk),.rst(rst),.inc(STACK_POP),.dec(STACK_PSH),.out(SP_value));
REG_DM_ADDRESS_MUX DataMemoryAddressDecider(.in_LS_immediate(current_instruction_immediate),.in_SP_val(SP_value[8:0]),.LOAD(LOAD),.STORE(STORE),.STACK_PSH(STACK_PSH),.STACK_POP(STACK_POP),.in(DM_addr));
ZE10x16 BranchAddressExtender(.in(current_instruction_BA),.out(Extended_BranchAddress));
PCInputDecider PCInputDecider(.POP_input(REG_input),.BRA_input(Extended_BranchAddress),.STACK_POP(STACK_POP),.BRA(BRA),.PC_in(PC_input));

endmodule