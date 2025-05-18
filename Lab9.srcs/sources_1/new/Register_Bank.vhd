----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 04:04:28 PM
-- Design Name: 
-- Module Name: Register_Bank - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Register_Bank is
    Port ( Data_in : in STD_LOGIC_VECTOR (3 downto 0);
           RegEn : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           RegSel, RegSelB,  RegSelA : in STD_LOGIC_VECTOR (2 downto 0);
           RegA, RegB, Data : out STD_LOGIC_VECTOR (3 downto 0));
end Register_Bank;

architecture Behavioral of Register_Bank is
    type RegArray is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    signal Registers : RegArray;
begin

-- Hardwire R0 to "0000"
    Registers(0) <= "0000";

    -- Register write process
    process(Clk)
    begin
        if rising_edge(Clk) then
            if Res = '1' then
                Registers <= (others => (others => '0'));
            elsif RegEn /= "000" then
                Registers(to_integer(unsigned(RegEn))) <= Data_in;
            end if;
        end if;
    end process;
    
    RegA <= Registers(to_integer(unsigned(RegSelA)));
    RegB <= Registers(to_integer(unsigned(RegSelB)));
    Data <= Registers(to_integer(unsigned(RegSel)));

end Behavioral;