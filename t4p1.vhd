--PROJEKTOVATI RAM MEMORIJU OD 256 OSMOBITNIH PODATAKA KOJA SINRONO SA DOZVOLAMA UPISA I CIANJA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_unsigned.all;
entity konverzija is
    port(
        clk,clr: in std_logic;
        ulaz: in integer range 0 to 64;
        dozvoliUpis,dozvoliCitanje:in std_logic;
        adresa: in unsigned(7 downto 0);
        izlaz : out integer range 0 to 64
    );
    end entity konverzija;
    architecture ram of konverzija is
        type memorija is array (natural range<>) of unsigned(7 downto 0);
        begin
        process(clk,clr)
        variable ramMemorija:ram(255 downto 0);
        variable addrr:integer range 0 to 255;
        begin
            if clk'event and clk='1' then
                if clr='1' then
                    ramMemorija:=(others=>'0');
                else
                    if dozvoliUpis='1' then
                        addrr:=to_integer(adresa);
                        ramMemorija(addrr):=to_unsigned(ulaz,8);
                    end if;
                    if dozvoliCitanje='1' then
                        addrr:=to_integer(adresa);
                        izlaz<=to_integer(ramMemorija(addrr));
                    end if;
                end if;
            end if;

            end process; 
            end architecture ram;
entity konverzijaTB is
    end entity konverzijaTB;
    architecture test of konverzijaTB is
        signal ulaz,izlaz: integer 0 to 63;
        signal dozvoliUpis,dozvoliCitanje,clk,clr: std_logic;
        signal adresa: unsigned(7 downto 0);
        begin
            uut: entity work.konverzija(ram)
            port map(
                ulaz=>ulaz,
                izlaz=>izlaz,
                dozvoliUpis=>dozvoliUpis,
                dozvoliCitanje=>dozvoliCitanje,
                adresa=>adresa,
                clk=>clk,
                clr=>clr
            );
            stimuli:process
            begin
                ulaz<=3;
                dozvoliUpis<='1';
                clk<='1';
                clr<='1';
                clr<= '0' after 5ns;
                adresa<='00011101';
                dozvoliCitanje<='1' after 5ns;
                adresa<='00111110';


                end process stimuli;

            end architecture test;