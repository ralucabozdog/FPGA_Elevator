-- poarta sau cu 3 intrari pe 13 biti, realizeaza functia logica SAU intre bitii de pe aceeasi pozitie a intrarilor

entity sau_3_13biti is
	port(a,b,c: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end sau_3_13biti;

architecture arch of sau_3_13biti is
begin
	y<=a or b or c;
end arch;