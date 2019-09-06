-- Bouncing Ball Video 
--
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

PACKAGE de0core IS
	COMPONENT vga_sync
 		PORT(clock_25Mhz, red, green, blue	: IN	STD_LOGIC;
         	red_out, green_out, blue_out	: OUT 	STD_LOGIC;
			horiz_sync_out, vert_sync_out	: OUT 	STD_LOGIC;
			pixel_row, pixel_column			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
	END COMPONENT;
END de0core;

			-- Bouncing Ball Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
LIBRARY work;
USE work.de0core.all;

ENTITY ball IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL PB1, PB2, Clock 			: IN std_logic;
		  Signal collision 					: in std_logic;
		  Signal random						: in std_logic_vector(7 downto 0);
		  Signal staminaState				: in std_logic;
		  signal pause							: in std_logic;
		  signal gameState					: in std_logic_vector(1 downto 0);
        SIGNAL Red,Green,Blue 			: OUT std_logic;
        SIGNAL Horiz_sync,Vert_sync		: OUT std_logic;
		  SIGNAL Ball_state					: OUT std_logic;
		  SIGNAL BallX, BallY				: OUT std_logic_vector(9 downto 0);
		  signal movePipe						: out std_logic;
		  signal gameOver						: out std_logic);
		  
END ball;

architecture behavior of ball is

			-- Video Display Signals   
SIGNAL Red_Data, Green_Data, Blue_Data, vert_sync_int,
		reset, Ball_on, Direction			: std_logic;
SIGNAL Size 									: std_logic_vector(9 DOWNTO 0);
signal Draw 									: std_logic_vector(9 DOWNTO 0);
SIGNAL Ball_Y_motion 						: std_logic_vector(9 DOWNTO 0);
Signal Ball_Y_accel							: std_logic_vector(9 downto 0);
signal Button_pressed						: std_logic := '0'; 
signal GameInit								: std_logic := '0';
signal Toggle									: std_logic := '0';
SIGNAL Ball_Y_pos, Ball_X_pos				: std_logic_vector(9 DOWNTO 0);
SIGNAL pixel_row, pixel_column			: std_logic_vector(9 DOWNTO 0); 

BEGIN           
   SYNC: vga_sync
 		PORT MAP(clock_25Mhz => clock, 
				red => red_data, green => green_data, blue => blue_data,	
    	     	red_out => red, green_out => green, blue_out => blue,
			 	horiz_sync_out => horiz_sync, vert_sync_out => vert_sync_int,
			 	pixel_row => pixel_row, pixel_column => pixel_column);

Size <= CONV_STD_LOGIC_VECTOR(8,10);
Draw <= CONV_STD_LOGIC_VECTOR(6,10);
Ball_X_pos <= CONV_STD_LOGIC_VECTOR(320,10);

		-- need internal copy of vert_sync to read
vert_sync <= vert_sync_int;
		-- Colors for pixel data on video signal
Red_Data <=  '1';
Green_Data <= NOT Ball_on;
Blue_Data <=  NOT Ball_on;

RGB_Display: Process (Ball_X_pos, Ball_Y_pos, pixel_column, pixel_row, Size, PB2)
BEGIN
			-- Set Ball_on ='1' to display ball
	if ('0' & Ball_X_pos <= pixel_column + Size) AND
		 (Ball_X_pos + Size >= '0' & pixel_column) AND
		 ('0' & Ball_Y_pos <= pixel_row + Size) AND
		 (Ball_Y_pos + Size >= '0' & pixel_row ) then 
		IF ('0' & Ball_X_pos <= pixel_column + Size - Draw) AND
		 (Ball_X_pos + Size - Draw>= '0' & pixel_column) AND
		 ('0' & Ball_Y_pos <= pixel_row + Size) AND
		 (Ball_Y_pos + Size >= '0' & pixel_row ) THEN
			Ball_on <= '1';
		ELSE
			if ('0' & Ball_Y_pos <= pixel_row + Size - Draw) AND
				(Ball_Y_pos + Size - Draw >= '0' & pixel_row ) then 
					Ball_on <= '1';
			else
				Ball_on <= '0';
			end if;
		END IF;
	else 
		Ball_on <= '0';
	end if;
		Ball_state <= Ball_on;
END process RGB_Display;

Move_Ball: process
BEGIN
			-- Move ball once every vertical sync
	WAIT UNTIL vert_sync_int'event and vert_sync_int = '1';
				
				if (('0' & Ball_Y_pos) >= CONV_STD_LOGIC_VECTOR(480,10) - Size - 10) then 
					Ball_Y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
					gameOver <= '1';
				elsif (Ball_Y_pos <= Size + 15) then 
					Ball_Y_motion <= CONV_STD_LOGIC_VECTOR(7,10);
					Button_pressed <= '0';
				elsif (PB1 = '0') then

						Ball_Y_motion <= Ball_Y_motion + 1;
						if (Ball_Y_motion = 7) then 
							Ball_Y_motion <= CONV_STD_LOGIC_VECTOR(7,10);
						elsif (Ball_Y_motion > -5) then 
							Button_pressed <= '0';
						end if; 
				
				elsif (PB1 = '1' and Button_pressed = '0') then 
					Button_pressed <= '1';
						if (Ball_Y_pos -CONV_STD_LOGIC_VECTOR(2,10) > 10 ) then
							if (staminaState = '1') then 
								Ball_Y_motion <= -CONV_STD_LOGIC_VECTOR(7,10);
							else 
								Ball_Y_motion <= -CONV_STD_LOGIC_VECTOR(2,10);
							end if; 
						else 
							Ball_Y_motion <= -CONV_STD_LOGIC_VECTOR(0,10);
						end if;
				end if;
				
				if (gameState = 2) then 
					Ball_Y_pos <= CONV_STD_LOGIC_VECTOR(180,10);
					GameInit <= '0';
					gameInit <= '0';
					gameOver <= '0';
					movePipe <= '0';
				elsif (pause = '1') then
					GameInit <= '0';
				elsif (GameInit = '0') then
					gameOver <= '0';
					if (Toggle = '0') then 
						Ball_Y_pos <= CONV_STD_LOGIC_VECTOR(180,10);
						Toggle <= '1';
					end if;
					Ball_Y_motion <= CONV_STD_LOGIC_VECTOR(0,10);
					movePipe <= '0';
					if (PB1 = '1' and gameState = 1) then 
						GameInit <= '1';
						movePipe <= '1';
					end if;
				else
					--if (gameState = 2) then 
						--Ball_Y_pos <= Ball_Y_pos;
					--else 

						Ball_Y_pos <= Ball_Y_pos + Ball_Y_motion;
					--end if;
					BallX <= Ball_X_pos;
					BallY <= Ball_Y_pos ;--+ Ball_Y_motion;
				end if;

			-- Compute next ball Y position


END process Move_Ball;

END behavior;

