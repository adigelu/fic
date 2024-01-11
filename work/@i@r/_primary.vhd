library verilog;
use verilog.vl_types.all;
entity IR is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        w               : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0);
        opcode          : out    vl_logic_vector(5 downto 0);
        RA              : out    vl_logic;
        BA              : out    vl_logic_vector(9 downto 0);
        IMM             : out    vl_logic_vector(8 downto 0);
        RA_stack        : out    vl_logic_vector(1 downto 0)
    );
end IR;
