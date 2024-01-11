library verilog;
use verilog.vl_types.all;
entity IM is
    port(
        addr            : in     vl_logic_vector(9 downto 0);
        rst             : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end IM;
