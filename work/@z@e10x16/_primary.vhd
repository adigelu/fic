library verilog;
use verilog.vl_types.all;
entity ZE10x16 is
    port(
        \in\            : in     vl_logic_vector(9 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end ZE10x16;
