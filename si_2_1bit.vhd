-- poarta si cu 2 intrari pe un bit

entity si_2_1bit is
	port(a,b: in bit;
	y: out bit);
end entity;

architecture arch of si_2_1bit is
begin
	y<=a and b;
end arch;
