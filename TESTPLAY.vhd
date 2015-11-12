----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    21:51:50 11/23/2007 
-- Design Name: 
-- Module Name:    TESTPLAY - FUNK 
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

entity TESTPLAY is
    Port ( START : in  STD_LOGIC;
			  NUMERO: in STD_LOGIC_VECTOR (3 downto 0);
           SIETES : out  STD_LOGIC_VECTOR (6 downto 0);
           HAB : out  STD_LOGIC);
end TESTPLAY;

architecture FUNK of TESTPLAY is

begin

process(NUMERO,START)
begin 
	
	if(START='1')then
		
		case NUMERO is
			when "0001" => SIETES<="1111001";--0000110  1
			when "0010" => SIETES<="0100100";--1011011  2
			when "0011" => SIETES<="0110000";--1001111  3
			when "0100" => SIETES<="0011001";--1100110  4
			when "0101" => SIETES<="0010010";--1101101  5
			when "0110" => SIETES<="0000010";--1111101  6
			when "0111" => SIETES<="1111000";--0000111  7			
			when "1000" => SIETES<="0000000";--1111111  8
			when "1001" => SIETES<="0010000";--1101111  9
			when "0000" => SIETES<="0100011";--1011100  []			
			when others => SIETES<="1111111"; --0000000 NADA
		end case;
		
		HAB<='0';
				
	else
		
		SIETES<="1000001";--0111110 U
		HAB<='0';
		
	end if;
		
end process;

end FUNK;

