----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 03:05:02 PM
-- Design Name: 
-- Module Name: PC_register - Behavioral
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

entity PC_register is
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end PC_register;

architecture Behavioral of PC_register is

COMPONENT D_FF
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end COMPONENT;

begin

D_FF_0: D_FF
port map(
D => D(0),
Res => Res,
Clk => Clk,
Q => Y(0)
);

D_FF_1: D_FF
port map(
D => D(1),
Res => Res,
Clk => Clk,
Q => Y(1)
);

D_FF_2: D_FF
port map(
D => D(2),
Res => Res,
Clk => Clk,
Q => Y(2)
);

end Behavioral;
