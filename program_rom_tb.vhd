library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity program_rom_tb is
-- Testbench has no ports
end program_rom_tb;

architecture Behavioral of program_rom_tb is

    -- Component Declaration matching Program_ROM
    component Program_ROM
	 Port ( addr  : in  STD_LOGIC_VECTOR (3 downto 0);
               instr : out STD_LOGIC_VECTOR (11 downto 0));
    end component;

    -- Signal Declarations
    signal addr  : STD_LOGIC_VECTOR(3 downto 0) := "0000";
    signal instr : STD_LOGIC_VECTOR(11 downto 0);

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Program_ROM Port Map (
          addr => addr,
          instr => instr
        );
		  -- Stimulus Process
    stim_proc: process
    begin		
        -- Step 1: Read Address 0 (Expected instr = x"10F")
        addr <= "0000";
        wait for 20 ns;

        -- Step 2: Read Address 1 (Expected instr = x"5A0")
        addr <= "0001";
        wait for 20 ns;

        -- Step 3: Read Address 2 (Expected instr = x"700")
        addr <= "0010";
        wait for 20 ns;

        -- Step 4: Read Address 3 (Expected instr = x"900")
        addr <= "0011";
        wait for 20 ns;
		  -- Step 5: Read Address 4 (Expected instr = x"2D8")
        addr <= "0100";
        wait for 20 ns;

        -- Step 6: Read Address 5 (Expected instr = x"581")
        addr <= "0101";
        wait for 20 ns;

        -- Step 7: Read Address 6 (Expected instr = x"900")
        addr <= "0110";
        wait for 20 ns;

        -- Step 8: Read Unprogrammed Address 7 (Expected instr = x"000")
        addr <= "0111";
        wait for 20 ns;

        wait;
    end process;

end Behavioral;