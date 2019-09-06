LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.all;
USE IEEE.NUMERIC_STD.ALL;
USE  IEEE.STD_LOGIC_ARITH.all;
USE  IEEE.STD_LOGIC_UNSIGNED.all;

entity randNum is
Port ( Clock : in STD_LOGIC;
       reset : in STD_LOGIC;
       enable : in STD_LOGIC;
       Q : out STD_LOGIC_VECTOR (7 downto 0));

end randNum;

architecture Behavioral of randNum is


signal Qt: STD_LOGIC_VECTOR(7 downto 0) := "00000001";

begin

PROCESS(Clock)
variable hold : STD_LOGIC := '0';
BEGIN

IF rising_edge(Clock) THEN
   IF (reset='1') THEN

      Qt <= "00000001"; 

   ELSIF enable = '1' THEN
		Qt <= Qt + "101";
      hold := Qt(5) XOR Qt(4) XOR Qt(3) XOR Qt(2) XOR Qt(0);
      Qt <= hold & Qt(7 downto 1);
   END IF;

END IF;
END PROCESS;

--check <= Qt(7);
Q <= Qt;

end Behavioral;