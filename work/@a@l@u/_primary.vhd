library verilog;
use verilog.vl_types.all;
entity ALU is
    port(
        ACC             : in     vl_logic_vector(15 downto 0);
        X               : in     vl_logic_vector(15 downto 0);
        Y               : in     vl_logic_vector(15 downto 0);
        Immediate       : in     vl_logic_vector(15 downto 0);
        opcode          : in     vl_logic_vector(5 downto 0);
        en              : in     vl_logic;
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        RA              : in     vl_logic;
        res             : out    vl_logic_vector(15 downto 0);
        flags           : out    vl_logic_vector(3 downto 0)
    );
end ALU;
