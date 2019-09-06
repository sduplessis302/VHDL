LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity gameController is 
	port(
	Clock				: in std_logic;
	Button			: in std_logic;
	gameOver 		: in std_logic;
	buttonReset		: in std_logic;
	switch0			: in std_logic;
	State_out			: out std_logic_vector(1 downto 0);
	game_out				: out std_logic
	);
end entity;

architecture behaviour of gameController is 
	type State_type is (Menu, Game, game_Over);
	type game_type	 is (Game_Mode, Training_Mode);
	signal state : State_type;
	signal gamemode : game_type;

begin 
process(Clock, Button, switch0) 
	begin 
	if (rising_edge(Clock)) then 
		case State is 
			when Menu => 
				if (Button = '1') then 
					State <= Game;
				else
					State <= Menu;
					if (switch0 = '1') then 
						gamemode <= Game_Mode;
					else 
						gamemode <= Training_Mode;
					end if;
				end if;
			when Game =>
				if (gameOver = '1') then 
					State <= game_Over;
				else 
					State <= Game;
				end if;
			when game_Over =>
				if (buttonReset = '0') then 
					State <= Menu;
				else 
					State <= game_Over;
				end if;
		end case;
	end if;	
	
end process;

game_mode_selected: process(Clock, gamemode)
	begin 
	if (rising_edge(Clock)) then 
		case gamemode is
			when Game_Mode =>
				game_out <= '1';
			when Training_Mode =>
				game_out <= '0';
			end case;
	end if;
end process;

output: process(State, Clock)
	begin 
	if (rising_edge(Clock)) then 
		case State is 
			when Menu => 
				State_out <= "00";
			when Game =>
				State_out <= "01";
			when game_Over => 
				State_out <= "10";
		end case;
	end if;
end process;

end behaviour;