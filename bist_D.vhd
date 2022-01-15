-- bistabil de tip D

entity bist_D is
	port(clk: in bit;
	clr: in bit;
	d: in bit; 
	q: out bit);
end entity;

architecture arch of bist_D is
begin
	process(clk, clr)
	begin
		if clr='1' then
			q<='0';
		elsif clk='1' and clk'event then
			q<=d;
		end if;
	end process;
end architecture;
		