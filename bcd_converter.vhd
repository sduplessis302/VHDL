LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity bcd_converter is 
	port(
		BCD				: in std_logic_vector(3 downto 0);
		charAddress		: out std_logic_vector(5 downto 0)
	);
end entity;

architecture behaviour of bcd_converter is 
begin 
process(BCD)
	begin 
	case BCD is 
		when "0000" =>
			charAddress <= "110000";
		when "0001" =>
			charAddress <= "110001";
		when "0010" =>
			charAddress <= "110010";
		when "0011" =>
			charAddress <= "110011";
		when "0100" =>
			charAddress <= "110100";
		when "0101" =>
			charAddress <= "110101";
		when "0110" =>
			charAddress <= "110110";
		when "0111" =>
			charAddress <= "110111";
		when "1000" =>
			charAddress <= "111000";
		when others =>
			charAddress <= "111001";
		end case;
end process;
end behaviour;