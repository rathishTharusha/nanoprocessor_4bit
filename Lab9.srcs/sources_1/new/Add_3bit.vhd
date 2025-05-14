----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 01:56:51 PM
-- Design Name: 
-- Module Name: Add_3bit - Behavioral
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

entity Add_3bit is
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (2 downto 0);
           over: out STD_LOGIC);
end Add_3bit;

architecture Behavioral of Add_3bit is

COMPONENT HA
    Port ( A : in STD_LOGIC;
           B : in STD_LOGIC;
           Q : out STD_LOGIC;
           C_out : out STD_LOGIC);
end COMPONENT;

SIGNAL P0, G0, P1, G1, C1, C2, P2, G2: std_logic;

begin

HA0: HA 
port map(
A => A(0),
B => B(0),
Q => P0,
C_out => G0
);

HA1: HA 
port map(
A => A(1),
B => B(1),
Q => P1,
C_out => G1
);

HA2: HA 
port map(
A => A(2),
B => B(2),
Q => P2,
C_out => G2
);

C1 <= G0;
C2 <= G1 OR (P1 AND G0);

Q(0) <= P0;
Q(1) <= C1 XOR P1;
Q(2) <= C2 XOR P2;
over <= G2 OR (P2 AND G1) OR (P2 AND P1 AND G0); -- indicate end of the programme

end Behavioral;
