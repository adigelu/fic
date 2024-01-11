library verilog;
use verilog.vl_types.all;
entity REG_DM_ADDRESS_MUX is
    port(
        in_LS_immediate : in     vl_logic_vector(8 downto 0);
        in_SP_val       : in     vl_logic_vector(8 downto 0);
        LOAD            : in     vl_logic;
        STORE           : in     vl_logic;
        STACK_PSH       : in     vl_logic;
        STACK_POP       : in     vl_logic;
        \in\            : out    vl_logic_vector(8 downto 0)
    );
end REG_DM_ADDRESS_MUX;
