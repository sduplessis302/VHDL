LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity delayHealth is 
	port(
	Clock				: in std_logic;
	Score				: in std_logic_vector(3 downto 0);
	healthOn 		: in std_logic;
	health_Out		: out std_logic
	);
end entity;

architecture behaviour of delayHealth is 
begin 
process(Clock, Score, healthOn)
	begin 
	
	if (rising_edge(Clock)) then 
		if (Score = 9) then 
			health_Out <= '0';
		else 
			health_Out <= healthOn;
		end if;
	end if;
	
end process;
end behaviour;