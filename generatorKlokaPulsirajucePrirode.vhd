--IMPLEMENTIRATI GENERATOR KLOKA PULSIRAJUCE PRIRODE
--KADA JE U RESET STANJU PRIMA SE VREDNOST KLOKA I KOLKO DA SE OTKUCA DO PROMENE VREDNOSTI
--VRSI SE BROJANJE DO GRANICE NAKON CEGA UPAMCENI KLOK MENJA VREDNOST I TA VREDNOST SE SALJE NA IZLAZ
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.NUMERIC_STD.ALL;
entity generator is
    port(
        clk_in,clr: in std_logic;
        delitelj:in integer;
        clk_out: out std_logic;

    );
    end entity generator;
    architecture generisi of generator is
        signal counter:integer;
        signal pom_out:std_logic;
        begin
            process(clk_in,clr)
            begin
            if clr='1' then
            counter<=0;
            pom_out<=clk_in;
            else
                counter<=counter+1;
                if counter=delitelj then
                    pom_out<= not pom_out;
                    end if;
                end if;
                end process;
                clk_out<=pom_out;
                
            end architecture generisi;
            LIBRARY IEEE;
            USE IEEE.STD_LOGIC_1164.ALL;
            USE IEEE.STD_LOGIC_ARITH.ALL;
            USE IEEE.NUMERIC_STD.ALL;
            entity test is
                end entity test;
                architecture testiraj of test is
                    signal clk_in,clk_out,clr:std_logic;
                    signal delitelj:integer;
                    begin
                        uut: entity work.generator(generisi);
                        port map(
                            clk_in=>clk_in,
                            clk_out=>clk_out,
                            clr=>clr,
                            delitelj=>delitelj
            
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
                            delitelj<=4;
                            wait for 10 ns;
                            clk_in<='0';
                            delitelj<=2;
                            wait for 10 ns;
                            clk_in<='0';
                            delitelj<=10;
                            wait for 10 ns;
                            wait;
            
                            end process stimuli;
                        end architecture testiraj;