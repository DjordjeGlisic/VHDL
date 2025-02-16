--PROJEKTOVATI BROJAC PO MODULU 256 SA ASIHHRONIM RADOM I DOZVOLOM BROJANJA KAO I UPISA UZ NAVEDEN SMER BROJANJA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity brojac is
    port(
        clr: in std_logic;
        load: in unsigned( 7 downto 0);
        lenable: in std_logic;
        cenable: in std_logic;
        smer: in std_logic;
        izlaz: out unsigned(7 downto 0);
        clk: in std_logic;

    );
    end entity brojac;
    architecture broji of brojac is
        
        begin
            process(clr,clk)
            variable memorija: integer range 0 to 255;
            begin
                if clr='1' then
                    memorija:=0;
                else
                    if lenable='1' then
                        memorija:=to_integer(load);
                    end if;
                    if clk'event and clk='1'then
                        if cenable='1' then
                            if smer='1' then
                                if memorija=255 then
                                    memorija:=0;
                                    else
                                        memorija:=memorija+1;
                                        end if;
                                else
                                    if memorija=0 then
                                        memorija:=255;
                                        else
                                            memorija:=memorija-1;
                                            end if;
                                end if;
                                        
                        end if;
                    
                end if;    

            end if;
            izlaz<=to_unsigned(memorija,8);
            end process;

            end architecture broji;
            library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
entity brojacTest is
    end entity brojacTest;
    architecture test of brojacTest is
        signal clr,clk: std_logic;
        signal parallel: unsigned(7 downto 0);
        signal dozvolaBrojanja: std_logic;
        signal dozvolaUpisa:std_logic;
        signal smer:std_logic;
        signal izlaz:unsigned(7 downto 0);
        begin
            uut: entity work.brojac
            port map(
                clr => clr,
                clk => clk,
                load => parallel,
                lenable => dozvolaUpisa ,
                cenable => dozvolaBrojanja,
                smer => smer,
                izlaz => izlaz

            ); 
            stimuli:process
            begin
                clr<='1';
                wait for 1 ns;
                clr<='0';
                clk<='1';
                clk<= not clk after 2 ns;
                parallel<=to_unsigned(35,8);
                dozvolaBrojanja<='1';
                smer<='1';
                smer<= not smer after 10 ns;
                dozvolaUpisa<='1';
                wait until clk;
                wait;
                end process stimuli;

        end architecture test;