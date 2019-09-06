LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity levels is 
	port(
	Clock 		: in std_logic;
	increment	: in std_logic;
	gameState	: in std_logic_vector(1 downto 0);
	gameType		: in std_logic;
	difficulty 	: out std_logic_vector(6 downto 0)
	);
end entity;

architecture behaviour of levels is 
	signal count : std_logic_vector(1 downto 0);
begin 
process(Clock, increment, gameState, gameType)
	begin
	
	if (gameType = '1') then
		if (gameState = 0) then 
			count <= "00";
		elsif (rising_edge(increment) and count < "11") then 
			count <= count + 1;
		end if;
		
		if (count = 0) then 
			difficulty <= "1010000";
		elsif (count = 1) then 
			difficulty <= "0111100";
		else
			difficulty <= "0101101";
		end if;
	else 
		Count <= "00";
		difficulty <= "0111100";
	end if;
	
end process;
end behaviour;