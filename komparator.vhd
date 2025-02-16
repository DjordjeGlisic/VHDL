--PROJEKTOVATI KOMPRATATOR 8BTINIH PODATAKA KOJI FUNCKIONISE TAKO STO AKTIVIRA JEDAN OD 3 IZLAZA ZAVISNO OD ODNOSTA NJEGOVIH ULAZA
--KOMPRATATOR SE OKIDA KADA SE NEKI NJEGOV ULAZ PROMENI
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL; -- Uvezi numeric_std za rad sa unsigned i signed
entity komparator is
    port(
        ulaz1,ulaz2 : in std_logic_vector(7 downto 0);
        i1,i2,i3: out std_logic_vector(7 downto 0)

    );
    end entity komparator;
    architecture uporedi of komparator is
        begin
            i1 <= (others=>'1') when signed(ulaz1)>signed(ulaz2) else (others=>'0');
            i2<= (others=>'1') when signed(ulaz1)=signed(ulaz2) else (others=>'0');
            i3<= (others=>'1') when signed(ulaz1)<signed(ulaz2) else (others=>'0');
            end architecture uporedi;
            library IEEE;
            use IEEE.STD_LOGIC_1164.ALL;
            use IEEE.NUMERIC_STD.ALL; -- Uvezi numeric_std za rad sa unsigned i signed
            entity testirajKomparator is
            end entity testirajKomparator;
            
            architecture test of testirajKomparator is
                signal u1, u2 : std_logic_vector(7 downto 0);
                signal out1, out2, out3 : std_logic_vector(7 downto 0);
            begin
                uut : entity work.komparator
                port map (
                    ulaz1 => u1,
                    ulaz2 => u2,
                    i1 => out1,
                    i2 => out2,
                    i3 => out3
                );
            
                inicijalizacija : process
                begin
                    u1 <= "00000000"; -- ispravna sintaksa za dodelu
                    u2 <= "11111111"; -- ispravna sintaksa za dodelu
                    wait for 1 ns;
                    
                    u1 <= "10100101"; -- ispravna sintaksa za dodelu
                    u2 <= "00001111"; -- ispravna sintaksa za dodelu
                    wait for 1 ns;
                    
                    u1 <= "11110000"; -- ispravna sintaksa za dodelu
                    u2 <= "10101010"; -- ispravna sintaksa za dodelu
                    wait for 1 ns;
                    
                    wait; -- zadržava simulaciju
                end process inicijalizacija;
            
            end architecture test;