library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Add_3bit_tb is
end Add_3bit_tb;

architecture Behavioral of Add_3bit_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component Add_3bit
        Port ( A    : in  STD_LOGIC_VECTOR (2 downto 0);
               B    : in  STD_LOGIC_VECTOR (2 downto 0);
               Q    : out STD_LOGIC_VECTOR (2 downto 0);
               over : out STD_LOGIC);
    end component;

    -- Inputs
    signal A    : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal B    : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');

    -- Outputs
    signal Q    : STD_LOGIC_VECTOR(2 downto 0);
    signal over : STD_LOGIC;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Add_3bit port map (
        A => A,
        B => B,
        Q => Q,
        over => over
    );

    -- Stimulus process
    stim_proc: process
    begin
        -- Test Case 1: Simple addition (1 + 2 = 3)
        A <= "001"; -- 1
        B <= "010"; -- 2
        wait for 20 ns;
        assert Q = "011" report "Test Case 1 Failed: 1 + 2 should be 3" severity error;
        assert over = '0' report "Test Case 1 Failed: No overflow expected" severity error;

        -- Test Case 2: Addition with carry (3 + 3 = 6)
        A <= "011"; -- 3
        B <= "011"; -- 3
        wait for 20 ns;
        assert Q = "110" report "Test Case 2 Failed: 3 + 3 should be 6" severity error;
        assert over = '0' report "Test Case 2 Failed: No overflow expected" severity error;

        -- Test Case 3: Maximum addition without overflow (3 + 4 = 7)
        A <= "011"; -- 3
        B <= "100"; -- 4
        wait for 20 ns;
        assert Q = "111" report "Test Case 3 Failed: 3 + 4 should be 7" severity error;
        assert over = '0' report "Test Case 3 Failed: No overflow expected" severity error;

        -- Test Case 4: Overflow case (4 + 4 = 0 with overflow)
        A <= "100"; -- 4
        B <= "100"; -- 4
        wait for 20 ns;
        assert Q = "000" report "Test Case 4 Failed: 4 + 4 should be 0 with overflow" severity error;
        assert over = '1' report "Test Case 4 Failed: Overflow expected" severity error;

        -- Test Case 5: Boundary case (7 + 0 = 7)
        A <= "111"; -- 7
        B <= "000"; -- 0
        wait for 20 ns;
        assert Q = "111" report "Test Case 5 Failed: 7 + 0 should be 7" severity error;
        assert over = '0' report "Test Case 5 Failed: No overflow expected" severity error;

        -- Test Case 6: Boundary case (7 + 1 = 0 with overflow)
        A <= "111"; -- 7
        B <= "001"; -- 1
        wait for 20 ns;
        assert Q = "000" report "Test Case 6 Failed: 7 + 1 should be 0 with overflow" severity error;
        assert over = '1' report "Test Case 6 Failed: Overflow expected" severity error;

        -- Test Case 7: All bits addition (5 + 2 = 7)
        A <= "101"; -- 5
        B <= "010"; -- 2
        wait for 20 ns;
        assert Q = "111" report "Test Case 7 Failed: 5 + 2 should be 7" severity error;
        assert over = '0' report "Test Case 7 Failed: No overflow expected" severity error;

        -- Test Case 8: Zero case (0 + 0 = 0)
        A <= "000"; -- 0
        B <= "000"; -- 0
        wait for 20 ns;
        assert Q = "000" report "Test Case 8 Failed: 0 + 0 should be 0" severity error;
        assert over = '0' report "Test Case 8 Failed: No overflow expected" severity error;

        wait;
    end process;

end Behavioral;