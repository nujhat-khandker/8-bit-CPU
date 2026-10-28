library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity alu_tb is
-- Testbench has no ports
end alu_tb;

architecture Behavioral of alu_tb is

    -- Component Declaration for the Unit Under Test (UUT)
    component ALU
	 Port ( acc_in  : in  STD_LOGIC_VECTOR (7 downto 0);
               operand : in  STD_LOGIC_VECTOR (7 downto 0);
               alu_op  : in  STD_LOGIC_VECTOR (2 downto 0);
               result  : out STD_LOGIC_VECTOR (7 downto 0);
               z_out   : out STD_LOGIC);
    end component;
	 -- Signal Declarations
    signal acc_in  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal operand : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal alu_op  : STD_LOGIC_VECTOR(2 downto 0) := (others => '0');
    signal result  : STD_LOGIC_VECTOR(7 downto 0);
    signal z_out   : STD_LOGIC;

begin
-- Instantiate the Unit Under Test (UUT)
    uut: ALU Port Map (
          acc_in => acc_in,
          operand => operand,
          alu_op => alu_op,
          result => result,
          z_out => z_out
        );

    -- Stimulus Process
    stim_proc: process
    begin		
        -- Wait 100 ns for global reset
        wait for 100 ns;
		  -- Test 1: LDI ("000") -> Result should be operand (x"AA")
        alu_op <= "000";
        operand <= x"AA";
        acc_in <= x"00";
        wait for 20 ns;

        -- Test 2: ADD ("001") -> x"05" + x"03" = x"08"
        alu_op <= "001";
        acc_in <= x"05";
        operand <= x"03";
        wait for 20 ns;
		  -- Test 3: OR ("010") -> x"F0" OR x"0F" = x"FF"
        alu_op <= "010";
        acc_in <= x"F0";
        operand <= x"0F";
        wait for 20 ns;

        -- Test 4: NOT ("011") -> NOT x"00" = x"FF"
        alu_op <= "011";
        acc_in <= x"00";
        wait for 20 ns;

        -- Test 5: SHR ("100") -> Shift Right x"04" ('00000100') = x"02" ('00000010')
        alu_op <= "100";
        acc_in <= x"04";
        wait for 20 ns;
		  -- Test 6: Zero Flag Check -> ADD x"00" + x"00" = x"00" (z_out should be '1')
        alu_op <= "001";
        acc_in <= x"00";
        operand <= x"00";
        wait for 20 ns;

        wait;
    end process;

end Behavioral;