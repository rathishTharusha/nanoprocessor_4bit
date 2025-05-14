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
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity Processor_4bit is
    Port ( Clk : in STD_LOGIC;
           Res : in STD_LOGIC;
           Data : out STD_LOGIC_VECTOR (3 downto 0);
           Flags : out STD_LOGIC_VECTOR (3 downto 0));
end Processor_4bit;

architecture Behavioral of Processor_4bit is

COMPONENT Slow_Clock
    Port ( Clk_in : in STD_LOGIC;
           Clk_out : out STD_LOGIC);
end COMPONENT;


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

COMPONENT MUX_2_to_1_4bit
    Port ( D0 : in STD_LOGIC_VECTOR (3 downto 0);
           D1 : in STD_LOGIC_VECTOR (3 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (3 downto 0));
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

COMPONENT Add_3bit
    Port ( A : in STD_LOGIC_VECTOR (2 downto 0);
           B : in STD_LOGIC_VECTOR (2 downto 0);
           Q : out STD_LOGIC_VECTOR (2 downto 0);
           over: out STD_LOGIC);
end COMPONENT;

COMPONENT MUX_2_to_1_3bit
    Port ( D0 : in STD_LOGIC_VECTOR (2 downto 0);
           D1 : in STD_LOGIC_VECTOR (2 downto 0);
           Sel : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

COMPONENT PC_register
    Port ( D : in STD_LOGIC_VECTOR (2 downto 0);
           Res : in STD_LOGIC;
           Clk : in STD_LOGIC;
           Y : out STD_LOGIC_VECTOR (2 downto 0));
end COMPONENT;

COMPONENT ProgramROM 
    Port ( Address : in STD_LOGIC_VECTOR (2 downto 0);
           Instruction : out STD_LOGIC_VECTOR (11 downto 0));
end COMPONENT;

SIGNAl LoadSel, Op, IfZ, JFlag, Over, Zero, Overflow, Slow_clk: std_logic;
SIGNAL RegEn, RegSelA, RegSelB, JAdr, Address, Cnt_in, Cnt_out : std_logic_vector(2 downto 0);
SIGNAL D0, D1, D2, D3, D4, D5, D6, D7, Data_in, RegA, RegB, RegS, ImVal : std_logic_vector(3 downto 0);
SIGNAL Instruction : std_logic_vector(11 downto 0);

begin

Slow_Clock_0: Slow_Clock
    port map ( 
    Clk_in => Clk,
    Clk_out => Slow_clk
);

Register_Bank_0: Register_Bank
    port map( 
    Data_in => Data_in,
    RegEn => RegEn,
    Res => Res,
    Clk => Slow_clk,
    Data_out_0 => D7, 
    Data_out_1 => D7, 
    Data_out_2 => D7, 
    Data_out_3 => D7, 
    Data_out_4 => D7, 
    Data_out_5 => D7, 
    Data_out_6 => D7, 
    Data_out_7 => D7
);

MUX_8_to_1_4bit_0: MUX_8_to_1_4bit 
    port map ( 
    D0 => D0,
    D1 => D1,
    D2 => D2,
    D3 => D3,
    D4 => D4,
    D5 => D5,
    D6 => D6,
    D7 => D7,
    Sel => RegSelA,
    Y => RegB
);

MUX_8_to_1_4bit_1: MUX_8_to_1_4bit 
    port map ( 
    D0 => D0,
    D1 => D1,
    D2 => D2,
    D3 => D3,
    D4 => D4,
    D5 => D5,
    D6 => D6,
    D7 => D7,
    Sel => RegSelB,
    Y => RegA
);

AddSub_4bit_0: AddSub_4bit
port map(
    A => RegA,
    B => RegB,
    Op => Op,
    Q => RegS,
    Overflow => Overflow,
    Zero => Zero
);


Flag_Bank_0: Flag_Bank
    port map ( 
    Zero_in => Zero,
    Overflow_in => Overflow,
    Over_in => Over,
    Op_in => Op,
    Data_in => Data_in,
    Zero => Flags(0),
    Negative => Flags(1),
    Overflow => Flags(2),
    Over => Flags(3)
);

MUX_2_to_1_4bit_0: MUX_2_to_1_4bit
    port map ( 
    D0 => RegS,
    D1 => ImVal,
    Sel => LoadSel,
    Y => Data_in
);

Instruction_Decoder_0: Instruction_Decoder
    port map ( 
    Instruction => Instruction,
    CheckZ => IfZ,
    RegEn => RegEn,
    LoadSel => LoadSel,
    ImVal => ImVal,
    RegA => RegSelA,
    RegB => RegSelB,
    Op => Op,
    JumpFlag => JFlag,
    JAddress => JAdr 
);

Add_3bit_0: Add_3bit
    port map ( 
    A => Address,
    B => "001",
    Q => Cnt_in,
    over => Over
);

MUX_2_to_1_3bit_0: MUX_2_to_1_3bit
    port map ( 
    D0 => Cnt_in,
    D1 => JAdr,
    Sel => JFlag,
    Y => Cnt_out
);

PC_register_0: PC_register
    port map ( 
    D => Cnt_out,
    Res => Res,
    Clk => Slow_clk,
    Y => Address
);

ProgramROM_0: ProgramROM  
    port map ( 
    Address => Address,
    Instruction => Instruction
);

Data <= Data_in;

end Behavioral;
