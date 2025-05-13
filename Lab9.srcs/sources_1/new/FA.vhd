----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 10:53:01 AM
-- Design Name: 
-- Module Name: FA - Behavioral
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

entity FA is
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           C_in : in STD_LOGIC;
           Q : out STD_LOGIC;
           C_out : out STD_LOGIC);
end FA;

architecture Behavioral of FA is

COMPONENT HA
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Q : out STD_LOGIC;
           C_out : out STD_LOGIC);
end COMPONENT;

SIGNAL C0, C1, S0: std_logic;

begin

HA0: HA
port map(
A => A,
B => B,
Q => S0,
C_out => C0 
);

HA1: HA
port map(
A => S0,
B => C_in,
Q => Q,
C_out => C1 
);

C_out <= C0 OR C1;

end Behavioral;
