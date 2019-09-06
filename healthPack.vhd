LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;
LIBRARY lpm;
USE lpm.lpm_components.ALL;

PACKAGE de0core2 IS
	COMPONENT vga_sync
 		PORT(clock_25Mhz, red, green, blue	: IN	STD_LOGIC;
         	red_out, green_out, blue_out	: OUT 	STD_LOGIC;
			horiz_sync_out, vert_sync_out	: OUT 	STD_LOGIC;
			pixel_row, pixel_column			: OUT STD_LOGIC_VECTOR(9 DOWNTO 0));
	END COMPONENT;
END de0core2;

			-- Bouncing pipe Video 
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_SIGNED.all;
LIBRARY work;
USE work.de0core2.all;

entity healthPack is 
	port(
		  SIGNAL Clock 						: IN std_logic;
		  signal pipeX							: in std_logic_vector(10 downto 0);
		  signal healthAvailible			: in std_logic;
		  SIGNAL Red,Green,Blue 			: OUT std_logic;
		  SIGNAL health_State				: OUT std_logic;
		  signal healthPos					: out std_logic_vector(10 downto 0)
	);
end entity;

architecture behaviour of healthPack is 

SIGNAL Red_Data, Green_Data, Blue_Data, vert_sync_int,
		reset, Pipe_on, Direction			: std_logic;
SIGNAL Size										: std_logic_vector(9 DOWNTO 0);  
SIGNAL Pipe_X_motion 						: std_logic_vector(9 DOWNTO 0);
SIGNAL Pipe_Y_pos, Pipe_X_pos				: std_logic_vector(10 DOWNTO 0);
SIGNAL pixel_row, pixel_column			: std_logic_vector(9 DOWNTO 0); 
SIGNAL space 									: std_LOGIC_VECTOR(9 downto 0);
signal Toggle 									: std_logic;

begin           
   SYNC: vga_sync
 		PORT MAP(clock_25Mhz => clock, 
				red => red_data, green => green_data, blue => blue_data,	
    	     	red_out => red, green_out => green, blue_out => blue,
			 	pixel_row => pixel_row, pixel_column => pixel_column);

Size <= CONV_STD_LOGIC_VECTOR(4,10);
--Pipe_X_pos <= CONV_STD_LOGIC_VECTOR(200,10);


		-- need internal copy of vert_sync to read

		-- Colors for pixel data on video signal
Red_Data <=  NOT Pipe_on;
		-- Turn off Green and Blue when displaying pipe
Green_Data <= NOT Pipe_on;
Blue_Data <=  '1';
space <= CONV_STD_LOGIC_VECTOR(70,10);

RGB_Display: Process (Pipe_X_pos, Pipe_Y_pos, pixel_column, pixel_row, Size, healthAvailible)
BEGIN


	Pipe_Y_pos <= CONV_STD_LOGIC_VECTOR(180, 11);


			-- Set Pipe_on ='1' to display pipe

	if ('0' & Pipe_X_pos <= pixel_column + Size) AND
 			-- compare positive numbers only
 	(Pipe_X_pos + Size >= '0' & pixel_column) AND
 	('0' & Pipe_Y_pos <= pixel_row + Size) AND
 	(Pipe_Y_pos + Size >= '0' & pixel_row and healthAvailible = '1') then
		if (Pipe_X_pos < 490) then
			Pipe_on <= '1';
		else 
			Pipe_on <= '0';
		end if;
 	else
 		Pipe_on <= '0';
	end if;
 health_State <= Pipe_on;
END process RGB_Display;


Move_Pipe: process(Clock) 
BEGIN
			-- Move pipe once every vertical sync
			-- Bounce off top or bottom of screen
			-- Rolls over at 512 because of signed vector
		if (rising_edge(Clock)) then 
			Pipe_X_pos <= PipeX - 120;
		end if;
		healthPos <= Pipe_X_pos;
END process Move_Pipe;
end behaviour;