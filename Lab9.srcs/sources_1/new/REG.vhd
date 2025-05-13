----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 03:09:49 PM
-- Design Name: 
-- Module Name: REG - Behavioral
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

entity REG is
    Port ( D : in STD_LOGIC_VECTOR (3 downto 0);
           Res : in STD_LOGIC;
           En: in STD_LOGIC;
           Clk : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
end REG;

architecture Behavioral of REG is

COMPONENT D_FF
    Port ( D : in STD_LOGIC;
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Q : out STD_LOGIC;
           Qbar : out STD_LOGIC);
end COMPONENT;

SIGNAL D_cur: std_logic_vector (3 downto 0);

begin

D_FF_0: D_FF
port map(
D => D_cur(0),
Res => Res,
Clk => Clk,
Q => Y(0)
);

D_FF_1: D_FF
port map(
D => D_cur(1),
Res => Res,
Clk => Clk,
Q => Y(1)
);

D_FF_2: D_FF
port map(
D => D_cur(2),
Res => Res,
Clk => Clk,
Q => Y(2)
);

D_FF_3: D_FF
port map(
D => D_cur(3),
Res => Res,
Clk => Clk,
Q => Y(3)
);

process (En) begin

if En = '1' then
    D_cur <= D;
end if;

end process;

end Behavioral;
