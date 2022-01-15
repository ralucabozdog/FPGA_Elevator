-- decodificator cu intrarea pe 4 biti si iesirea pe 13 biti

entity decod_13_lift is
	port(intr: in bit_vector (3 downto 0);--informatie numarator n1
	enable: in bit;
	ies: out bit_vector (12 downto 0));
end decod_13_lift;

architecture arch of decod_13_lift is
begin
	process (intr,enable)
	begin
		if enable='1' then								--daca enable este 1, atunci valorile de pe iesiri se vor modifica; in caz contrar se va pãstra ultima valoare
			case intr is
			when "0000" => ies <= "0000000000001";
			when "0001" => ies <= "0000000000010";
			when "0010" => ies <= "0000000000100";
			when "0011" => ies <= "0000000001000";
			when "0100" => ies <= "0000000010000";
			when "0101" => ies <= "0000000100000";
			when "0110" => ies <= "0000001000000";
			when "0111" => ies <= "0000010000000";
			when "1000" => ies <= "0000100000000";
			when "1001" => ies <= "0001000000000";
			when "1010" => ies <= "0010000000000";
			when "1011" => ies <= "0100000000000";
			when "1100" => ies <= "1000000000000";
			when others => ies <= "0000000000000";		--celelalte valori sunt oricum inaccesibile, deoarece numaratorul pentru lift este modulo 13	
			end case;
		end if;
	end process;
end arch;
		