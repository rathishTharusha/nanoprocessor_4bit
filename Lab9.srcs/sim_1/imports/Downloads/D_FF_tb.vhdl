library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity D_FF_tb is
end D_FF_tb;

architecture Behavioral of D_FF_tb is
    component D_FF
        Port ( D, Res, Clk : in STD_LOGIC;
               Q, Qbar : out STD_LOGIC);
    end component;

    signal D, Res, Clk : STD_LOGIC := '0';
    signal Q, Qbar : STD_LOGIC;
    constant clk_period : time := 10 ns;
begin
    uut: D_FF port map(D, Res, Clk, Q, Qbar);

    clk_process: process
    begin
        Clk <= '0'; wait for clk_period/2;
        Clk <= '1'; wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        Res <= '1'; wait for 75 ns; -- Test reset
        Res <= '0'; D <= '1'; wait for 50 ns; -- Test D=1
        D <= '0'; wait for 50 ns; -- Test D=0
        D <= '1'; wait for 50 ns; -- Test setup time
        Res <= '1'; wait for 50 ns; -- Test reset during operation
        wait;
    end process;
end Behavioral;