library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

-- numarator zecimal direct pentru masurarea unui interval de timp de 10 secunde
entity n_timp is
	port(clk: in bit;  	-- intrare de clock
	egal: in bit;		-- intrare ce are valoarea 1 daca etajul curent al liftului este egal cu etajul destinatie si 0 in caz contrar (semnaleaza daca liftul a ajuns sau nu la destinatie)
	q: in bit; 			-- intrare ce reprezinta valoarea semnalului egal intarziata cu un clock (iesirea bistabilului D)
	carry: out bit); 	-- iesire ce are valoarea 1 daca numaratorul a terminat de numarat o bucla completa in intervalul 0-9 (in implementare acesta va numara trecerea a 10 secunde, timp in care
end entity;				-- usile liftului ar trebui sa ramana deschise)

architecture arch of n_timp is
signal s:std_logic_vector(3 downto 0):="0000";	 -- semnal intermediar necesar pentru incrementarea folosita in regimul de numarare directa
begin
	process(clk,egal,q)
	begin 
		if egal='0' then  						 -- daca intrarea egal este 0 logic, deci liftul nu a ajuns la etajul destinatie sau ne aflam pe cazul initial in care egal are valoarea 0
			if q=egal then						 -- daca semnalul egal are aceeasi valoare cu valoarea sa intarziata pe o perioada de un clock (nu s-a schimbat in ultima perioada de clock, liftul se deplaseaza
												 -- de mai mult de un clock), atunci numaratorul trebuie sa numere, fara a modifica valoare lui carry, decat, eventual, din 0 in 1, in cazul in care au trecut cele 10 secunde
				if clk='1' and clk'event then 	
					s<=s+1;						 -- numaratorul va continua sa numere pana va ajunge in starea 1001
					if s="1001" then		     -- daca ajunge in starea 1001, acesta genereaza semnal de carry care indica trecerea intervalului de 10 secunde
						carry<='1';			     -- semnalul de carry este generat la trecerea celor 10 secunde de cand liftul asteapta la parter sau la ultima destinatie cu usile deschise
						s<="0000";				 
					end if;
				end if;
			else
				s<="0000";						 -- daca informatia de pe intrarea egal s-a schimbat in ultima perioada de clock, iar valoarea sa este acum 0 inseamna ca acesta a fost initial 1
												 -- deci in ultima perioada de clock liftul a plecat spre o noua destinatie (daca egal a fost 1, liftul s-a aflat la destinatia precedenta), deci numaratorul
												 -- trebuie sa inceapa un nou ciclu de numarare, dar semnalul carry trebuie sa ramana in continuare 1 pentru ca liftul sa se poata deplasa, deci se va seta doar
												 --	valoarea semnalului intermediar la inceputul buclei de numarare, fara a modifica valoarea lui carry
			end if;
		else									 -- egal are valoarea 1, deci liftul se afla la etajul destinatie	
			if q=egal then						 -- egal are o valoare egala cu valoarea sa intarziata cu un clock (deci nu s-a schimbat in ultima perioada de clock)	
				if clk='1' and clk'event then
					s<=s+1;					     -- asadar numara crescator
					if s="1001" then			 -- daca ajunge in starea 9 genereaza semnal de carry (au trecut cele 10 secunde in care usile liftului trebuiau sa ramana deschide) si reincepe bucla de numarare
						carry<='1';
						s<="0000";
					end if;
				end if;
			else	  							 -- daca egal s-a schimbat din 0 in 1 in ultima perioada de ceas, adica, daca liftul tocmai a ajuns la destinatie, se seteaza carry pe 0 pentru a nu lasa liftul
				carry<='0';						 -- sa se deplaseze pana nu au trecut cele 10 secunde in care usile liftului trebuie sa fie deschide pentru urcarea si coborarea pasagerilor si totodata se
				s<="0000";						 -- revine la inceputul buclei de numarare
			end if;
		end if;	
	end process;
end architecture;