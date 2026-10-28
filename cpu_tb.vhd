library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_tb is
end cpu_tb;

architecture Behavioral of cpu_tb is

    signal clk    : STD_LOGIC := '0';
    signal reset  : STD_LOGIC := '0';
    signal acc_q  : STD_LOGIC_VECTOR (7 downto 0);
    signal z_flag : STD_LOGIC;

    constant CLK_PERIOD : time := 10 ns;
	 begin

    -- Instantiate CPU Top Level
    uut: entity work.cpu_top
        port map (
            clk    => clk,
            reset  => reset,
            acc_q  => acc_q,
            z_flag => z_flag
        );

    -- Clock Generation Process
    clk_process : process
    begin
        clk <= '0';
        wait for CLK_PERIOD/2;
        clk <= '1';
        wait for CLK_PERIOD/2;
    end process;
	 -- Stimulus Process
    stim_proc: process
    begin
        -- Step 1: Assert RESET for 1 full clock cycle
        reset <= '1';
        wait for CLK_PERIOD;
        
        -- Step 2: Release RESET and let the CPU run for 10 cycles
        reset <= '0';
        wait for CLK_PERIOD * 10;

        -- Step 3: Stop simulation process
        wait;
    end process;

end Behavioral;