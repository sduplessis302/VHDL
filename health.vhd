LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity health is 
	port( Collision : in std_logic;
			Health : out std_logic_vector(1 downto 0)
			);
end health;

architecture behaviour of health is 
signal healthS : std_logic_vector(1 downto 0) := "11";
begin 
	process(Collision)
			variable coolDown : std_logic := '0';
	begin 
	if (rising_edge(Collision) and coolDown = '0') then 
		if (Collision = '1') then 
			healthS <= healthS - '1';
			coolDown := '1';
		end if;
	end if;
	Health <= healthS;
	end process; 
end behaviour; 