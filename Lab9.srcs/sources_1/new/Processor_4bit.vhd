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
           Flags: out STD_LOGIC_VECTOR (3 downto 0));
end Processor_4bit;

architecture Behavioral of Processor_4bit is

COMPONENT Register_Bank
    Port ( Data_in : in STD_LOGIC_VECTOR (3 downto 0);
           RegEn : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Data_out_0, Data_out_1, Data_out_2, Data_out_3, Data_out_4, Data_out_5, Data_out_6, Data_out_7 : out STD_LOGIC_VECTOR (3 downto 0));
end COMPONENT;

COMPONENT MUX_8_to_1_4bit 
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           D2 : in STD_LOGIC_VECTOR (3 downto 0);
           D3 : in STD_LOGIC_VECTOR (3 downto 0);
           D4 : in STD_LOGIC_VECTOR (3 downto 0);
           D5 : in STD_LOGIC_VECTOR (3 downto 0);
           D6 : in STD_LOGIC_VECTOR (3 downto 0);
           D7 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC_VECTOR (2 downto 0);
           Y : out STD_LOGIC_VECTOR (3 downto 0));
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
           Address : out STD_LOGIC_VECTOR (2 downto 0);
           over : out STD_LOGIC);
end COMPONENT;

type RegArray is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
SIGNAL Registers : RegArray;
SIGNAl LoadSel, Op, JFlag, Over, Zero_in, Zero, Cout, Overflow: std_logic;
SIGNAL RegEn, RegSelA, RegSelB, JAdr, Address: std_logic_vector(2 downto 0);
SIGNAL Data_in, RegA, RegB, RegS, ImVal : std_logic_vector(3 downto 0);
SIGNAL Instruction : std_logic_vector(11 downto 0);

begin

Program_counter_0:Program_counter
    port map( 
    Clk => Clk,
    Res => Res,
    JFlag => JFlag,
    JAdr => JAdr,
    Address => Address,
    over => Over
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
    Clk => Clk,
    Data_out_0 => Registers(0), 
    Data_out_1 => Registers(1), 
    Data_out_2 => Registers(2), 
    Data_out_3 => Registers(3), 
    Data_out_4 => Registers(4), 
    Data_out_5 => Registers(5), 
    Data_out_6 => Registers(6), 
    Data_out_7 => Registers(7) 
);

MUX_8_to_1_4bit_0: MUX_8_to_1_4bit 
    port map ( 
    D0 => Registers(0), 
    D1 => Registers(1), 
    D2 => Registers(2), 
    D3 => Registers(3), 
    D4 => Registers(4), 
    D5 => Registers(5), 
    D6 => Registers(6), 
    D7 => Registers(7), 
    Sel => RegSelA,
    Y => RegB
);

MUX_8_to_1_4bit_1: MUX_8_to_1_4bit 
    port map ( 
    D0 => Registers(0), 
    D1 => Registers(1), 
    D2 => Registers(2), 
    D3 => Registers(3), 
    D4 => Registers(4), 
    D5 => Registers(5), 
    D6 => Registers(6), 
    D7 => Registers(7), 
    Sel => RegSelB,
    Y => RegA
);

MUX_8_to_1_4bit_2: MUX_8_to_1_4bit 
    port map ( 
    D0 => Registers(0), 
    D1 => Registers(1), 
    D2 => Registers(2), 
    D3 => Registers(3), 
    D4 => Registers(4), 
    D5 => Registers(5), 
    D6 => Registers(6), 
    D7 => Registers(7), 
    Sel => RegSel,
    Y => data
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
Flags(2) <= Over; -- program end flag
Flags(3) <= RegS(3); -- negative flag

end Behavioral;
