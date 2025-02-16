-- PROJEKTOVATI NTOBITNI REGISTAR KOJI CUVA NTOBITNI PODATAK I SALJE GA NA IZLAZ SVAKI NJEGOV BIT ILI AKO ITI TROSTATICKI BAFER NE DOZVOLI TAJ BIT NECE SE NA IZLAZU SLATI VEC HIGH IMPEDANCE
--KORISTITI SINHRONE D FLIP FLOPOVE I TRI STATE BAFERE OBE SU JEDNOBITNE KOMPONENTE 
LIBRARY IEEE;
USE IEEE.std_logic_1164.all;

entity dff is
    port (
        d:in std_logic;
        q:out std_logic;
        clk:in std_logic;
    );
    end entity dff;
    architecture raddff of dff is
        begin 
        process(clk)
        begin
        if clk'event and clk='1' then
            q<=d;
            else
            q<='Z';
            end if;
            end process;
        end architecture raddff;
        entity sb is 
        port(
            a: in std_logic;
            y:out std_logic;
            out_enable:in std_logic;
        );
        end entity sb;
        architecture rad3sb of sb is
            begin
                y<=a when out_enable='1' else y<='Z';

                end architecture rad3sb;
        entity nBitDFF is 
        generic( n: integer :=8);
        port(
            d: in std_logic_vector( 0 to n);
            q: out std_logic_vector(0 to n);
            clk: in std_logic;
            a: in std_logic_vector( 0 to n);
            y: out std_logic( 0 to n);
            out_enable: in std_logic_vector(0 to n)
        );
            end entity nBitDFF;
            architecture rad of nBitDFF is
               
                begin
                    g : for i in 0 to n generate
                     signal spoj:bit_vector( n downto 0);
                    uut1: entity work.dff(raddff)
                    port map(
                        d=>d(i),
                        q=>spoj(i),
                        clk=>clk
                    );
                    uut2: entity work.sb(rad3sb)
                    port map(
                        a=>spoj(i),
                        y=>y(i),
                        out_enable=>out_enable(i)
                    );
                    end generate g;

                    end architecture rad;

