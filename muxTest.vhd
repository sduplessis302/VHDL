LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity muxTest is 
	port(
	Clock : in std_logic;
	Pause : in std_logic;
	Output	: out std_logic
	);
end entity; 

architecture behaviour of muxTest is 
begin
process(Clock, Pause)
	begin
	if (Pause = '1') then 
		Output <= '0';
	else 
		Output <= Clock;
	end if;
end process;
end behaviour; 