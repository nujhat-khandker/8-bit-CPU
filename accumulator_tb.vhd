library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity accumulator_tb is
-- Testbench has no ports
end accumulator_tb;

architecture Behavioral of accumulator_tb is

    -- Component Declaration for the Accumulator Unit
    component Accumulator
	 Port ( clk      : in  STD_LOGIC;
               reset    : in  STD_LOGIC;
               write_en : in  STD_LOGIC;
               data_in  : in  STD_LOGIC_VECTOR (7 downto 0);
               acc_out  : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

    -- Signal Declarations
	 signal clk      : STD_LOGIC := '0';
    signal reset    : STD_LOGIC := '0';
    signal write_en : STD_LOGIC := '0';
    signal data_in  : STD_LOGIC_VECTOR(7 downto 0) := (others => '0');
    signal acc_out  : STD_LOGIC_VECTOR(7 downto 0);

    -- Clock Period definition (10ns = 100MHz)
	 constant clk_period : time := 10 ns;

begin

    -- Instantiate the Unit Under Test (UUT)
    uut: Accumulator Port Map (
          clk => clk,
          reset => reset,
          write_en => write_en,
          data_in => data_in,
          acc_out => acc_out
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
        -- Test 1: Synchronous Reset Test
        reset <= '1';
        wait for 20 ns;	
        reset <= '0';
        wait for 10 ns;

        -- Test 2: Write Enable HIGH -> Load Data x"A5"
        write_en <= '1';
        data_in <= x"A5";
        wait for 10 ns;
		  -- Test 3: Write Enable LOW -> Hold Data (Output should remain x"A5")
        write_en <= '0';
        data_in <= x"FF"; -- Changing input, but output won't change
        wait for 20 ns;

        -- Test 4: Write Enable HIGH -> Load New Data x"55"
        write_en <= '1';
        data_in <= x"55";
        wait for 10 ns;

        -- Test 5: Synchronous Reset again
        reset <= '1';
        wait for 10 ns;
        reset <= '0';
		  wait;
    end process;

end Behavioral;