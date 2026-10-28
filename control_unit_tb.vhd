library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity control_unit_tb is
-- Testbench has no ports
end control_unit_tb;

architecture Behavioral of control_unit_tb is

    -- Component Declaration matching Control_Unit
	 component Control_Unit
        Port ( instr    : in  STD_LOGIC_VECTOR (11 downto 0);
               alu_op   : out STD_LOGIC_VECTOR (2 downto 0);
               operand  : out STD_LOGIC_VECTOR (7 downto 0);
               write_en : out STD_LOGIC);
    end component;
	 -- Signal Declarations
    signal instr    : STD_LOGIC_VECTOR(11 downto 0) := (others => '0');
    signal alu_op   : STD_LOGIC_VECTOR(2 downto 0);
    signal operand  : STD_LOGIC_VECTOR(7 downto 0);
    signal write_en : STD_LOGIC;

begin
-- Instantiate the Unit Under Test (UUT)
    uut: Control_Unit Port Map (
          instr => instr,
          alu_op => alu_op,
          operand => operand,
          write_en => write_en
        );
		  -- Stimulus Process
    stim_proc: process
    begin		
        -- Test 1: LDI Instruction (Opcode "0001", Operand x"0F") -> Expected: alu_op="000", write_en='1'
        instr <= x"10F";
        wait for 20 ns;

        -- Test 2: OR Instruction (Opcode "0101", Operand x"A0") -> Expected: alu_op="010", write_en='1'
        instr <= x"5A0";
        wait for 20 ns;
		  -- Test 3: NOT Instruction (Opcode "0111", Operand x"00") -> Expected: alu_op="011", write_en='1'
        instr <= x"700";
        wait for 20 ns;

        -- Test 4: SHR Instruction (Opcode "1001", Operand x"00") -> Expected: alu_op="100", write_en='1'
        instr <= x"900";
        wait for 20 ns;

        -- Test 5: ADD Instruction (Opcode "0010", Operand x"D8") -> Expected: alu_op="001", write_en='1'
        instr <= x"2D8";
        wait for 20 ns;
		  -- Test 6: Invalid/NOP Instruction (Opcode "0000", Operand x"00") -> Expected: alu_op="111", write_en='0'
        instr <= x"000";
        wait for 20 ns;

        wait;
    end process;

end Behavioral;