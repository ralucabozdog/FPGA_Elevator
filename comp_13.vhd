library ieee;
use ieee.std_logic_1164.all;

-- comparator pe 13 biti, primeste doua numere pe 13 biti, etajul curent si destinatia liftului si le compara pentru a stabili sensul liftului si daca liftul a ajuns la destinatie sau nu
entity comparator_13 is
	port(n2, dest: in bit_vector (12 downto 0);	
	init: in bit;  -- semnal de initializare a automatului, folosit pe post de reset
	egal: out bit;
	ctrl: out bit; -- 
	sens_lift: out bit);
end comparator_13;

architecture arch of comparator_13 is
begin
	process (n2,dest,init)
	begin 
		if init='1' then 
			sens_lift<='1';									--initial liftul este la parter, poate doar sa urce
			egal<='0';									   --inca nu a onorat nicio cerere, chiar daca stationeaza
			ctrl<='0';									   --liftul nu trebuie sa se deplaseze cat timp sistemul nu este initializat
		else 
			if dest="0000000000000" then				   --nu mai exista cereri
				ctrl<='0';										--deci liftul nu trebuie sa se mai deplaseze
			else 
				ctrl<='1';
					if dest>n2 then
						sens_lift<='1';						--liftul va urca
						egal<='0';						  	--nu a onorat cererea primita ca destinatie
						elsif dest<n2 then 
							sens_lift<='0';					--liftul va coborî
							egal<='0';					 	--nu a onorat cerera primita ca destinatie
						else egal<='1';					  	--liftul a onorat cererea cea mai prioritara
						end if;
					end if;
			end if;
	end process;
end arch;



