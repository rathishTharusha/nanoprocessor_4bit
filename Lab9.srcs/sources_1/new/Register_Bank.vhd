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
           Data_out_0, Data_out_1, Data_out_2, Data_out_3, Data_out_4, Data_out_5, Data_out_6, Data_out_7 : out STD_LOGIC_VECTOR (3 downto 0));
end Register_Bank;

architecture Behavioral of Register_Bank is
    type RegArray is array (0 to 7) of STD_LOGIC_VECTOR(3 downto 0);
    signal Registers : RegArray;
    signal Decoder_out : STD_LOGIC_VECTOR(7 downto 0);
begin
    -- 3-to-8 Decoder (Lab 4)
    process(RegEn)
    begin
        Decoder_out <= (others => '0');
        Decoder_out(to_integer(unsigned(RegEn))) <= '1';
    end process;
    
    process(Clk, Res)
    begin
        if Res = '1' then
            Registers <= (others => (others => '0'));
        elsif rising_edge(Clk) then
            for i in 0 to 7 loop
                if Decoder_out(i) = '1' then
                    Registers(i) <= Data_in;
                end if;
            end loop;
        end if;
    end process;
    
    Data_out_0 <= Registers(0);
    Data_out_1 <= Registers(1);
    Data_out_2 <= Registers(2);
    Data_out_3 <= Registers(3);
    Data_out_4 <= Registers(4);
    Data_out_5 <= Registers(5);
    Data_out_6 <= Registers(6);
    Data_out_7 <= Registers(7); 
    
end Behavioral;
