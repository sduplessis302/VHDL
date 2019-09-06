LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity char_Controller is 
	port(
		vga_Xpos		: in std_logic_vector(9 downto 0);
		vga_Ypos		: in std_logic_vector(9 downto 0);
		num1			: in std_logic_vector(5 downto 0);
		num2			: in std_logic_vector(5 downto 0);
		num3			: in std_logic_vector(5 downto 0);
		num4			: in std_logic_vector(5 downto 0);
		gameState 	: in std_logic_vector(1 downto 0);
		gameType		: in std_logic;
		charAddress	: out std_logic_vector(5 downto 0);
		sizeX, sizeY: out std_logic_vector(2 downto 0);
		charOn		: out std_logic
	);
end entity;

architecture behaviour of char_Controller is 
begin 
process(vga_Xpos, vga_Ypos) 
	begin 
	-- 512 528 544 560 576 592 608 624
	-- 128  192  256  320 384 448
	sizeX <= vga_Xpos(3 downto 1);
	sizeY <= vga_Ypos(3 downto 1);
	if (gameState = 0) then -- MENU

			if (vga_Ypos > 127 and vga_Ypos < 192) then 
				sizeX <= vga_Xpos(5 downto 3);
				sizeY <= vga_Ypos(5 downto 3);
				if (vga_Xpos > 127 and vga_Xpos < 193) then
					charAddress <= "010111"; -- W
					charOn <= '1';
				elsif (vga_Xpos > 191 and vga_Xpos < 257) then 	
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 255 and vga_Xpos < 321) then 
					charAddress <= "000001"; -- A
					charOn <= '1';
				elsif (vga_Xpos > 319 and vga_Xpos < 385) then 
					charAddress <= "010110"; -- V
					charOn <= '1';
				elsif (vga_Xpos > 383 and vga_Xpos < 449) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 447 and vga_Xpos < 513) then 
					charAddress <= "010010"; -- R
					charOn <= '1';
				else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
				end if;
			elsif (vga_Ypos > 224 and vga_Ypos < 240) then
				if (gameType = '1' and (191 < vga_Xpos and vga_Xpos < 208)) then 
					charAddress <= "011111"; -- Arrow
					charOn <= '1';
				elsif (vga_Xpos > 256 and vga_Xpos < 273) then
					charAddress <= "000111"; -- G
					charOn <= '1';
				elsif (vga_Xpos > 271 and vga_Xpos < 289) then 	
					charAddress <= "000001"; -- A
					charOn <= '1';
				elsif (vga_Xpos > 287 and vga_Xpos < 305) then 
					charAddress <= "001101"; -- M
					charOn <= '1';
				elsif (vga_Xpos > 303 and vga_Xpos < 321) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 319 and vga_Xpos < 337) then 
					charAddress <= "100000"; -- Space
					charOn <= '1';
				elsif (vga_Xpos > 335 and vga_Xpos < 353) then 
					charAddress <= "001101"; -- M
					charOn <= '1';
				elsif (vga_Xpos > 351 and vga_Xpos < 369) then 
					charAddress <= "001111"; -- O
					charOn <= '1';
				elsif (vga_Xpos > 367 and vga_Xpos < 385) then 
					charAddress <= "000100"; -- D
					charOn <= '1';
				elsif (vga_Xpos > 383 and vga_Xpos < 401) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
				end if;
			elsif (vga_Ypos > 256 and vga_Ypos < 272) then
				if (gameType = '0' and(191 < vga_Xpos and vga_Xpos < 208)) then 
					charAddress <= "011111"; -- Arrow
					charOn <= '1';
            elsif (vga_Xpos > 256 and vga_Xpos < 273) then
					charAddress <= "010100"; -- T
					charOn <= '1';
				elsif (vga_Xpos > 271 and vga_Xpos < 289) then 	
					charAddress <= "010010"; -- R
					charOn <= '1';
				elsif (vga_Xpos > 287 and vga_Xpos < 305) then 
					charAddress <= "000001"; -- A
					charOn <= '1';
				elsif (vga_Xpos > 303 and vga_Xpos < 321) then 
					charAddress <= "001001"; -- I
					charOn <= '1';
				elsif (vga_Xpos > 319 and vga_Xpos < 337) then 
					charAddress <= "001110"; -- N
					charOn <= '1';
				elsif (vga_Xpos > 335 and vga_Xpos < 353) then 
					charAddress <= "001001"; -- I
					charOn <= '1';
				elsif (vga_Xpos > 351 and vga_Xpos < 369) then 
					charAddress <= "001110"; -- N
					charOn <= '1';
				elsif (vga_Xpos > 367 and vga_Xpos < 385) then 
					charAddress <= "000111"; -- G
					charOn <= '1';
				elsif (vga_Xpos > 383 and vga_Xpos < 401) then 
					charAddress <= "100000"; -- SPACE
					charOn <= '1';
				elsif (vga_Xpos > 399 and vga_Xpos < 417) then 
					charAddress <= "001101"; -- M
					charOn <= '1';
				elsif (vga_Xpos > 415 and vga_Xpos < 433) then 
					charAddress <= "001111"; -- O
					charOn <= '1';
				elsif (vga_Xpos > 431 and vga_Xpos < 449) then 
					charAddress <= "000100"; -- D
					charOn <= '1';
				elsif (vga_Xpos > 447 and vga_Xpos < 465) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
				end if;
			else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
			end if;
	elsif(gameState = 1) then -- IN GAME 
		if(vga_Ypos > 47 and vga_Ypos < 64) then -- Print "Score"
			if (vga_Xpos > 527 and vga_Xpos < 545) then
				charAddress <= "010011"; -- S
				charOn <= '1';
			elsif (vga_Xpos > 543 and vga_Xpos < 561) then 	
				charAddress <= "000011"; -- C
				charOn <= '1';
			elsif (vga_Xpos > 559 and vga_Xpos < 577) then 
				charAddress <= "001111"; -- O
				charOn <= '1';
			elsif (vga_Xpos > 575 and vga_Xpos < 593) then 
				charAddress <= "010010"; -- R
				charOn <= '1';
			elsif (vga_Xpos > 591 and vga_Xpos < 609) then 
				charAddress <= "000101"; -- E
				charOn <= '1';
			else 
				charAddress <= "100000"; -- SPACE
				charOn <= '0';
			end if;
		elsif(vga_Ypos > 78  and vga_Ypos < 95) then --print actual number under "Score" 
			if (vga_Xpos > 527 and vga_Xpos < 545) then
				charAddress <= num4; 
				charOn <= '1';
			elsif (vga_Xpos > 543 and vga_Xpos < 561) then 	
				charAddress <= num3; 
				charOn <= '1';
			elsif (vga_Xpos > 559 and vga_Xpos < 577) then 
				charAddress <= num2;
				charOn <= '1';
			elsif (vga_Xpos > 575 and vga_Xpos < 593) then 
				charAddress <= num1; 
				charOn <= '1';
			else 
				charAddress <= "100000"; -- SPACE
				charOn <= '0';
			end if;
		elsif (vga_Ypos > 223  and vga_Ypos < 240) then 
			if (vga_Xpos > 511 and vga_Xpos < 529) then
				charAddress <= "001000"; -- H
				charOn <= '1';
			elsif (vga_Xpos > 527 and vga_Xpos < 545) then
				charAddress <= "000101"; -- E
				charOn <= '1';
			elsif (vga_Xpos > 543 and vga_Xpos < 561) then 	
				charAddress <= "000001"; -- A
				charOn <= '1';
			elsif (vga_Xpos > 559 and vga_Xpos < 577) then 
				charAddress <= "001100"; -- L
				charOn <= '1';
			elsif (vga_Xpos > 575 and vga_Xpos < 593) then 
				charAddress <= "010100"; -- T
				charOn <= '1';
			elsif (vga_Xpos > 591 and vga_Xpos < 609) then 
				charAddress <= "001000"; -- H
				charOn <= '1';
			else 
				charAddress <= "100000"; -- SPACE
				charOn <= '0';
			end if;
		elsif (vga_Ypos > 270  and vga_Ypos < 287) then 
			if (gameType = '0') then 
				charAddress <= "100000"; -- SPACE
				charOn <= '0';
			elsif (vga_Xpos > 511 and vga_Xpos < 529) then
				charAddress <= "010011"; -- S
				charOn <= '1';
			elsif (vga_Xpos > 527 and vga_Xpos < 545) then
				charAddress <= "010100"; -- T
				charOn <= '1';
			elsif (vga_Xpos > 543 and vga_Xpos < 561) then 	
				charAddress <= "000001"; -- A
				charOn <= '1';
			elsif (vga_Xpos > 559 and vga_Xpos < 577) then 
				charAddress <= "001101"; -- M
				charOn <= '1';
			elsif (vga_Xpos > 575 and vga_Xpos < 593) then 
				charAddress <= "001001"; -- I
				charOn <= '1';
			elsif (vga_Xpos > 591 and vga_Xpos < 609) then 
				charAddress <= "001110"; -- N
				charOn <= '1';
			elsif (vga_Xpos > 607 and vga_Xpos < 625) then 
				charAddress <= "000001"; -- A
				charOn <= '1';
			else 
				charAddress <= "100000"; -- SPACE
				charOn <= '0';
			end if;
		end if;
	elsif (gameState = 2) then -- GAME OVER
		if(vga_Ypos > 239  and vga_Ypos < 256) then --print actual number under "Score" 
            if (vga_Xpos > 239 and vga_Xpos < 257) then
					charAddress <= "010011"; -- S
					charOn <= '1';
				elsif (vga_Xpos > 255 and vga_Xpos < 273) then 	
					charAddress <= "000011"; -- C
					charOn <= '1';
				elsif (vga_Xpos > 271 and vga_Xpos < 289) then 
					charAddress <= "001111"; -- O
					charOn <= '1';
				elsif (vga_Xpos > 287 and vga_Xpos < 305) then 
					charAddress <= "010010"; -- R
					charOn <= '1';
				elsif (vga_Xpos > 303 and vga_Xpos < 321) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 319 and vga_Xpos < 337) then 
					charAddress <= "100001"; -- Colon
					charOn <= '1';
				elsif (vga_Xpos > 335 and vga_Xpos < 353) then 
					charAddress <= "100000"; --space
					charOn <= '1';
				elsif (vga_Xpos > 351 and vga_Xpos < 369) then 
					charAddress <= num4; 
					charOn <= '1';
				elsif (vga_Xpos > 367 and vga_Xpos < 385) then 
					charAddress <= num3; 
					charOn <= '1';
				elsif (vga_Xpos > 383 and vga_Xpos < 401) then 
					charAddress <= num2; 
					charOn <= '1';
				elsif (vga_Xpos > 399 and vga_Xpos < 417) then 
					charAddress <= num1; 
					charOn <= '1';
				else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
				end if;
		elsif (vga_Ypos > 127 and vga_Ypos < 192) then 
				sizeX <= vga_Xpos(5 downto 3);
				sizeY <= vga_Ypos(5 downto 3);
				if (vga_Xpos > 63 and vga_Xpos < 129) then 
					charAddress <= "000111"; -- G
					charOn <= '1';
				elsif (vga_Xpos > 127 and vga_Xpos < 193) then
					charAddress <= "000001"; -- A
					charOn <= '1';
				elsif (vga_Xpos > 191 and vga_Xpos < 257) then 	
					charAddress <= "001101"; -- M
					charOn <= '1';
				elsif (vga_Xpos > 255 and vga_Xpos < 321) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 319 and vga_Xpos < 385) then 
					charAddress <= "001111"; -- O
					charOn <= '1';
				elsif (vga_Xpos > 383 and vga_Xpos < 449) then 
					charAddress <= "010110"; -- V
					charOn <= '1';
				elsif (vga_Xpos > 447 and vga_Xpos < 513) then 
					charAddress <= "000101"; -- E
					charOn <= '1';
				elsif (vga_Xpos > 511 and vga_Xpos < 577) then 
					charAddress <= "010010"; -- R
					charOn <= '1';
				else 
					charAddress <= "100000"; -- SPACE
					charOn <= '0';
				end if;
		end if;
	end if;
end process;
end behaviour;