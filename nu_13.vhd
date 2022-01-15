-- poarta nu pe 13 biti, neaga fiecare bit individual al intrarii

entity nu_13 is
	port(a: in bit_vector (12 downto 0);
	y: out bit_vector (12 downto 0));
end nu_13;

architecture arch of nu_13 is
begin
	y<=not a;
end arch;