library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- numaratot modulo 13 bidirectional ce indica etajul curent la care se afla liftul
entity num2 is 
	port(clk1, clk3: in bit;				--clock-urile corespunzatoare la 1s, respectiv 3s
		viteza: in bit;						--viteza alege care dintre cele doua clock-uri sa fie cel activ
		en: in bit; 						--enable			
		CLR: in  bit;						--clear (se va face doar la initialiare, pentru a asigura faptul ca numaratorul va indica faptul ca liftul se afla la parter pana cand primeste prima cerere)
		sens: in bit;				 		--sensul in care se deplaseaza liftul, pentru a hotarî daca numaratorul va numara crescator sau descrescator
		Q: out bit_vector(3 downto 0));	  	--iesirea pe 4 biti a numaratorului, indicand etajul curent
end num2;

architecture archi of num2 is  
signal tmp: std_logic_vector(3 downto 0) :="0000";			--semnal intermediar pentru a putea realiza incrementarea/decrementarea necesara numararii
signal clk: bit;											--semnal intermedia ce ia valoarea clock-ului corespunzator vitezei
begin
    process (clk, clk1, clk3, CLR, sens, en, viteza) 
	begin
		if (CLR='1') then   						--resetarea numaratorului pentru init=1
       		tmp <= "0000";
		end if;
		if viteza='0' then
			clk<=clk1;										--selectia clock-ului in functie de viteza; viteza=0 => 1 secunda intre etaje, viteza=1=> 3 secunde intre etaje
		else clk<=clk3;
		end if;
			
		 	if en='1' then									--liftul trebuie sa aiba posibilitatea sa se deplaseze doar daca sunt indeplinite conditiile de enable, rezultate in urma analizei portii si_4 
				if (clk'event and clk='1') then 		   	--mod de numarare (pe front crescator)
					if(sens='1') then						--daca sensul este de urcare, num2 va putea numara crescator de la 0 la 12; daca ajunge la etajul 12 se opreste (nu trece brusc la parter, asa cum ar face un numarator modulo 13 clasic)
						if (tmp<"1100")	 then
							tmp <= tmp + 1;
               			end if;
					else
						if (tmp>"0000") then				--daca sensul este de coborare, num2 va putea numara descrescator de la 12 la 0; daca ajunge la parter se opreste (nu trece brusc la etajul 12, asa cum ar face un numarator modulo 13 clasic)
							tmp<=tmp-1;	
						end if;
					end if;	
				end if;
			end if;
     end process; 
        
     Q <= to_bitvector(tmp);							   	--iesirea primeste valoarea semnalului intermediar, convertita din std_logic in bit
	 
	 
end archi;


