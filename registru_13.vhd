-- registru pe 13 biti care face resetare si incarcare paralela

entity registru_13 is
	port (intr: in bit_vector (12 downto 0);
	clk: in bit;
	clr: in bit;
	ies: out bit_vector (12 downto 0));
end entity;

architecture behave of registru_13 is
begin
	process (clk, clr)
	begin 
		if clr='1' then
			ies<="0000000000000";								--resetare
		elsif clk = '1' and clk'event then					 	-- incarcare paralela
			ies <= intr;
		end if;
	end process;
end architecture;