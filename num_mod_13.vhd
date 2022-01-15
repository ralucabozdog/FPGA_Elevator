library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- numarator modulo 13 direct
entity num_mod_13 is 
	port(Clock: in bit;		-- intrare sincrona de clock
			CLR: in  bit;	-- semnal asincron de reset, intrare prioritara infata intrarii de clock
			Q: out bit_vector(3 downto 0));		-- iesirea numaratorului, pe 4 biti
end num_mod_13;



architecture archi of num_mod_13 is  
signal tmp: std_logic_vector(3 downto 0) :="0000";  -- semnal intermediar pentru a realiza incrementarea necesara numararii directe
begin
     process (Clock, CLR) 
	 begin  
		if CLR='0' and CLR'event then  	-- numaratorul trebuie sa faca resetare doar cand semnalul de CLR se schimba din 1 in 0, intrucat, in implementarea efectiva,
										-- pe aceasta intrare CLR va ajunge un semnal de ok ce marcheaza finalizarea introducerii unei cereri, iar cand semnalul ok
										-- devine din nou 0 numaratorul va trebui sa fie pregatit pentru un nou ciclu de numarare
       			tmp <= "0000";  
        	elsif (Clock'event and Clock='1') then	-- numaratorul numara crescator pe frontul ascendent al semnalului de tact 	
				if (tmp<"1100")	 then	   			-- numaratorul este unu modulo 13, deci cand acesta ajunge in starea 1100 (corespunzatoare numarului 12), el va trece in starea 0
					tmp <= tmp + 1;					-- altfel, acesta va continua sa numere crescator
					else tmp<="0000";
                end if;
			end if;
     end process; 
        
     Q <= to_bitvector(tmp);	-- iesirea primeste valoarea semnalului intermediar, convertita din std_logic in bit
	 
end archi;
