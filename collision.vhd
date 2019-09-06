LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;
 
entity collision is 
	port( Ball_on, Pipe_on : in std_logic;
			Clock				: in std_logic;
			PipeX_coolDown	: in std_logic_vector(10 downto 0);
			gameState		: in std_logic_vector(1 downto 0);
			groundHit		: in std_logic;
			healthOn			: in std_logic;
			Collision : out std_logic;
			healthOut : out std_logic_vector(1 downto 0);
			gameOver			: out std_logic;
			tHealth 	: out std_logic
			);
end collision;

architecture behaviour of collision is 
	signal Count : std_logic_vector(1 downto 0);
	signal Toggle: std_logic;
	signal toggleHealth : std_logic;
begin 
	process(Ball_on, Pipe_on, Clock, groundHit)


	begin 
	if (rising_edge(Clock)) then
		if (groundHit = '1') then 
			gameOver <= '1';
		end if;
	
		if (gameState = 2) then -- active low button two to reset value(change when game FSM is made)
			Count <= "00";
			Toggle <= '0';
			gameOver <= '0';
			toggleHealth <= '0';
		elsif (Ball_on = '1' and Pipe_on = '1') then	
			if (Toggle = '0') then 
				Collision <= '1';
				Count <= Count + 1;

				if (Count = "10") then 
					gameOver <= '1';
				end if;
				Toggle <= '1';
			end if;
		elsif(Ball_on = '1' and healthOn = '1') then
			Count <= "00";
			toggleHealth <= '1';
		elsif (PipeX_coolDown > 360) then 
			Toggle <= '0';
			toggleHealth <= '0';
		else 
			Collision <= '0';
		end if;
			healthOut <= Count;
			tHealth <= toggleHealth;
	end if;
	end process; 
end behaviour; 