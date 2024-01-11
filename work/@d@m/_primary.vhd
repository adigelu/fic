library verilog;
use verilog.vl_types.all;
entity DM is
    port(
        \in\            : in     vl_logic_vector(15 downto 0);
        addr            : in     vl_logic_vector(8 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        w               : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end DM;
