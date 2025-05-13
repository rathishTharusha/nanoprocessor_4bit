----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 04:36:58 PM
-- Design Name: 
-- Module Name: ProgramROM - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ProgramROM is
    Port ( Address : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end ProgramROM;

architecture Behavioral of ProgramROM is

    -- Define ROM type (8x12-bit)
    type ROM_Array is array (0 to 7) of STD_LOGIC_VECTOR(11 downto 0);
    
    -- Initialize ROM with your program
    constant ROM_Data : ROM_Array := (
        -- Format: 1 0 RRR 000 DDDD (MOVI)
        "100010001010",  -- MOVI R1, 10 (Address 0)
        "100100000001",  -- MOVI R2, 1 (Address 1)
        "010100000000",  -- NEG R2     (Address 2)
        "000010100000",  -- ADD R1, R2 (Address 3)
        "110010000111",  -- JZR R1, 7  (Address 4)
        "110000000011",  -- JZR R0, 3  (Address 5)
        "000000000000",  -- NOP        (Address 6)
        "000000000000"   -- NOP        (Address 7)
    );

begin

    Instruction <= ROM_Data(to_integer(unsigned(Address)));        
end Behavioral;
