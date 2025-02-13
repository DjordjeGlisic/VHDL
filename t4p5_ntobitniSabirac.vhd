library IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.NUMERIC_STD.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
entity sabirac is
    generic(n:integer:=4);
    port(
        a: in std_logic_vector(n downto 0);
        b: in std_logic_vector(n downto 0);
        cin: in std_logic;
        cout: out std_logic;
        s: out std_logic_vector(n downto 0)


    );
    end entity sabirac;
    architecture saberi of sabirac is
        signal c_int: std_logic_vector(n downto 0);
        begin
            
            g1: for i in 0 to n-1 generate
            begin
                c_int(0)<=cin;
                s(i)<=(a(i) xor (b(i))) xor c_int(i);
                c_int(i+1)<=(a(i) and b(i)) or (a(i) and c_int(i)) or (b(i) and c_int(i));
                end generate;
            cout<=c_int(n);
            end architecture saberi;
        
            LIBRARY IEEE;
            USE IEEE.STD_LOGIC_1164.ALL;
            USE IEEE.STD_LOGIC_ARITH.ALL;
            USE IEEE.NUMERIC_STD.ALL;
            entity testiraj is
                generic(n: integer:=3);
                end entity testiraj;
                architecture test of testiraj is
                    signal a,b,s:std_logic_vector(n downto 0);
                    signal cin,cout:std_logic;
                    begin
                        uut: entity work.sabirac(saberi)
                        generic map(
                            n=>n
                        )
                        port map(
                            a=>a,
                            b=>b,
                            s=>s,
                            cin=>cin,
                            cout=>cout
            
                        );
                        stimuli: process 
                        begin
                            a<="010";
                            b<="001";
                            cin<='0';
                            wait for 2 ns;
                            a<="110";
                            b<="101";
                            cin<='1';
                            wait for 2 ns;
                            a<="000";
                            b<="001";
                            cin<='0';
                            wait for 2 ns;
                            wait;
                            end process stimuli;
                        end test;