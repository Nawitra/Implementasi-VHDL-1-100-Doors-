library ieee;
use ieee.std_logic_1164.all;

entity tb_doors is
end tb_doors;

architecture tb of tb_doors is

    component doors
        port (CLK    : in std_logic;
              RST    : in std_logic;
              OUTPUT : inout std_logic_vector (1 to 100) := (others => '0'));
    end component;

    signal CLK    : std_logic;
    signal RST    : std_logic;
    signal OUTPUT : std_logic_vector (1 to 100) := (others => '0');

    constant TbPeriod : time := 1000 ns; 
    signal TbClock : std_logic := '0';
    signal TbSimEnded : std_logic := '0';

begin

    dut : doors
    port map (CLK    => CLK,
              RST    => RST,
              OUTPUT => OUTPUT);

    TbClock <= not TbClock after TbPeriod/2 when TbSimEnded /= '1' else '0';

    stimuli : process
    begin
 
        CLK <= '0';

        RST <= '1';
        wait for 100 ns;
        RST <= '0';
        wait for 100 ns;
        wait for 100 * TbPeriod;


        TbSimEnded <= '1';
        wait;
    end process;

end tb;

configuration cfg_tb_doors of tb_doors is
    for tb
    end for;
end cfg_tb_doors;