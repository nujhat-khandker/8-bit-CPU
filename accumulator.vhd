library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Accumulator is
    Port ( clk      : in  STD_LOGIC;
           reset    : in  STD_LOGIC;
           write_en : in  STD_LOGIC;
           data_in  : in  STD_LOGIC_VECTOR (7 downto 0);
           acc_out  : out STD_LOGIC_VECTOR (7 downto 0));
end Accumulator;
architecture Behavioral of Accumulator is
    signal acc_reg : STD_LOGIC_VECTOR (7 downto 0) := (others => '0');
begin
    process(clk)
    begin
        if rising_edge(clk) then
            if reset = '1' then
                acc_reg <= (others => '0');
            elsif write_en = '1' then
                acc_reg <= data_in;
            end if;
        end if;
    end process;
    acc_out <= acc_reg;
end Behavioral;