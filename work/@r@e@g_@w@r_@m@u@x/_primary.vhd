library verilog;
use verilog.vl_types.all;
entity REG_WR_MUX is
    port(
        in_ALU          : in     vl_logic_vector(15 downto 0);
        in_MOV          : in     vl_logic_vector(15 downto 0);
        in_DM           : in     vl_logic_vector(15 downto 0);
        in_ACC_TRANSFER : in     vl_logic_vector(15 downto 0);
        ALU             : in     vl_logic;
        MOV             : in     vl_logic;
        LOAD            : in     vl_logic;
        TR              : in     vl_logic;
        \in\            : out    vl_logic_vector(15 downto 0)
    );
end REG_WR_MUX;
