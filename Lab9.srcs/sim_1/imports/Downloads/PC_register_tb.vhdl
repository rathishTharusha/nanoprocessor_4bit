library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity PC_register_tb is
end PC_register_tb;

architecture Behavioral of PC_register_tb is
    component PC_register
        Port ( D : in STD_LOGIC_VECTOR(2 downto 0);
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Y : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

    signal D, Y : STD_LOGIC_VECTOR(2 downto 0);
    signal Res, Clk : STD_LOGIC := '0';
    constant clk_period : time := 10 ns;
begin
    uut: PC_register port map(D, Res, Clk, Y);

    clk_process: process
    begin
        Clk <= '0'; wait for clk_period/2;
        Clk <= '1'; wait for clk_period/2;
    end process;

    stim_proc: process
    begin
        Res <= '1'; wait for 15 ns;
        Res <= '0'; D <= "001"; wait for 10 ns;
        D <= "101"; wait for 10 ns;
        Res <= '1'; wait for 10 ns;
        Res <= '0'; D <= "111"; wait for 10 ns;
        wait;
    end process;
end Behavioral;