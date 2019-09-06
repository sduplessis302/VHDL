LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

PACKAGE de0core3 IS
	COMPONENT vga_sync
 		PORT(clock_25Mhz, red, green, blue	: IN	STD_LOGIC;
         	red_out, green_out, blue_out	: OUT 	STD_LOGIC;
			horiz_sync_out, vert_sync_out	: OUT 	STD_LOGIC;
			pixel_row, pixel_column			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
	END COMPONENT;
END de0core3;

			-- Bouncing pipe Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
LIBRARY work;
USE work.de0core3.all;

ENTITY pipe2 IS
Generic(ADDR_WIDTH: integer := 12; DATA_WIDTH: integer := 1);

   PORT(SIGNAL PB1, PB2, Clock 			: IN std_logic;
        SIGNAL Red,Green,Blue 			: OUT std_logic;
		  --SIGNAL Red,Green,Blue 			: OUT std_logic;
		  SIGNAL pipe_State					: OUT std_logic;
		  SIGNAL randomIn						: IN std_LOGIC_VECTOR(7 downto 0);
		  signal initPipe						: in std_logic;
		  signal gameState					: in std_LOGIC_VECTOR(1 downto 0);
		  signal difficulty					: in std_logic_vector(6 downto 0);
        SIGNAL Horiz_sync,Vert_sync		: OUT std_logic;
		  signal pipeX							: out std_logic_vector(10 downto 0);
		  signal nextLevel					: out std_logic);

END pipe2;

architecture behavior of pipe2 is

			-- Video Display Signals   
SIGNAL Red_Data, Green_Data, Blue_Data, vert_sync_int,
		reset, Pipe_on, Direction			: std_logic;
SIGNAL Size										: std_logic_vector(9 DOWNTO 0);  
SIGNAL Pipe_X_motion 						: std_logic_vector(9 DOWNTO 0);
SIGNAL Pipe_Y_pos, Pipe_X_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pixel_row, pixel_column			: std_logic_vector(9 DOWNTO 0); 
SIGNAL space 									: std_LOGIC_VECTOR(9 downto 0);
Signal random 									: std_LOGIC_VECTOR(7 downto 0);
signal Count									: std_logic_vector(3 downto 0) := "0000";
signal dispToggle								: std_logic := '0';

BEGIN           
   SYNC: vga_sync
 		PORT MAP(clock_25Mhz => clock, 
				red => red_data, green => green_data, blue => blue_data,	
    	     	red_out => red, green_out => green, blue_out => blue,
			 	horiz_sync_out => horiz_sync, vert_sync_out => vert_sync_int,
			 	pixel_row => pixel_row, pixel_column => pixel_column);

Size <= CONV_STD_LOGIC_VECTOR(15,10);
--Pipe_X_pos <= CONV_STD_LOGIC_VECTOR(200,10);
Pipe_Y_pos <= CONV_STD_LOGIC_VECTOR(200,11);

		-- need internal copy of vert_sync to read
vert_sync <= vert_sync_int;

		-- Colors for pixel data on video signal
Red_Data <=  NOT Pipe_on;
		-- Turn off Green and Blue when displaying pipe
Green_Data <= '1';
Blue_Data <=  NOT Pipe_on;
space <= "000" & difficulty;

RGB_Display: Process (Pipe_X_pos, Pipe_Y_pos, pixel_column, pixel_row, Size)
BEGIN
if (Pipe_X_pos > 520 and Pipe_X_pos < 526) then 
	random <= randomIn;
end if;
			-- Set Pipe_on ='1' to display pipe
 IF ('0' & Pipe_X_pos <= pixel_column + Size) and (Pipe_X_pos + Size >= '0' & pixel_column) and (('0' & Pipe_Y_pos <= pixel_row + random - space) or ('0' & Pipe_Y_pos >= pixel_row + random + space)) then
		if (Pipe_X_pos < 490 and dispToggle = '1') then
			Pipe_on <= '1';
		else 
			Pipe_on <= '0';
		end if;
 	ELSE
 		Pipe_on <= '0';
END IF;
 pipe_State <= Pipe_on;
END process RGB_Display;


Move_Pipe: process
BEGIN
			-- Move pipe once every vertical sync
	WAIT UNTIL vert_sync_int'event and vert_sync_int = '1';
			-- Bounce off top or bottom of screen
			-- Rolls over at 512 because of signed vector
			if (gameState = 0) then 
				Pipe_X_pos <= CONV_STD_LOGIC_VECTOR(125,11);
				dispToggle <= '0';
				Count <= "0000";
			elsif (initPipe = '1') then 
				IF ('0' & Pipe_X_pos) >= CONV_STD_LOGIC_VECTOR(900,11) - Size THEN
					Pipe_X_motion <= "0000000100";
				END IF;
				-- Compute next pipe Y position
				Pipe_X_pos <= Pipe_X_pos + Pipe_X_motion;

				IF (Pipe_X_pos > 530) then 
					Pipe_X_pos <= CONV_STD_LOGIC_VECTOR(0,11);
					dispToggle <= '1';
					--Count <= Count + 1;
					--if (Count = 9) then 

					--end if;
				else 
				
				END IF;
				nextLevel <= '1';
			end if;
			pipeX <= Pipe_X_pos;
END process Move_Pipe;

END behavior;