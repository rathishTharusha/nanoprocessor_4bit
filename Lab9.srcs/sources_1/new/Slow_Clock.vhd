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

-- Use a prescaler approach
architecture Behavioral of Slow_Clock is
    constant PRESCALER : integer := 33554432; -- Reduced for simulation
    signal count : integer range 0 to PRESCALER-1 := 0;
    signal clk_div : std_logic := '0';
begin
    process (Clk_in)
    begin
        if rising_edge(Clk_in) then
            if count = PRESCALER-1 then
                clk_div <= not clk_div;
                count <= 0;
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    
    Clk_out <= clk_div;
end Behavioral;
