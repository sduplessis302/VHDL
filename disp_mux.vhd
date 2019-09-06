LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity disp_mux is 
	port( CurrentX, CurrentY : in std_logic_vector(9 downto 0);
			Ball_red, Ball_green, Ball_blue, ball_state : in std_logic;
			Pipe_red, Pipe_green, Pipe_blue, pipe_state : in std_logic;
			Health : in std_logic_vector(1 downto 0);
			charSelected : in std_logic;
			charOn 		 : in std_logic;
			stamina		 : in std_logic_vector(10 downto 0);
			gameState	 : in std_logic_vector(1 downto 0);
			gameType		 : in std_logic;
			health_red, health_green, health_blue, health_on : in std_logic;
			Pipe2_red, Pipe2_green, Pipe2_blue, pipe2_state : in std_logic;
			Red_out, Green_out, Blue_out : out std_logic
			);
end disp_mux;

architecture behaviour of disp_mux is 
begin 
	process(CurrentX, CurrentY, pipe_state, ball_state, gameState, health_on)
	begin 
		if (gameState = 0) then
			if (charOn = '1') then 
				Blue_out <= charSelected;
				Red_out <= charSelected;
				Green_out <= charSelected;
			elsif ((0 < CurrentX and CurrentX < 7) or (633 < CurrentX and CurrentX < 640)) then 
				Blue_out <= '1';
				Red_out <= '1';
				Green_out <= '1';
			else
					Blue_out <= '0';
					Red_out <= '0';
					Green_out <= '0';
			end if;
		elsif (gameState = 2) then 	
			if (charOn = '1') then 
				Blue_out <= charSelected;
				Red_out <= charSelected;
				Green_out <= charSelected;
			elsif ((0 < CurrentX and CurrentX < 7) or (633 < CurrentX and CurrentX < 640)) then 
				Blue_out <= '1';
				Red_out <= '1';
				Green_out <= '1';
			else
					Blue_out <= '0';
					Red_out <= '0';
					Green_out <= '0';
			end if;
		elsif (gameState = 1) then 
			if (charOn = '1') then 
				Blue_out <= charSelected;
				Red_out <= charSelected;
				Green_out <= charSelected;
			elsif ((490 < currentX and currentX < 495) or (500 < currentX and currentX < 635)) then -- HUD panel 
				if ((currentY > 243 and currentY < 267)) then -- HEALTH bar
					if (currentX > 505 and currentX < 630) then 
						case Health is 
							when "11" => 
											
												Blue_out <= '1';
												Red_out <= '1';
												Green_out <= '1';							

							when "10" => 
											if (currentX > 580) then
												Blue_out <= '0';
												Red_out <= '1';
												Green_out <= '0';
											else 
												Blue_out <= '1';
												Red_out <= '1';
												Green_out <= '1';
											end if;
							when "01" => 
											if (currentX > 540) then
												Blue_out <= '0';
												Red_out <= '1';
												Green_out <= '1';
											else 
												Blue_out <= '1';
												Red_out <= '1';
												Green_out <= '1';
											end if;
												
							when others => 	
											Blue_out <= '0';
											Red_out <= '0';
											Green_out <= '1';
						end case;
						
					else  
						Blue_out <= '0';
						Red_out <= '0';
						Green_out <= '0';
					end if; 
				elsif ((currentY > 290 and currentY < 315)) then 
					-- STAMINA BAR 
					if (gameType = '0') then 
						Blue_out <= '0';
						Red_out <= '0';
						Green_out <= '0';
					elsif (currentX > stamina and currentX < 630) then 
						Blue_out <= '1';
						Red_out <= '0';
						Green_out <= '0';
					elsif (currentX > 505 and currentX < 630) then  
						Blue_out <= '1';
						Red_out <= '1';
						Green_out <= '1';
					else 
						Blue_out <= '0';
						Red_out <= '0';
						Green_out <= '0';
					end if;
				else
					Blue_out <= '0';
					Red_out <= '0';
					Green_out <= '0';
				end if;
			elsif (pipe_state = '1') then 
				Red_out <= Pipe_red;
				Green_out <= Pipe_green;
				Blue_out <= Pipe_blue;
			elsif (pipe2_state = '1') then 
				Red_out <= Pipe2_red;
				Green_out <= Pipe2_green;
				Blue_out <= Pipe2_blue;
			elsif (health_on = '1') then 
				Red_out <= health_red;
				Green_out <= health_green;
				Blue_out <= health_blue;
			elsif (ball_state = '1') then 
				Red_out <= Ball_red;
				Green_out <= Ball_green;
				Blue_out <= Ball_blue;
			else 
				Red_out <= Ball_red;
				Green_out <= Ball_green;
				Blue_out <= Ball_blue;
			end if;
		end if;
	end process; 
end behaviour; 