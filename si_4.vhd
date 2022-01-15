-- poarta si cu 4 intrari pe un bit

entity si_4 is
	port(a,b,c,d: in bit;
	y: out bit);
end si_4;

architecture arch of si_4 is
begin
	y<=a and b and c and d;
end arch;