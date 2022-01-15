-- codificator ce are o intrare pe 1 bit si o iesire pe 13 biti, acesta pune pe toti cei 13 biti ai iesirii valoarea primita pe intrare

entity codificator_1_13 is
	port (x: in bit;
	y: out bit_vector (12 downto 0));
end entity;

architecture arch of codificator_1_13 is
begin
	y(0) <= x;
	y(1) <= x;
	y(2) <= x;
	y(3) <= x;
	y(4) <= x;
	y(5) <= x;
	y(6) <= x;
	y(7) <= x;
	y(8) <= x;
	y(9) <= x;
	y(10) <= x;
	y(11) <= x;
	y(12) <= x;
end architecture;