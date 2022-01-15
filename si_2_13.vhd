-- poarta si cu 3 intrari pe 13 biti, realizeaza functia logica SI intre bitii de pe aceeasi pozitie a intrarilor

entity si_2_13 is
	port(a,b: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end si_2_13;

architecture arch of si_2_13 is
begin 
	y<=a and b;
end arch;