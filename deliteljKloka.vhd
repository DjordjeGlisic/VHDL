--;IMLEMENTIRATI DELITELJ KLOKA KOJI FUNKCIONISE TAKO STO MU SE PROSLEDI KLOK SIGNAL I KOLIKO TAKTINIH CIKLUSA ON TREBA BITI AKTIVAN
--SAM KOLOK SIGNAL MOZE MENJATI VREDNOST ALI PRVA POSLATA VREDNOST KLOK SIGNALA KADA JE CLR=1 BIVA ZAPAMCENA I KADA SE IZBROJI DO N TADA SE TA ZAPAMCENA VREDNOST PROMENI STO JE I KONACAN REZULTAT DELJENJA(USPORAVANJA) KLOKA
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
entity delitelj is
    generic(n:integer:=8);
    port(
        clk_in,clr: in std_logic;
        clk_out: out std_logic;
    );
    end entity delitelj;
    architecture deli of delitelj is
        signal counter:integer range 0 to 2**n;
        signal pom_out:std_logic;
        begin
            process(clk_in,clr)
            begin
            if clr='1' then
            counter<=0;
            pom_out<=clk_in;
            else
                counter<=counter+1;
                if counter=n then
                    pom_out<= not pom_out;
                    end if;
                end if;
                end process;
                clk_out<=pom_out;
                
            end architecture deli;
            LIBRARY IEEE;
            USE IEEE.STD_LOGIC_1164.ALL;
            USE IEEE.STD_LOGIC_ARITH.ALL;
            USE IEEE.NUMERIC_STD.ALL;
            entity test is
                generic(n:integer:=4);
                end entity test;
                architecture testiraj of test is
                    signal clk_in,clk_out,clr:std_logic;
                    begin
                        uut: entity work.delitelj(deli)
                        generic map(
                        n=>n;
                        );
                        port map(
                            clk_in=>clk_in,
                            clk_out=>clk_out,
                            clr=>clr
            
                        );
                        process(clk_in)
                        begin
                            clk_in<= not clk_in after 2 ns;
                            end process;
                        
                        stimuli:process
                        begin
                            clr<='1';
                            wait for 1 ns;
                            clr<='0';
                            clk_in<='0';
                            wait for 10 ns;
                            clk_in<='0';
                            wait for 10 ns;
                            clk_in<='0';
                            wait for 10 ns;
                            wait;
            
                            end process stimuli;
                        end architecture testiraj;