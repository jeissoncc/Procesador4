----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    21:51:24 10/16/2017 
-- Design Name: 
-- Module Name:    PSR_Mod - Behavioral 
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
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
use std.textio.all;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity PSR_Mod is
    Port ( sal_uc : in  STD_LOGIC_VECTOR (5 downto 0);
           sal_alu : in  STD_LOGIC_VECTOR (31 downto 0);
           crs1 : in  STD_LOGIC_VECTOR (31 downto 0);
           mux : in  STD_LOGIC_VECTOR (31 downto 0);
           nzvc : out  STD_LOGIC_VECTOR (3 downto 0);
           rst : in  STD_LOGIC);
end PSR_Mod;

architecture Behavioral of PSR_Mod is

begin
	process(sal_uc, sal_alu, crs1, mux,rst)
	begin
		if (rst = '1') then
			nzvc <= (others=>'0');
		else
			-- ANDcc or ANDNcc or ORcc or ORNcc or XORcc or XNORcc
			if (sal_uc="010001" OR sal_uc="010101" OR sal_uc="010010" OR sal_uc="010110" OR sal_uc="010011" OR sal_uc="010111") then
				nzvc(3) <= sal_alu(31);--el signo que traiga
				if (conv_integer(sal_alu)=0) then
					nzvc(2) <= '1';--porque el resultado da cero
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= '0';--los operadores logicos no generan overflow ni carry
				nzvc(0) <= '0';
			end if;
			
			-- ADDcc or ADDxcc
			if (sal_uc="010000" or sal_uc="011000") then
				nzvc(3) <= sal_alu(31);
				if (conv_integer(sal_alu)=0) then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (crs1(31) and mux(31) and (not sal_alu(31))) or ((not crs1(31)) and (not mux(31)) and sal_alu(31));
				nzvc(0) <= (crs1(31) and mux(31)) or ((not sal_alu(31)) and (crs1(31) or mux(31)) );
			end if;
			
			--SUBcc or SUBxcc
			if (sal_uc="010100" or sal_uc="011100") then
				nzvc(3) <= sal_alu(31);
				if (conv_integer(sal_alu)=0) then
					nzvc(2) <= '1';
				else
					nzvc(2) <= '0';
				end if;
				nzvc(1) <= (crs1(31) and (not mux(31)) and (not sal_alu(31))) or ((not crs1(31)) and mux(31) and sal_alu(31));
				nzvc(0) <= ((not crs1(31)) and mux(31)) or (sal_alu(31) and ((not crs1(31)) or mux(31)));
			end if;
		end if;		
	end process;
end Behavioral;

