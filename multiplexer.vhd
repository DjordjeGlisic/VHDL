library ieee;
use ieee.std_logic_1164.all;
entity mux is
    port( 
        a,b,c,d :  in signed(7 downto 0);
        sel1,sel : in std_logic_vector(2 downto 0);
        f :out signed(7 downto 0)
    );
    end entity mux;
    architecture operacija of mux is
        begin
            process(sel1,sel2)
            begin
                with (sel1,sel2)
                select f <= a when ("000000"),
                            b when ("001001"),
                            c when ("100100") ,
                            d when (others=>'X')
                end process;
            end architecture operacija;
    entity multiplexer is
        port(
            a,b,c,d : in unsigned(7 downto 0);
            sel1,sel2 : in signed(1 downto 0);
            izlaz: out unsigned(7 downto 0)
        );
        end entity multiplexer;
        architecture ifnaredba of multiplexer is
            begin
                
                izlaz <= a when sel1>sel2 or to_integer(sel1) + to_integer(sel2) < 10,
                         b when sel1=sel2 or (sel1<0 and sel2<0),
                         c when sel2 >sel1 or to_integer(sel)+to_integer(sel2)<5,
                         else d;   
                end ifnaredba;

    entity testirajMP is
        end entity testirajMP;
        architecture test of testirajMP is
            signal u1,u2,u3,u4 : signed(7 downto 0);
            signal iz : signed(7 downto 0);
            signal sele1,sele2 : signed(1 downto 0);
            begin
                uut: entity work.multiplexer
                port map (
                    a=>u1,
                    b=>u2,
                    c=>u3,
                    d=>u4,
                    sel1=>sele1,
                    sel2=>sele2,
                    izlaz=>iz

                );
                inicijalizacija : process
                begin
                    u1<=unsigned("00000000");
                    u2<=unsigned("00000001");
                    u3<=unsigned("10101011");
                    u4<=unsigned("11111111");
                    sele1<=signed("00");
                    sele2<=signed("11");
                    wait for 1 ns;
                    sele1<=signed("01");
                    sele2<=signed("00");
                    wait for 1 ns;
                    sele1<=signed("11");
                    sele2<=signed("11");
                    wait; 
                    end process inicijalizacija;

                end architecture test;
