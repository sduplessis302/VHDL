LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity staminaCount is 
	port(
		Clock						: in std_logic;
		leftClick				: in std_logic;
		pause						: in std_logic;
		gameState				: in std_logic_vector(1 downto 0);
		gameType					: in std_logic;
		staminaRefil			: in std_logic;
		amountOUT				: out std_logic_vector(10 downto 0);
		staminaEMTPY			: out std_logic
	);
end entity;

architecture behaviour of staminaCount is
	signal amount	: std_logic_vector(10 downto 0) := "00000000000";
	signal pipePos	: std_logic_vector(10 downto 0);
	signal pipeHold	: std_logic_vector(10 downto 0);
begin 
process(Clock, leftClick, staminaRefil)
	begin
		if (rising_edge(Clock)) then 
			if (gameType = '1') then 
				if (gameState = 0 or staminaRefil = '1') then 
					amount <= "00000000000";
				elsif (leftClick = '1') then 
					if (amount < 128) then 
						amount <= amount + 4;
					end if;
				else 
					if (amount > 0 and pause = '1') then 
						amount <= amount - 2;
					end if;
				end if;
				
				if (amount > 40 and amount < 128) then 
					staminaEMTPY <= '0';
				elsif (amount < 40) then 
					staminaEMTPY <= '1';
				end if;
			else 
				staminaEMTPY <= '1';
			end if;
		end if;
	amountOUT <= 505 + amount;
end process;
end behaviour;