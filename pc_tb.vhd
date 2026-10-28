library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity pc_tb is
-- Testbench has no ports
end pc_tb;

architecture Behavioral of pc_tb is

    -- Component Declaration matching your PC entity
    component PC
        Port ( clk    : in  STD_LOGIC;
               reset  : in  STD_LOGIC;
               pc_out : out STD_LOGIC_VECTOR (3 downto 0));
    end component;
	 -- Signal Declarations
    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal pc_out : STD_LOGIC_VECTOR(3 downto 0);

    -- Clock Period definition (10ns = 100MHz)
    constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: PC Port Map (
          clk => clk,
          reset => reset,
          pc_out => pc_out
        );
		  -- Clock Generation Process
    clk_process :process
    begin
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

    -- Stimulus Process
    stim_proc: process
    begin		
        -- Step 1: Apply Synchronous Reset
        reset <= '1';
        wait for 20 ns;	
        reset <= '0';
		  -- Step 2: Let PC increment (0000 -> 0001 -> 0010 -> ... -> 0110)
        wait for 70 ns;

        -- Step 3: Trigger Reset again to verify resetting back to 0000
        reset <= '1';
        wait for 10 ns;
        reset <= '0';

        wait;
    end process;

end Behavioral;