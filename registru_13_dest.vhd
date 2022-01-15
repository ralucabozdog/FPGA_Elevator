-- registru pe 13 biti care face doar operatia de incarcare paralela

entity registru_13_dest is
	port (intr: in bit_vector (12 downto 0);  -- intrare pe 13 biti
	clk: in bit;   -- semnal de tact
	ies: out bit_vector (12 downto 0));   -- iesire pe 13 biti
end entity;

architecture behave of registru_13_dest is
begin
	process (clk)
	begin
		if clk = '1' and clk'event then	 -- registrul incarca paralel informatia primita pe intrari sincron cu semnalul de tact clk
			ies <= intr;
		end if;	
	end process;
end architecture;