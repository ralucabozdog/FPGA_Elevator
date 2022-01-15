library IEEE;

use ieee.std_logic_1164.all;

use ieee.std_logic_unsigned.all;

-- divizor de frecventa pentru a obtine frecventa corespunzatoare perioadei de 3 secunde intre etaje
entity div_1 is
	port (clk: in bit;
	clk_div: out bit);
end entity;

architecture arch of div_1 is
signal inter: std_logic_vector(25 downto 0) := "00000000000000000000000000";	-- pentru a ajunge la frecventa corespunzatoare intervalului de timp de 1s este nevoie de un numarator pe 26 de biti 
begin
	process(clk,inter)
	begin
		if clk = '1' and clk'event then
			inter <= inter+1;
		end if;
		clk_div <= to_bit(inter(25));	-- cel mai semnificativ bit este cel relevant, cel a carui frecventa de oscilatie este cea mai mica
	end process;
end architecture;