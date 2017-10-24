----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    14:33:20 10/14/2017 
-- Design Name: 
-- Module Name:    UC - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
-- Description: 
--
-- Dependencies: 
--
-- Revision: 
-- Revision 0.01 - File Created
-- Additional Comments: 
--
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity UC is
    Port ( op : in  STD_LOGIC_VECTOR (1 downto 0);
           op3 : in  STD_LOGIC_VECTOR (5 downto 0);
           salida_uc : out  STD_LOGIC_VECTOR (5 downto 0));
end UC;

architecture Behavioral of UC is

begin
	process(op, op3)
		begin		
			if(op = "10") then --formato3			
				case op3 is				
					when 	"000000" => --Add
						salida_uc <= "000000";												
					when 	"000100" => --Sub
						salida_uc <= "000100";						
					when "000001"	 => -- And
						salida_uc <= "000001";												
					when "000101"	 => --Andn
						salida_uc <= "000101";					
					when "000010"	 => --or
						salida_uc <= "000010";												
					when "000110"	 => --orn
						salida_uc <= "000110";					
					when "000011"	 => --xor
						salida_uc <= "000011";												
					when 	"000111" => --xnor
						salida_uc <= "000111";						
					when 	"010100" => --SUBcc
						salida_uc <= "010100";					
					when 	"001100" => --SUBx
						salida_uc <= "001100";					
					when 	"011100" => --SUBxcc
						salida_uc <= "011100";					
					when 	"010001" => --ANDcc
						salida_uc <= "010001";						
					when 	"010101" => --ANDNcc
						salida_uc <= "010101";							
					when 	"010010" => --ORcc
						salida_uc <= "010010";							
					when 	"010110" => --ORNcc
						salida_uc <= "010110";							
					when 	"010011" => --XORcc
						salida_uc <= "010011";						
					when 	"010111" => --XNORcc
						salida_uc <= "010111";						
					when 	"001000" => --ADDx
						salida_uc <= "001000";					
					when 	"011000" => --ADDxcc
						salida_uc <= "011000";						
					when 	"010000" => --ADDcc
						salida_uc <= "010000";					
					when others =>
						salida_uc <= (others=>'0'); --error					
					end case;
			else
				salida_uc <= (others=>'1'); --No existe
			end if;			
		end process;
end Behavioral;

