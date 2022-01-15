-- decodificator cu intrarea p 4 biti si iesirea pe 13 biti

entity decod_13 is
	port(intr: in bit_vector (3 downto 0); -- intrarea reprezinta un numar pe 4 biti in binar
	enable: in bit;		-- intrare de enable, activa pe 0 logic
	ies: out bit_vector (12 downto 0));	 -- iesirea pe 13 biti, avand un bit de 1 pe pozitia corespunzatoare numarului codificat in binar primit pe iesiri si 0 in rest
end decod_13;

architecture arch of decod_13 is
begin
	process (intr,enable)
	begin
		if enable='1' then	 -- se verifica daca semnalul de enable este 1
			case intr is
			when "0000" => ies <= "0000000000001"; 	 -- daca numarul primit pe intrari este 0, se pune 1 pe pozitia 0 a iesirii
			when "0001" => ies <= "0000000000010";	 -- daca numarul primit pe intrari este 1, se pune 1 pe pozitia 1 a iesirii
			when "0010" => ies <= "0000000000100";	 -- daca numarul primit pe intrari este 2, se pune 1 pe pozitia 2 a iesirii
			when "0011" => ies <= "0000000001000";	 -- daca numarul primit pe intrari este 3, se pune 1 pe pozitia 3 a iesirii
			when "0100" => ies <= "0000000010000";	 -- daca numarul primit pe intrari este 4, se pune 1 pe pozitia 4 a iesirii
			when "0101" => ies <= "0000000100000";	 -- daca numarul primit pe intrari este 5, se pune 1 pe pozitia 5 a iesirii
			when "0110" => ies <= "0000001000000";	 -- daca numarul primit pe intrari este 6, se pune 1 pe pozitia 6 a iesirii
			when "0111" => ies <= "0000010000000";	 -- daca numarul primit pe intrari este 7, se pune 1 pe pozitia 7 a iesirii
			when "1000" => ies <= "0000100000000";	 -- daca numarul primit pe intrari este 8, se pune 1 pe pozitia 8 a iesirii
			when "1001" => ies <= "0001000000000";	 -- daca numarul primit pe intrari este 9, se pune 1 pe pozitia 9 a iesirii
			when "1010" => ies <= "0010000000000";	 -- daca numarul primit pe intrari este 10, se pune 1 pe pozitia 10 a iesirii
			when "1011" => ies <= "0100000000000";	 -- daca numarul primit pe intrari este 11, se pune 1 pe pozitia 11 a iesirii
			when "1100" => ies <= "1000000000000";	 -- daca numarul primit pe intrari este 12, se pune 1 pe pozitia 12 a iesirii
			when others => ies <= "0000000000000";	 -- daca numarul primit pe intrari este 13, 14, 15 (numere care nu corespund niciunui etaj al liftului), iesirea va fi reprezentata de 13 biti de 0
			end case;
		else
			ies<="0000000000000";	 -- daca semnalul de enable este 0, decodificatorul va scoate pe iesiri 13 biti de 0
		end if;
	end process;
end arch;
		