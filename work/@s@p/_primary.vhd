library verilog;
use verilog.vl_types.all;
entity SP is
    port(
        clk             : in     vl_logic;
        rst             : in     vl_logic;
        inc             : in     vl_logic;
        dec             : in     vl_logic;
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end SP;
