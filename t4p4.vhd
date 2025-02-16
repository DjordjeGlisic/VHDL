
--PROJEKTOVATI N-2 NA N DEKODER KOJI RADI SA AKTIVNOM NISKOM IVICOM SINHRONIM PUTEM
library ieee; 

  use ieee.std_logic_1164.all; 

  use ieee.numeric_std.all;  
entity dekoder is
    generic(
        n:integer:=8;

    );
    port(
        adresa:in unsigned(n-1 downto 0);
        clk,clr,we:in std_logic;
        izlaz:out std_logic_vector(2**n-1 downto 0)
    );
    end entity dekoder;
    architecture dekodiraj of dekoder is
        begin
            process(clk)
            variable adr: natural range 2**n-1 to 0;
            variable mem: std_logic_vector(2**n-1 downto 0);
            begin
                if clk'event and clk='0' then
                    if clr='1' then
                        mem:=(others=>'0');
                        elsif we='1' then
                            adr:= to_integer(adresa);
                            mem(adr):='1';
                        end if;
                    end if;
                    izlaz<=mem;
                end process;
            end architecture dekodiraj;
                    entity testiraj is 
                    generic(n:integer=2);
                        end entity testiraj;
                        architecture test of testiraj is
                            signal adresa:unsigned(n-1 downto 0);
                            signal izlaz:std_logic_vector(2**n-1 downto 0 );
                            signal clk,clr,we:std_logic;
                            begin
                                uut: entity work.dekoder(dekodiraj)
                                generic map(
                                    n=>n;
                                )
                                port map(
                                    adresa=>adresa,
                                    izlaz=>izlaz,
                                    clk=>clk,
                                    clr=>clr,
                                    we=>we
                                );
                                process(clk,clr,we)
                                begin
                                    clk<=not clk after 1 ns;
                                    clr<=not clr after 10 ns;
                                    we<=not we after 5 ns;
                                    end process;
                                stimuli: process
                                begin
                                    adresa<="01";
                                    we<='0';
                                    clk<='0';
                                    clr<='1';
                                    wait for 1 ns;
                                    adresa<="10";
                                    wait for 1 ns;
                                    adresa<="11"
                                    wait;
                                    end process stimuli;
                                end architecture test;
