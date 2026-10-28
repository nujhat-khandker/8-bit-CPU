library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity cpu_top is
    Port ( clk   : in  STD_LOGIC;
           reset : in  STD_LOGIC;
           acc_q : out STD_LOGIC_VECTOR (7 downto 0);
           z_flag: out STD_LOGIC);
end cpu_top;
architecture Structural of cpu_top is

    signal pc_sig      : STD_LOGIC_VECTOR (3 downto 0);
    signal instr_sig   : STD_LOGIC_VECTOR (11 downto 0);
    signal alu_op_sig  : STD_LOGIC_VECTOR (2 downto 0);
    signal operand_sig : STD_LOGIC_VECTOR (7 downto 0);
    signal write_en_sig: STD_LOGIC;
    signal alu_res_sig : STD_LOGIC_VECTOR (7 downto 0);
    signal acc_val_sig : STD_LOGIC_VECTOR (7 downto 0);

begin
-- 1. Program Counter
    u_pc: entity work.PC
        port map (
            clk    => clk,
            reset  => reset,
            pc_out => pc_sig
        );

    -- 2. Program ROM
    u_rom: entity work.Program_ROM
        port map (
            addr  => pc_sig,
            instr => instr_sig
        );
		  -- 3. Control Unit
    u_cu: entity work.Control_Unit
        port map (
            instr    => instr_sig,
            alu_op   => alu_op_sig,
            operand  => operand_sig,
            write_en => write_en_sig
        );

    -- 4. ALU
    u_alu: entity work.ALU
        port map (
            acc_in  => acc_val_sig,
            operand => operand_sig,
            alu_op  => alu_op_sig,
            result  => alu_res_sig,
            z_out   => z_flag
        );
		  -- 5. Accumulator Register
    u_acc: entity work.Accumulator
        port map (
            clk      => clk,
            reset    => reset,
            write_en => write_en_sig,
            data_in  => alu_res_sig,
            acc_out  => acc_val_sig
        );

    acc_q <= acc_val_sig;

end Structural;