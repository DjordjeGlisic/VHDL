library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity mreza is
    generic(n:integer:=8);
    port(
        ulaz: in std_logic_vector(n downto 0);
        clr:in std_logic;
        izlaz: out integer range 0 to n


    );
    end entity mreza;
    architecture broji of mreza is
       
    begin
        process(clr)
         variable counter: integer range 0 to n;
        begin
        if clr='1' then
            counter:=0;
            else
            for i in n downto 0 loop
                if ulaz(i)='1' then
                    counter:=counter+1;
                else exit;
                end if;
                end loop;
            end if;
     end process;
    end broji; 
    entity testiraj is
        generic(n:integer:=4);
        end entity testiraj;
        architecture test of testiraj is
            signal ulaz:std_logic_vector(n downto 0);
            signal clr: std_logic;
            signal izlaz:integer range 0 to n;
            begin
                uut: entity work.mreza(broji)
                generic map(
                    n=>n
                )
                port map(
                    ulaz=>ulaz,
                    clr=>clr,
                    izlaz=>izlaz

                );
                stimuli:process
                begin
                    clr<='1';
                    clr<=not clr after 5 ns;
                    ulaz<="1101";
                    wait for 1 ns;
                    ulaz<="1110";
                    wait for 1 ns;
                    ulaz<="0111";
                    wait for 1 ns;
                    ulaz<="1111";
                    wait;

                    end process stimuli;
                end architecture test;
    