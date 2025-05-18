----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/12/2025 07:19:38 PM
-- Design Name: 
-- Module Name: Processor_4bit - Behavioral
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
-- use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor_4bit is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           RegSel : in STD_LOGIC_VECTOR (2 downto 0);
           Data : out STD_LOGIC_VECTOR (3 downto 0);
           Flags: out STD_LOGIC_VECTOR (2 downto 0));
end Processor_4bit;

architecture Behavioral of Processor_4bit is

COMPONENT Register_Bank
    Port ( Data_in : in STD_LOGIC_VECTOR (3 downto 0);
           RegEn : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           RegSel, RegSelB,  RegSelA : in STD_LOGIC_VECTOR (2 downto 0);
           RegA, RegB, Data : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT AddSub_4bit
    Port ( A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           Op : in STD_LOGIC;
           Q : out STD_LOGIC_VECTOR (3 downto 0);
           Overflow : out STD_LOGIC;
           Cout: out STD_LOGIC;
           Zero : out STD_LOGIC);
end COMPONENT;

COMPONENT Flag_Bank
    Port ( Zero_in : in STD_LOGIC;
           Overflow_in : in STD_LOGIC;
           Over_in : in STD_LOGIC;
           Op_in : in STD_LOGIC;
           Data_in : in STD_LOGIC_VECTOR (3 DOWNTO 0);
           Zero : out STD_LOGIC;
           Negative : out STD_LOGIC;
           Overflow : out STD_LOGIC;
           Over : out STD_LOGIC);
end COMPONENT;

COMPONENT Instruction_Decoder
    Port ( Instruction : in STD_LOGIC_VECTOR (11 downto 0);
           CheckZ : in STD_LOGIC;
           RegEn : out STD_LOGIC_VECTOR (2 downto 0);
           LoadSel : out STD_LOGIC;
           ImVal : out STD_LOGIC_VECTOR (3 downto 0);
           RegA : out STD_LOGIC_VECTOR (2 downto 0);
           RegB : out STD_LOGIC_VECTOR (2 downto 0);
           Op : out STD_LOGIC;
           JumpFlag : out STD_LOGIC;
           JAddress : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

COMPONENT ProgramROM 
    Port ( Address : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end COMPONENT;

COMPONENT Program_counter
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           JFlag : in STD_LOGIC;
           JAdr : in STD_LOGIC_VECTOR (2 downto 0);
           Address : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

COMPONENT Slow_Clock
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end COMPONENT;

type RegArray is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
SIGNAL Registers : RegArray;
SIGNAl LoadSel, Op, JFlag, Zero_in, Zero, Cout, Overflow, Slow_clk: std_logic;
SIGNAL RegEn, RegSelA, RegSelB, JAdr, Address: std_logic_vector(2 downto 0);
SIGNAL Data_in, RegA, RegB, RegS, ImVal : std_logic_vector(3 downto 0);
SIGNAL Instruction : std_logic_vector(11 downto 0);

begin

Slow_Clock_0: Slow_Clock 
    port map( 
    Clk_in => Clk,
    Clk_out => Slow_clk
);

Program_counter_0:Program_counter
    port map( 
    Clk => Slow_clk,
    Res => Res,
    JFlag => JFlag,
    JAdr => JAdr,
    Address => Address
);

ProgramROM_0: ProgramROM  
    port map ( 
    Address => Address,
    Instruction => Instruction
);

Instruction_Decoder_0: Instruction_Decoder
    port map ( 
    Instruction => Instruction,
    CheckZ => Zero_in,
    RegEn => RegEn,
    LoadSel => LoadSel,
    ImVal => ImVal,
    RegA => RegSelA,
    RegB => RegSelB,
    Op => Op,
    JumpFlag => JFlag,
    JAddress => JAdr 
);

Register_Bank_0: Register_Bank
    port map( 
    Data_in => Data_in,
    RegEn => RegEn,
    Res => Res,
    Clk => Slow_clk,
    RegSelA => RegSelA,
    RegSelB => RegSelB,
    RegSel => RegSel,
    Data => Data, 
    RegA => RegB, 
    RegB => RegA
);

AddSub_4bit_0: AddSub_4bit
port map(
    A => RegA,
    B => RegB,
    Op => Op,
    Q => RegS,
    Overflow => Overflow,
    Cout => Cout,
    Zero => Zero
);

-- 2 Way 4bit MUX 
Data_in <= ImVal when (LoadSel = '1') else RegS;

-- Check if register Zero
Zero_in <= NOT (RegB(3) OR RegB(2) OR RegB(1) OR RegB(0));

-- Flags
Flags(0) <= Zero; -- zero flag
Flags(1) <= Overflow; -- overflow flag
Flags(2) <= RegS(3); -- negative flag

end Behavioral;
