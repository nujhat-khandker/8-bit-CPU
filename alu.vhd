library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ALU is
    Port ( acc_in  : in  STD_LOGIC_VECTOR (7 downto 0);
           operand : in  STD_LOGIC_VECTOR (7 downto 0);
           alu_op  : in  STD_LOGIC_VECTOR (2 downto 0);
           result  : out STD_LOGIC_VECTOR (7 downto 0);
           z_out   : out STD_LOGIC);
end ALU;
architecture Behavioral of ALU is
begin
    process(acc_in, operand, alu_op)
        variable res : std_logic_vector(7 downto 0);
    begin
	 case alu_op is
            when "000" => -- LDI: Pass operand directly
                res := operand;
            when "001" => -- ADD: acc_in + operand
                res := std_logic_vector(unsigned(acc_in) + unsigned(operand));
            when "010" => -- OR: acc_in OR operand
                res := acc_in or operand;
            when "011" => -- NOT: NOT acc_in
                res := not acc_in;
					 when "100" => -- SHR: Logical Shift Right (acc_in)
                res := '0' & acc_in(7 downto 1);
            when others =>
                res := x"00";
        end case;

        result <= res;
		  -- Zero Flag Check
        if res = x"00" then
            z_out <= '1';
        else
            z_out <= '0';
        end if;
    end process;
end Behavioral;