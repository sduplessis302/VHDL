LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE IEEE.STD_LOGIC_ARITH.all;
USE IEEE.STD_LOGIC_UNSIGNED.all;

entity pipeSelect is 
	port(
	pipe1, pipe2		: in std_logic;
	pipe1X, pipe2X		: in std_logic_vector(10 downto 0);
	pipeOut				: out std_logic;
	pipeXOut				: out std_logic_vector(10 downto 0)
	);
end entity;

architecture behaviour of pipeSelect is 
begin 
process(pipe1, pipe2, pipe1X, pipe2X)
	begin
	
	if (pipe2X > 290) then 
		pipeOut <= pipe2;
		pipeXOut <= pipe2X;
	else
		pipeOut <= pipe1;
		pipeXOut <= pipe1X;
	end if;
	
end process;
end behaviour;