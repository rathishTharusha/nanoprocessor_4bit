----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 11:20:45 AM
-- Design Name: 
-- Module Name: Slow_Clock - Behavioral
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

entity Slow_Clock is
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end Slow_Clock;

architecture Behavioral of Slow_Clock is
    constant MAX_COUNT : integer := 24999999; 
    signal count : unsigned(24 downto 0) := (others => '0'); 
    signal clk_status : std_logic := '0';
begin
    process (Clk_in)
    begin
        if rising_edge(Clk_in) then
            if count = MAX_COUNT then
                clk_status <= not clk_status;
                count <= (others => '0');
            else
                count <= count + 1;
            end if;
        end if;
    end process;

    -- Direct assignment of output
    Clk_out <= clk_status;
end Behavioral;