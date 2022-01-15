library IEEE;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;

entity lift is
	port (clk: in bit;				 								--	clk placa
	clk_sus,clk_jos,clk_int: in bit;							   	--	butoane 
	ok_int, ok_ext: in bit;									
	sens_cerere: in bit;											-- switch-uri
	init: in bit;												    
	su, sg: in bit;
	viteza: in bit;
	a0,a1, a2, a3: out bit;										   --iesiri pentru anozi bcd 7 segmente
	a,b,c,d,e,f,g,dp: out bit;									   --iesiri pentru catozi bcd 7 segmente
	greutate_depasita: out bit;									   -- led-uri
	usi_inchise: out bit;
	viteza_aleasa: out bit);
end entity;

architecture strctural of lift is

component div_1 is
	port (clk: in bit;
	clk_div: out bit);
end component;

component num_mod_13 is 
	port(Clock: in bit;
			CLR: in  bit;
			Q: out bit_vector(3 downto 0));
end component;

component div_3 is   
	port (clk: in bit;    
	clk_div: out bit);
end component;

component si_4 is
	port(a,b,c,d: in bit;
	y: out bit);
end component;

component num2 is 
	port(clk1, clk3: in bit;
		viteza: in bit;
		en: in bit; 			
		CLR: in  bit;
		sens: in bit;				 		
		Q: out bit_vector(3 downto 0));
end component;

component decod_13 is
	port(intr: in bit_vector (3 downto 0); 
	enable: in bit;
	ies: out bit_vector (12 downto 0));
end	component;

component si_2_13 is
	port(a,b: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end component;

component si_2_1bit is
	port(a,b: in bit;
	y: out bit);
end component;

component sau_3_13biti is
	port(a,b,c: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end component;

component registru_13 is
	port (intr: in bit_vector (12 downto 0);
	clk: in bit;
	clr: in bit;
	ies: out bit_vector (12 downto 0));
end component;

component nu_13 is
	port(a: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end component;

component comp_decizie is
	port(n2: in bit_vector (3 downto 0);
	sus: in bit_vector (12 downto 0);
	jos: in bit_vector (12 downto 0);
	sens_lift: in bit;
	dec: out bit_vector (12 downto 0));
end component;

component comparator_13 is
	port(n2, dest: in bit_vector (12 downto 0);
	init: in bit;
	egal: out bit;
	ctrl: out bit;
	sens_lift: out bit);
end component;

component codificator_1_13 is
	port (x: in bit;
	y: out bit_vector (12 downto 0));
end component;	

component inversor is
	port (x: in bit;
	y: out bit);
end component;

component decod_13_lift is
	port(intr: in bit_vector (3 downto 0);
	enable: in bit;
	ies: out bit_vector (12 downto 0));
end component;

component registru_13_dest is
	port (intr: in bit_vector (12 downto 0);
	clk: in bit;
	ies: out bit_vector (12 downto 0));
end component;	

component comparator_n2 is
	port (n2, n3: in bit_vector(12 downto 0);
	y_sus, y_jos: out bit_vector(12 downto 0));
end component;

component n_timp is
	port(clk: in bit;
	egal: in bit;
	q: in bit;
	carry: out bit);
end component;

component bist_D is
	port(clk: in bit;
	clr: in bit;
	d: in bit; 
	q: out bit);
end component;

component componenta_afisare is
	port(clk: in bit;
	n2: in bit_vector (3 downto 0);
	sens_lift: in bit;
	a0,a1,a2,a3,a,b,c,d,e,f,g,dp: out bit);
end component;

signal clk_div_1, clk_div_3, carry, enable, sens_lift, egal, nsg, nsu, ctrl, q, ok_sus, ok_jos, n_sens_cerere: bit;   		 --semnale intermediare pe 1 bit
signal N3, Ns, Nj, N2: bit_vector (3 downto 0);																				 --semnale intermediare pe 4 biti
signal N3_13, int_13_sus, int_13_jos, Ns_13, intr_sus, sus,	fct_t_sus, fct_sus, Nj_13, intr_jos, jos, fct_t_jos, fct_jos, sens_lift_13, not_sens_lift_13, dest, not_dest, dec, N2_13, egal_13, not_egal_13: bit_vector (12 downto 0);			   --semnale intermediare pe 13 biti

begin
	divizor_1:					div_1 port map(clk, clk_div_1);	 													 -- divizoare de frecventa
	divizor_3: 					div_3 port map(clk, clk_div_3);									
	
	inversor_sens_cerere:       inversor port map (sens_cerere, n_sens_cerere);										
	fct_ok_sus:					si_2_1bit port map (sens_cerere, ok_ext, ok_sus);  									-- poarta logica pentru inregistrarea cererilor de urcare
	fct_ok_jos:			   		si_2_1bit port map (n_sens_cerere, ok_ext, ok_jos);									-- poarta logica pentru inregistrarea cererilor de coborare
	
	numarator_int: 				num_mod_13 port map(clk_int, ok_int, N3);											--numarator pentru introducerea cererilor din interior
	numarator_sus: 				num_mod_13 port map(clk_sus, ok_sus, Ns);											--numarator pentru introducerea cererilor de urcare din exterior
	numarator_jos: 				num_mod_13 port map(clk_jos, ok_jos, Nj);											--numarator pentru introducerea cererilor de coborare din exterior
	 
	bistabil_D: 				bist_D port map (clk_div_1,init,egal,q);											--componente necesare pentru temporizare
	num_timp: 					n_timp port map (clk_div_1, egal, q, carry);
	
	nu_sg: 						inversor port map(sg, nsg);
	nu_su: 						inversor port map(su, nsu);
	si_enable: 					si_4 port map(nsg, nsu, carry, ctrl, enable);											   
	numarator_lift: 			num2 port map(clk_div_1, clk_div_3, viteza, enable, init,  sens_lift, N2);			--numarator ce indica etajul curent

	decodificator_ni:			decod_13 port map(N3,ok_int, N3_13);
	decodificator_ns:			decod_13 port map(Ns,ok_sus, Ns_13);
	decodificator_nj:			decod_13 port map(Nj,ok_jos, Nj_13);
	decodificator_n2:			decod_13_lift port map(N2,enable, N2_13);
	comparator_n2_ni:			comparator_n2 port map(N2_13, N3_13, int_13_sus, int_13_jos);
	
	sau_registru_sus:			sau_3_13biti port map(fct_sus, int_13_sus, Ns_13, intr_sus);
	registru_sus:				registru_13 port map(intr_sus, clk_div_1, init, sus); 								--registru ce retine cererile de urcare
	codificator_sens:			codificator_1_13 port map(sens_lift, sens_lift_13);	   									
	codificator_egal:			codificator_1_13 port map(egal, egal_13);											   
	inversor_sens_lift:			nu_13 port map(sens_lift_13, not_sens_lift_13); 									 
	inversor_dest:				nu_13 port map(dest, not_dest);														 
	inversor_egal:				nu_13 port map(egal_13, not_egal_13);												 
	sau_fct_sus:				sau_3_13biti port map(not_sens_lift_13, not_dest, not_egal_13, fct_t_sus);
	si_registru_sus:			si_2_13 port map(sus, fct_t_sus, fct_sus);											
	
	sau_registru_jos:			sau_3_13biti port map(fct_jos, int_13_jos, Nj_13, intr_jos);
	registru_jos:				registru_13 port map(intr_jos, clk_div_1, init, jos);								--registru ce retine cererile de coborare
	sau_fct_jos:				sau_3_13biti port map(sens_lift_13, not_dest, not_egal_13, fct_t_jos);
	si_registru_jos:			si_2_13 port map(jos, fct_t_jos, fct_jos);											
	
	comparator_decizie:			comp_decizie port map(N2, sus, jos, sens_lift, dec);										  
	registru_dest:				registru_13_dest port map(dec, clk_div_1, dest);	 								--registru ce retine urmatoarea destinatie
	comparator_sens:			comparator_13 port map(N2_13, dest, init, egal, ctrl, sens_lift);
	
	bcd_7_segmente:				componenta_afisare port map(clk_div_1, N2, sens_lift, a0, a1, a2, a3, a, b, c, d, e, f, g, dp);		-- anozii si catozii sunt iesiri ale automatului => componenta speciala de afisare
	
	greutate_depasita<=nsg;				  --iesiri pentru led-uri
	usi_inchise<=carry;
	viteza_aleasa<=viteza;
end architecture;
	