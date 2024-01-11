library verilog;
use verilog.vl_types.all;
entity SE9x16 is
    port(
        \in\            : in     vl_logic_vector(8 downto 0);
        \out\           : out    vl_logic_vector(15 downto 0)
    );
end SE9x16;
