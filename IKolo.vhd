library ieee;
USE ieee.All;
entity ANDKolo is
    port (
        in1, in2 : in bit;
        output : out bit
    );
end entity ANDKolo;

architecture operacija of ANDKolo is
begin
    process(in1, in2)
    begin
        output <= in1 and in2;
    end process;
end architecture operacija;
library ieee;
USE ieee.ALL;
entity Testiranje is
end entity Testiranje;

architecture test of Testiranje is
    signal prvi, drugi : bit;
    signal izlaz : bit;  -- Dodajemo izlazni signal za povezivanje
begin
    uut: entity work.ANDKolo(operacija)
        port map (
            in1 => prvi,
            in2 => drugi,
            output => izlaz
        );

    inicijalizacija: process
    begin
        prvi <= '1';
        drugi <= '0';
        wait for 1 ns;
        
        prvi <= '1';
        drugi <= '1';
        wait for 1 ns;
        
        prvi <= '0';
        drugi <= '0';
        wait for 1 ns;
        
        prvi <= '0';
        drugi <= '1';
        wait for 1 ns;
		wait;
       
    end process inicijalizacija;
end architecture test;

