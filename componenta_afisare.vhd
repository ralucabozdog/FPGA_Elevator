-- componenta pentru controlarea afisoarelor de tip bcd 7 segmente de pe placa
entity componenta_afisare is
	port(clk: in bit;   				-- intrare de clock
	n2: in bit_vector (3 downto 0);	 	-- intrare pe 4 biti reprezentand etajul curent al liftului pe care va fi nevoie sa o afisam
	sens_lift: in bit;	 				-- intrare pe un bit reprezentand sensul de deplasare al liftului
	a0,a1,a2,a3: out bit;		   		-- iesirile ce controleaza anozii afisoarelor de pe placa, active pe 0 logic
	a,b,c,d,e,f,g,dp: out bit);			-- iesirile ce controloleaza segmentele individuale ale afisoarelor bcd 7 segmente de pe placa, active pe 0 (corespund catozilor)
end entity;

architecture arch of componenta_afisare is
begin
	process (clk)
	begin
		if clk='1' and clk' event then		-- la fiecare impuls de tact se afiseaza informatiile care se afla in acel moment pe inrtrarile n2 si sens_lift
			--sens
			if sens_lift='0' then 			-- daca sensul este de coborare, pe afisorul controlat de anodul a2 se va aprinde ledul corespunzator segmentului d
					a <= '1';	  			-- se pun informatiile pe catozi
					b <= '1';
					c <= '1';
					d <= '0';
					e <= '1';
					f <= '1';
					g <= '1';
					dp<= '1';
					a0<= '1';
					a1<= '1';
					a2<= '0';				-- se activeaza anodul a2 corespunzator celui de-al treilea afisor de la draptea spre stanga
					a3<= '1';
					
			else
					a <= '0';
					b <= '1';
					c <= '1';
					d <= '1';
					e <= '1';
					f <= '1';
					g <= '1';
					dp<= '1';
					a0<= '1';
					a1<= '1';
					a2<= '0';
					a3<= '1';
			end if;
			a2<='1';						-- se dezactivraza anodul a2 pentru ca mai apoi sa se poata afisa informatia cu privire la etajul curent
			
			case n2 is
			when "0000" => 
			
			-- zeci
			a <= '1';						-- daca etajul curent este o cifra afisorul corespunzator cifrei zecilor, va avea toate segmentele inactive (nu se va afisa nimic)
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			
			--unitati
			
			a <= '0';	   					-- se pun informatiile pe catozi
			b <= '0';					 	-- cand etajul curent este parterul, in loc de cifra 0, se va afisa litera P
			c <= '1';
			d <= '1';
			e <= '0';
			f <= '0';
			g <= '0';
			dp<= '1';
			a0<= '0';						-- se activeaza anodul a0 corespunzator afisorului pentru cifra unitatilor
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';		 				-- se dezactiveaza anodul a0
			
			when "0001" =>
			
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			
			--unitati
			a <= '1';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "0010" =>
			
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			
			--unitati
			a <= '0';
			b <= '0';
			c <= '1';
			d <= '0';
			e <= '0';
			f <= '1';
			g <= '0';  
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "0011" =>
			
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			
			--unitati
			a <= '0';
			b <= '0';
			c <= '0';
			d <= '0';
			e <= '1';
			f <= '1';
			g <= '0';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			when "0100" =>
			
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			
			--unitati
			a <= '1';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '0';
			g <= '0';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "0101" =>
			
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1'; 
			--unitati
			a <= '0';
			b <= '1';
			c <= '0';
			d <= '0';
			e <= '1';
			f <= '0';
			g <= '0';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "0110" =>
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			--unitati
			a <= '0';
			b <= '1';
			c <= '0';
			d <= '0';
			e <= '0';
			f <= '0';
			g <= '0'; 
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "0111" =>
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			--unitati
			a <= '0';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "1000" =>
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			--unitati
			a <= '0';
			b <= '0';
			c <= '0';
			d <= '0';
			e <= '0';
			f <= '0';
			g <= '0';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "1001" =>
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';  
			dp<= '1'; 
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';  
			--unitati
			a <= '0';
			b <= '0';
			c <= '0';
			d <= '0';
			e <= '1';
			f <= '0';
			g <= '0';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "1010" =>
			--zeci
			a <= '1';  					-- incepand cu valori mai mari sau egale decat 1010 primite pe intrarea n2 se va afisa 1 pe afisorul corespunzator cifrei zecilor controlat de anodul a1
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '1';
			a1<= '0'; 					-- se activeaza anodul a1, corespunzator cifrei zecilor
			a2<= '1';
			a3<= '1';
			
			a1<= '1';  					-- se dezactiveaza anodul a1, pentru a putea fi afisata cifra unitatilor, folosind anodul a0
			--unitati
			a <= '0';					-- se activeaza catozii corespunzatori segmentelor ce formeaza cifra unitatilor
			b <= '0';
			c <= '0';
			d <= '0';
			e <= '0';
			f <= '0';
			g <= '1';
			dp<= '1';
			a0<= '0';					-- se activeaza anodul a0 corespunzator cifrei unitatilor (afisorul cel mai din dreapta)					
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';					-- se dezactiveaza anodul a0
			when "1011" =>
			--zeci
			a <= '1';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			--unitati
			a <= '1';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			
			when "1100" =>
			--zeci
			a <= '1';
			b <= '0';
			c <= '0';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1';
			--unitati
			a <= '0';
			b <= '0';
			c <= '1';
			d <= '0';
			e <= '0';
			f <= '1';
			g <= '0';  
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			when others =>
			--zeci
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '1';
			a1<= '0';
			a2<= '1';
			a3<= '1';
			
			a1<= '1'; 
			
			--unitati
			a <= '1';
			b <= '1';
			c <= '1';
			d <= '1';
			e <= '1';
			f <= '1';
			g <= '1';
			dp<= '1';
			a0<= '0';
			a1<= '1';
			a2<= '1';
			a3<= '1';
			
			a0<= '1';
			end case;
			
		a <= '1';						-- segmentele individuale ale afisorului din stanga trebuie sa fie in tot acest timp dezactivate, deoarece acesta nu este necesar afisarii informatiilor primite
		b <= '1';						-- pe intrari (va fi stins pe tot parcursul functionarii automatului)
		c <= '1';
		d <= '1';
		e <= '1';
		f <= '1';
		g <= '1';  
		dp<= '1'; 
		a0<= '1';
		a1<= '1';
		a2<= '1';
		a3<= '0';
			
		a3<= '1';
		end if;
	end process;
end architecture;
			

