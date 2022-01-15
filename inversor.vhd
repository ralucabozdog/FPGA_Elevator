-- poarta nu pe un bit

entity inversor is
	port (x: in bit;
	y: out bit);
end entity;

architecture arch of inversor is
begin
	y <= not x;
end architecture;