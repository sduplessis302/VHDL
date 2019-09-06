LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity scoreKeep is 
	port(
	Clock				: in std_logic;
	pipeX				: in std_logic_vector(10 downto 0);
	ballX				: in std_logic_vector(9 downto 0); 
	collision 		: in std_logic;
	gameState		: in std_logic_vector(1 downto 0);
	scoreOUT 		: out std_logic_vector(15 downto 0)
	);
end entity;

architecture behaviour of scoreKeep is 
	signal BCD1 : std_logic_vector(3 downto 0);
	signal BCD2 : std_logic_vector(3 downto 0);
	signal BCD3 : std_logic_vector(3 downto 0);
	signal BCD4 : std_logic_vector(3 downto 0);
	signal Toggle: std_logic;
begin 
process(Clock, pipeX, ballX, collision)
	begin 

		if (rising_edge(Clock)) then 
			if (collision = '1') then  
				Toggle <= '1';
			end if;
		
			if (gameState = 0) then -- active low button two to reset value(change when game FSM is made)
				BCD1 <= "0000";
				BCD2 <= "0000";
				BCD3 <= "0000";
				BCD4 <= "0000";
				Toggle <= '0';
			elsif (Toggle = '0' and pipeX = ballX) then 
				if (BCD1 + 1 < 10) then 
					BCD1 <= BCD1 + 1;
				else 
					BCD1 <= "0000";
					if (BCD2 + 1 < 10) then 
						BCD2 <= BCD2 + 1;
					else 
						BCD2 <= "0000";
						if (BCD3 + 1 < 10) then 
							BCD3 <= BCD3 + 1;
						else 
							BCD3 <= "0000";
							if (BCD4 + 1 < 10) then 
								BCD4 <= BCD4 + 1;
							else
								BCD4 <= "0000";
							end if;
						end if;
					end if;
				end if;
				Toggle <= '1';
			elsif (pipeX > ballX + 40) then 
					Toggle <= '0';
			end if;
		end if;
		scoreOUT <= BCD4 & BCD3 & BCD2 & BCD1;
end process;
end behaviour;