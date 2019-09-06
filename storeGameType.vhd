LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity storeGameType is
	port(
	Clock 			: in std_logic;
	gameType			: in std_logic;
	gameState		: in std_logic_vector(1 downto 0);
	gameType_out	: out std_logic
	);
end entity;

architecture behaviour of storeGameType is 
	signal hold : std_logic;
begin 
process(Clock, gameType, gameState)
	begin 
	
	if (gameState = 0) then 
		hold <= gameType;
	end if;
	
	gameType_out <= hold;

end process;
end behaviour;