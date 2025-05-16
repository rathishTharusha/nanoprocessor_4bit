----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/16/2025 12:51:45 PM
-- Design Name: 
-- Module Name: Register_Bank_tb - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Register_Bank_TB is
end Register_Bank_TB;

architecture Behavioral of Register_Bank_TB is
    component Register_Bank
        Port ( Data_in : in STD_LOGIC_VECTOR (3 downto 0);
               RegEn : in STD_LOGIC_VECTOR (2 downto 0);
               Res : in STD_LOGIC;
               Clk : in STD_LOGIC;
               Data_out_0, Data_out_1, Data_out_2, Data_out_3, 
               Data_out_4, Data_out_5, Data_out_6, Data_out_7 : out STD_LOGIC_VECTOR (3 downto 0));
    end component;

    signal Data_in : STD_LOGIC_VECTOR(3 downto 0) := (others => '0');
    signal RegEn : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal Res : STD_LOGIC := '0';
    signal Clk : STD_LOGIC := '0';
    signal Data_out_0, Data_out_1, Data_out_2, Data_out_3 : STD_LOGIC_VECTOR(3 downto 0);
    signal Data_out_4, Data_out_5, Data_out_6, Data_out_7 : STD_LOGIC_VECTOR(3 downto 0);

    constant CLK_PERIOD : time := 10 ns;

begin
    uut: Register_Bank port map (
        Data_in => Data_in,
        RegEn => RegEn,
        Res => Res,
        Clk => Clk,
        Data_out_0 => Data_out_0,
        Data_out_1 => Data_out_1,
        Data_out_2 => Data_out_2,
        Data_out_3 => Data_out_3,
        Data_out_4 => Data_out_4,
        Data_out_5 => Data_out_5,
        Data_out_6 => Data_out_6,
        Data_out_7 => Data_out_7
    );

    -- Clock generation
    Clk_process: process
    begin
        Clk <= '0';
        wait for CLK_PERIOD/2;
        Clk <= '1';
        wait for CLK_PERIOD/2;
    end process;

    -- Stimulus process
    stim_proc: process
    begin
        -- Reset all registers
        Res <= '1';
        wait for CLK_PERIOD;
        Res <= '0';
        wait for CLK_PERIOD;
        
        -- Test writing to each register
        for i in 0 to 7 loop
            RegEn <= std_logic_vector(to_unsigned(i, 3));
            Data_in <= std_logic_vector(to_unsigned(i+1, 4)); -- Write i+1 to register i
            wait for CLK_PERIOD;
        end loop;
        
        -- Verify all registers hold correct values
        wait for CLK_PERIOD;
        
        -- Test writing to register 0 again with new data
        RegEn <= "000";
        Data_in <= "1010";
        wait for CLK_PERIOD;
        
        -- Test writing to register 5 with new data
        RegEn <= "101";
        Data_in <= "1111";
        wait for CLK_PERIOD;
        
        -- Test reset functionality
        Res <= '1';
        wait for CLK_PERIOD;
        Res <= '0';
        wait for CLK_PERIOD;
        
        -- Test writing to multiple registers without enabling them (should not change)
        Data_in <= "0101";
        RegEn <= "000";
        wait for CLK_PERIOD;
        RegEn <= "001";
        wait for CLK_PERIOD;
        
        -- End simulation
        wait;
    end process;

end Behavioral;