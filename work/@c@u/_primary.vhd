library verilog;
use verilog.vl_types.all;
entity CU is
    port(
        opcode          : in     vl_logic_vector(5 downto 0);
        RA              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        RA_stack        : in     vl_logic_vector(1 downto 0);
        Immediate       : in     vl_logic_vector(8 downto 0);
        ALU             : out    vl_logic;
        BRA             : out    vl_logic;
        COND_BRA        : out    vl_logic;
        COND_BRA_Z      : out    vl_logic;
        COND_BRA_N      : out    vl_logic;
        COND_BRA_C      : out    vl_logic;
        COND_BRA_OF     : out    vl_logic;
        LOAD            : out    vl_logic;
        STORE           : out    vl_logic;
        TR              : out    vl_logic;
        STACK_PSH       : out    vl_logic;
        STACK_POP       : out    vl_logic;
        MOV             : out    vl_logic;
        flag_select     : out    vl_logic;
        ACC_select      : out    vl_logic;
        X_select        : out    vl_logic;
        Y_select        : out    vl_logic;
        PC_select       : out    vl_logic
    );
end CU;
