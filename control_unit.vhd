library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Control_Unit is
    Port ( instr      : in  STD_LOGIC_VECTOR (11 downto 0);
           alu_op     : out STD_LOGIC_VECTOR (2 downto 0);
           operand    : out STD_LOGIC_VECTOR (7 downto 0);
           write_en   : out STD_LOGIC);
end Control_Unit;
architecture Behavioral of Control_Unit is
begin
    process(instr)
        variable opcode : std_logic_vector(3 downto 0);
    begin
        opcode  := instr(11 downto 8);
        operand <= instr(7 downto 0);

        case opcode is
            when "0001" => -- LDI
                alu_op   <= "000";
                write_en <= '1';
            when "0010" => -- ADD
                alu_op   <= "001";
                write_en <= '1';
            when "0101" => -- OR
                alu_op   <= "010";
					 write_en <= '1';
            when "0111" => -- NOT
                alu_op   <= "011";
                write_en <= '1';
            when "1001" => -- SHR
                alu_op   <= "100";
                write_en <= '1';
            when others =>
                alu_op   <= "111";
                write_en <= '0';
        end case;
    end process;
end Behavioral;