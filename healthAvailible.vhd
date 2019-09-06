LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity healthAvailible is 
	port(
	Clock				: in std_logic;
	Score				: in std_logic_vector(3 downto 0);
	Collision		: in std_logic;
	gameState		: in std_logic_vector(1 downto 0);
	healthPackPos	: in std_logic_vector(10 downto 0);
	healthAvail 	: out std_logic
	);
end entity;

architecture behaviour of healthAvailible is
	signal Toggle : std_logic;
begin 
	process(Clock, Score, Collision)
	begin
		if (gameState = 0 ) then 
			healthAvail <= '0';
			Toggle <= '0';
		elsif (Score = 9 and Toggle = '0') then 
			Toggle <= '1';
			healthAvail <= '1';
		else 
			if (Collision = '1') then
			healthAvail <= '0';
			end if;
			if (healthPackPos > 380) then 
				Toggle <= '0';
			end if;
		end if;
		
	end process;
end behaviour;