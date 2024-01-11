library verilog;
use verilog.vl_types.all;
entity REG_DM_IN_MUX is
    port(
        in_X            : in     vl_logic_vector(15 downto 0);
        in_Y            : in     vl_logic_vector(15 downto 0);
        in_ACC          : in     vl_logic_vector(15 downto 0);
        in_PC           : in     vl_logic_vector(15 downto 0);
        X_select        : in     vl_logic;
        Y_select        : in     vl_logic;
        ACC_select      : in     vl_logic;
        PC_select       : in     vl_logic;
        STORE           : in     vl_logic;
        \in\            : out    vl_logic_vector(15 downto 0)
    );
end REG_DM_IN_MUX;
