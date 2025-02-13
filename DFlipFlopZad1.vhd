library IEEE;
use IEEE.std_logic_1164.all;

entity DFF is
    port(
    D: in bit;
    Q: out bit;
    clk,clr: in bit
    );
    end entity DFF;
    architecture asinhroniReset of DFF is
        begin 
         process(clr,clk)
            begin 
            if clr='1' then
                Q<='0';
                else
                if clk'event and clk='1' then
                    Q<=D;
                    end if;
                end if;
                end process;
        end architecture asinhroniReset;
        entity DFFtest is
            end entity DFFtest;
            architecture test of DFFtest is
                signal d,q,sat,reset:bit;
                begin
                    uut : entity work.DFF(asinhroniReset) 
                    port map
                    (
                        D=>d,
                        Q=>q,
                        clk=>sat,
                        clr=>reset

                    );
                    inicijalizacija: process
                    begin
                        d<='1';
                        clr<='1';
                        clk<='0';
                        wait for 2 ns;
                        clk<'1';
                        wait for 2 ns;
                        clk<='0';
                        wait for 5 ns;
                        d<='1';
                        clr<='0';
                        clk<='0';
                        wait for 2 ns;
                        clk<='1';
                        wait for 4 ns;
                        clk<='0';
                        wait for 5 ns;
                        clk<='1';
                        wait;
                        
                        end process inicijalizacija;
                    end architecture test;