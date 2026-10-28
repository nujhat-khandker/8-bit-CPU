library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity Program_ROM is
    Port ( addr  : in  STD_LOGIC_VECTOR (3 downto 0);
           instr : out STD_LOGIC_VECTOR (11 downto 0));
end Program_ROM;

architecture Behavioral of Program_ROM is
    type rom_type is array (0 to 15) of STD_LOGIC_VECTOR(11 downto 0);
    
    -- Set 5 Instructions for ID 22201125
	 constant ROM : rom_type := (
        0 => x"10F", -- LDI 0x0F
        1 => x"5A0", -- OR  0xA0
        2 => x"700", -- NOT
        3 => x"900", -- SHR
        4 => x"2D8", -- ADD 0xD8
        5 => x"581", -- OR  0x81
        6 => x"900", -- SHR
        others => x"000"
    );
begin
    instr <= ROM(to_integer(unsigned(addr)));
end Behavioral;