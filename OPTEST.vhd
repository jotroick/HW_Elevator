----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    21:17:44 11/23/2007 
-- Design Name: 
-- Module Name:    OPTEST - FUNK 
-- Project Name:   Elevator
-- Target Devices: S3-200
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

---- Uncomment the following library declaration if instantiating
---- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity OPTEST is
    Port ( OPTOS : in  STD_LOGIC_VECTOR (4 downto 0);
			  CLOCK: in STD_LOGIC;
			  START: in STD_LOGIC;
           SIETES : out  STD_LOGIC_VECTOR (6 downto 0);
           HAB : out  STD_LOGIC);
end OPTEST;

architecture FUNK of OPTEST is

begin

process(OPTOS,CLOCK,START)
variable LASTLEVEL: STD_LOGIC_VECTOR (4 downto 0);
begin -- SIETE SEGMENTOS
	
	if(START='1')then
		
		if(CLOCK'event and CLOCK='1')then
		
			case OPTOS is
				when "00001" => LASTLEVEL:=OPTOS;
				when "00010" => LASTLEVEL:=OPTOS;
				when "00100" => LASTLEVEL:=OPTOS;
				when "01000" => LASTLEVEL:=OPTOS;
				when "10000" => LASTLEVEL:=OPTOS;
				when others => LASTLEVEL:=LASTLEVEL;
			end case;
		
		end if;
	
		case LASTLEVEL is
			when "00001" => SIETES<="1111001";--0000110  1
			when "00010" => SIETES<="0100100";--1011011  2
			when "00100" => SIETES<="0110000";--1001111  3
			when "01000" => SIETES<="0011001";--1100110  4
			when "10000" => SIETES<="0010010";--1101101  5
			when "00000" => SIETES<="0100011";--1011100  []			
			when others => SIETES<="1111111"; --0000000 NADA
		end case;
				
	elsif(START='0')then
		
		SIETES<="1000001";--0111110 U
		LASTLEVEL:="00000";
		
	end if;
	
	HAB<='0';
	
end process;

end FUNK;

