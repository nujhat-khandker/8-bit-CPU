library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity PC is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           pc_out: out STD_LOGIC_VECTOR (3 downto 0));
end PC;

architecture Behavioral of PC is
    signal count : unsigned(3 downto 0) := "0000";
begin
process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                count <= "0000";
            else
                count <= count + 1;
            end if;
        end if;
    end process;
    pc_out <= std_logic_vector(count);
end Behavioral;