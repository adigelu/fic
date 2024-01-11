library verilog;
use verilog.vl_types.all;
entity FLAGS is
    port(
        \in\            : in     vl_logic_vector(3 downto 0);
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        w               : in     vl_logic;
        ZERO            : out    vl_logic;
        NEGATIVE        : out    vl_logic;
        CARRY           : out    vl_logic;
        OVERFLOW        : out    vl_logic
    );
end FLAGS;
