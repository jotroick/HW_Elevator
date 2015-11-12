----------------------------------------------------------------------------------
-- Company: UNAL
-- Engineer: JPT
-- 
-- Create Date:    12:44:14 11/16/2007 
-- Design Name: 
-- Module Name:    ELEVATROL - FUNK 
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

entity ELEVATROL is
    Port ( GOUP : in  STD_LOGIC_VECTOR (3 downto 0);
           GODOWN : in  STD_LOGIC_VECTOR (3 downto 0);
           GOLEVEL : in  STD_LOGIC_VECTOR (4 downto 0);
           STOP : in  STD_LOGIC;
           LEVEL : in  STD_LOGIC_VECTOR (4 downto 0);
           CLOCK : in  STD_LOGIC;
			  START : in  STD_LOGIC;
			  UP : out  STD_LOGIC;
           DOWN : out  STD_LOGIC;
           DOOR : out  STD_LOGIC_VECTOR (1 downto 0)
			  );
end ELEVATROL;

architecture FUNK of ELEVATROL is
type PILA is array (4 downto 0) of STD_LOGIC_VECTOR(4 downto 0);
begin
process (CLOCK, LEVEL, GOUP, GODOWN, GOLEVEL, STOP) 
	variable ORDENADOR: STD_LOGIC_VECTOR (4 downto 0);
	variable LASTLEVEL: STD_LOGIC_VECTOR (4 downto 0);
	variable UNEW: STD_LOGIC_VECTOR (4 downto 0);
	variable DNEW: STD_LOGIC_VECTOR (4 downto 0);
	variable CNEW: STD_LOGIC_VECTOR (4 downto 0);
	variable UCOUNT: integer range 0 to 7;
	variable DCOUNT: integer range 0 to 7;
	variable CCOUNT: integer range 0 to 7;
	variable STANDBY: STD_LOGIC;
	variable SUBE: STD_LOGIC;
	variable BAJA: STD_LOGIC;
	variable UPRIORITY: PILA;
	variable DPRIORITY: PILA;
	variable CPRIORITY: PILA;
	variable UORDER: boolean;
	variable DORDER: boolean;
	variable CORDER: boolean;
	variable UFLAG: boolean; -- PARA INSTRUCCIONES DOBLES EN UN MISMO INSTANTE
	variable DFLAG: boolean;
	variable CFLAG: boolean;
	variable TEMP: integer range 0 to 16383;
	
begin
if(CLOCK'event and CLOCK='1')then
		
	--if(LEVEL/="00000")then
	--	LASTLEVEL:=LEVEL;
	--end if;
	
	case LEVEL is
		when "00001" => LASTLEVEL:=LEVEL;
		when "00010" => LASTLEVEL:=LEVEL;
		when "00100" => LASTLEVEL:=LEVEL;
		when "01000" => LASTLEVEL:=LEVEL;
		when "10000" => LASTLEVEL:=LEVEL;
		when others => LASTLEVEL:=LASTLEVEL;
	end case;
	
	if(START='0')then -- INICIALIZACIÓN DE VARIABLES A USAR DURANTE ESTADO DE "RESET" (not(START))
		for j in 4 downto 0 loop
			UPRIORITY(j):="00000"; -- PRIORIDADES DE SUBIDA
			DPRIORITY(j):="00000"; -- PRIORIDADES DE BAJADA
			CPRIORITY(j):="00000"; -- PRIORIDADES DE CABINA
		end loop;
		UNEW:="00000"; -- NUEVA PRIORIDAD DE SUBIDA
		DNEW:="00000"; -- NUEVA PRIORIDAD DE BAJADA
		CNEW:="00000"; -- NUEVA PRIORIDAD DE CABINA
		STANDBY:='1'; -- ESPERANDO POR INSTRUCCIONES
		BAJA:='0'; -- ELEVADOR NO SUBE
		SUBE:='0'; -- ELEVADOR NO BAJA
		UFLAG:=false; -- NO HAY DOBLE INSTRUCCIÓN EN SUBIDA
		DFLAG:=false; -- NO HAY DOBLE INSTRUCCIÓN EN BAJADA
		CFLAG:=false; -- NO HAY DOBLE INSTRUCCIÓN EN CABINA
		UCOUNT:=0;
		DCOUNT:=0;
		CCOUNT:=0;
		TEMP:=16383; -- 16383 -- 1
	end if;
		
	if(START='1')then	-- SEÑAL DE ACTIVACIÓN DEL ESTADO "SET"
	
		-------------------- DETECTORES DE DOBLE INSTRUCCIÓN PARA GOUP Y GODOWN ------------------
	
		for j in 3 downto 1 loop
			for k in j-1 downto 0 loop
				if(GOUP(j)=GOUP(k) and GOUP(j)='1')then
					UFLAG:=true;
				end if;
			end loop;
		end loop;
		
		for j in 3 downto 1  loop
			for k in j-1 downto 0  loop
				if(GODOWN(j)=GODOWN(k) and GODOWN(j)='1')then
					DFLAG:=true;
				end if;
			end loop;
		end loop;
		
		for j in 4 downto 1  loop
			for k in j-1 downto 0  loop
				if(GOLEVEL(j)=GODOWN(k) and GOLEVEL(j)='1')then
					CFLAG:=true;
				end if;
			end loop;
		end loop;
		
		------ NUEVA DEBE SER "000000" PARA EVITAR QUE SE BORRE UNA INSTRUCCIÓN SIN CARGAR ------
	
		if(UNEW="00000" and GOUP/="0000" and not(UFLAG))then 
			UNEW:='0'&GOUP; -- SE CARGA UNA NUEVA INSTRUCCIÓN DE SUBIDA
		end if;
		
		if(DNEW="00000" and GODOWN/="0000" and not(DFLAG))then
			DNEW:=GODOWN&'0'; -- SE CARGA UNA NUEVA INSTRUCCION DE BAJADA
		end if;
		
		if(CNEW="00000" and GOLEVEL/="00000" and not(CFLAG))then
			CNEW:=GOLEVEL; -- SE CARGA UNA NUEVA INSTRUCCION DE BAJADA
		end if;
				
		-------------------------------- BORRAR PRIORIDAD REPETIDA ------------------------------
		
		if(UNEW/="00000")then
			for j in 4 downto 0 loop
				if(UNEW=UPRIORITY(j))then
					UPRIORITY(j):=UNEW; -- SI SE REPITE LA PRIORIDAD, SE REEMPLAZA
					exit;
				elsif(UPRIORITY(j)="00000")then
					UPRIORITY(j):=UNEW; -- SI NO, SE INGRESA UNEW EN UNA "PRIORIDAD VACIA"
					exit;
				end if;
			end loop;
			UNEW:="00000"; -- SE REINICIA LA "NUEVA PRIORIDAD"
			UORDER:=false;
			UCOUNT:=0;
		end if;
		
		if(DNEW/="00000")then
			for j in 4 downto 0 loop
				if(DNEW=DPRIORITY(j))then
					DPRIORITY(j):=DNEW; -- SI SE REPITE LA PRIORIDAD, SE REEMPLAZA
					exit;
				elsif(DPRIORITY(j)="00000")then
					DPRIORITY(j):=DNEW; -- SI NO, SE INGRESA UNEW EN UNA "PRIORIDAD VACIA"
					exit;
				end if;
			end loop;
			DNEW:="00000";
			DORDER:=false;
			DCOUNT:=0;
		end if;
		
		if(CNEW/="00000")then
			for j in 4 downto 0 loop
				if(CNEW=CPRIORITY(j))then
					CPRIORITY(j):=CNEW; -- SI SE REPITE LA PRIORIDAD, SE REEMPLAZA
					exit;
				elsif(CPRIORITY(j)="00000")then
					CPRIORITY(j):=CNEW; -- SI NO, SE INGRESA UNEW EN UNA "PRIORIDAD VACIA"
					exit;
				end if;
			end loop;
			CNEW:="00000";
			CORDER:=false;
			CCOUNT:=0;
		end if;
		
		----------------------------- TRATAMIENTO DE PRIORIDADES -------------------------------
		
		for j in 4 downto 0 loop
			if((UPRIORITY(j)=LEVEL and UPRIORITY(j)/="00000") or (DPRIORITY(j)=LEVEL and DPRIORITY(j)/="00000") or (CPRIORITY(j)=LEVEL and CPRIORITY(j)/="00000"))then -- ELEVADOR EN NIVEL SOLICITADO
				
				DOOR<="10"; -- SE ABRE LA PUERTA
				STANDBY:='1'; -- COMIENZA MODO DE ESPERA
				SUBE:='0'; -- NO SUBE
				BAJA:='0'; -- NO BAJA
				UCOUNT:=0; -- SE INICIALIZA EL CONTEO DE PRIORIDADES EN UPRIORITY
				DCOUNT:=0; -- SE INICIALIZA EL CONTEO DE PRIORIDADES EN DPRIORITY
				CCOUNT:=0; -- SE INICIALIZA EL CONTEO DE PRIORIDADES EN CPRIORITY
				TEMP:=0;
				
				------------------ SE ELIMINA LA "PRIMERA" DE LAS PRIORIDADES -----------------
				
				if(UPRIORITY(j)=LEVEL)then
					for k in j downto 0 loop
						if(UPRIORITY(k)/="00000" and k>0)then
							UPRIORITY(k):=UPRIORITY(k-1);
						elsif(UPRIORITY(k)/="00000" and k=0)then
							UPRIORITY(k):="00000";
						end if;
					end loop;
					UORDER:=false;
				end if;
					
				if(DPRIORITY(j)=LEVEL)then
					for k in j downto 0 loop
						if(DPRIORITY(k)/="00000" and k>0)then
							DPRIORITY(k):=DPRIORITY(k-1);
						elsif(DPRIORITY(k)/="00000" and k=0)then
							DPRIORITY(k):="00000";
						end if;
					end loop;
					DORDER:=false;
				end if;
				
				if(CPRIORITY(j)=LEVEL)then
					for k in j downto 0 loop
						if(CPRIORITY(k)/="00000" and k>0)then
							CPRIORITY(k):=CPRIORITY(k-1);
						elsif(CPRIORITY(k)/="00000" and k=0)then
							CPRIORITY(k):="00000";
						end if;
					end loop;
					CORDER:=false;
				end if;
				
				exit;
			
			else
				
				case TEMP is
					
					when 16383 =>	DOOR<="01"; -- PUERTAS CERRADAS --16383 -- 1
									STANDBY:='0'; 
					when others =>	TEMP:=TEMP+1;
										DOOR<="10"; -- PUERTAS ABIERTAS
										STANDBY:='1'; -- MODO DE ESPERA
				end case;
				
				--DOOR<="01"; -- SE CIERRAN LAS PUERTAS
				--STANDBY:='0';

			end if; 
		end loop;
					
		if(UCOUNT=0)then
			for j in 4 downto 0 loop
				if(UPRIORITY(j)/="00000")then
					UCOUNT:=UCOUNT+1;
				end if;
			end loop;
		end if;

		if(DCOUNT=0)then
			for j in 4 downto 0 loop
				if(DPRIORITY(j)/="00000")then
					DCOUNT:=DCOUNT+1;
				end if;
			end loop;
		end if;
		
		if(CCOUNT=0)then
			for j in 4 downto 0 loop
				if(CPRIORITY(j)/="00000")then
					CCOUNT:=CCOUNT+1;
				end if;
			end loop;
		end if;
				
		if(SUBE=BAJA and CCOUNT=0)then
			
			if(UCOUNT>DCOUNT)then
				if(UPRIORITY(4)>LASTLEVEL)then
					SUBE:='1';
					BAJA:='0';
				end if;
				if(UPRIORITY(4)<LASTLEVEL)then
					SUBE:='0';
					BAJA:='1';
				end if;
			end if;
		
			if(UCOUNT<DCOUNT)then
				if(DPRIORITY(4)>LASTLEVEL)then
					SUBE:='1';
					BAJA:='0';
				end if;
				if(DPRIORITY(4)<LASTLEVEL)then
					SUBE:='0';
					BAJA:='1';
				end if;
			end if;
			
			if(UCOUNT=DCOUNT)then
			
				if(DPRIORITY(4)/="00000")then -- LA PRIORIDAD ES BAJAR
					if(DPRIORITY(4)>LASTLEVEL)then
						SUBE:='1';
						BAJA:='0';
					end if;
					if(DPRIORITY(4)<LASTLEVEL)then
						SUBE:='0';
						BAJA:='1';
					end if;
				end if;
									
				if(UPRIORITY(4)="00000" and DPRIORITY(4)="00000")then -- ESTACIONARIO: SIN PRIORIDADES
					SUBE:='0';
					BAJA:='0';
				end if;
				
			end if;
					
		elsif(SUBE=BAJA and CCOUNT>0)then
			if(CPRIORITY(4)>LASTLEVEL)then
				SUBE:='1';
				BAJA:='0';
			end if;
			if(CPRIORITY(4)<LASTLEVEL)then
				SUBE:='0';
				BAJA:='1';
			end if;
		end if;
--------------------------------------------------------------------------------------------
end if; -- START ='1'

if(STANDBY='0')then
	UP<=SUBE;
	DOWN<=BAJA;
elsif(STANDBY='1')then
	UP<='0';
	DOWN<='0';
end if;

end if; -- SINCRONÍA CON RELOJ
end process;
end FUNK;