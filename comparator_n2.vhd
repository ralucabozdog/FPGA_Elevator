-- comparator de 2 numere pe 13 biti, acesta va fi folosit pentru a decide daca o cerere introdusa din interiorul liftului se refera la un etaj mai mic sau mai mare decat etajul curent

entity comparator_n2 is
	port (n2, n3: in bit_vector(12 downto 0);  -- intrarile pe 13 biti, in implementare n2 va retine informatia cu privire la etajul curent, iar n3 va retine informatia despre etajul spre care se face cererea
	y_sus, y_jos: out bit_vector(12 downto 0));	  -- iesirile pe 13 biti
end entity;

architecture comportamental of comparator_n2 is
begin
	process (n2, n3)
	begin
		if n3>n2 then
			y_sus <= n3;	   	-- daca n3 este mai mare decat n2 (in implementare, daca etajul spre care se face cererea este superior etajului curent, deci cererea este de urcare) yesirea y_sus va primi
			y_jos <= "0000000000000";	-- informatia de pe intrarea n3 iar iesirea y_jos va fi formata din 13 biti de 0
		elsif n3<n2 then			-- daca n3 ete mai mic decat n2, cererea este de coborare si deci iesirea y_jos va primi intrarea n3, iar y_sus va fi forata din 13 biti de 0
			y_jos <= n3;
			y_sus <= "0000000000000";
		else 					  -- in cazul ipotetic in care n2 = n3 (utilizatorul introduce o cerere de deplasare spre etajul la care se se afla deja) pe ambele iesiri se vor scrie 13 biti de 0
			y_jos <= "0000000000000";	-- si astfel nu se va inregistra o astfel de cerere
			y_sus <= "0000000000000";
		end if;	 
	end process;
end architecture;
		