library verilog;
use verilog.vl_types.all;
entity PCInputDecider is
    port(
        POP_input       : in     vl_logic_vector(15 downto 0);
        BRA_input       : in     vl_logic_vector(15 downto 0);
        STACK_POP       : in     vl_logic;
        BRA             : in     vl_logic;
        PC_in           : out    vl_logic_vector(15 downto 0)
    );
end PCInputDecider;
