----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 07:04:58 PM
-- Design Name: 
-- Module Name: Flag_Bank - Behavioral
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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Flag_Bank is
    Port ( Zero_in : in STD_LOGIC;
           Overflow_in : in STD_LOGIC;
           Over_in : in STD_LOGIC;
           Data_in_3 : in STD_LOGIC;
           Zero : out STD_LOGIC;
           Negative : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Over : out STD_LOGIC);
end Flag_Bank;

architecture Behavioral of Flag_Bank is

begin

Zero <= Zero_in;
Overflow <= Overflow_in;
Negative <= Data_in_3;
Over <= Over_in;

end Behavioral;
