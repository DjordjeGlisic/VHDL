--PROJEKOVATI MEMORIJU KOJA JE KAPACITETA 64*4 BAJTA(INTEGER) SA ASINHRONIM NACINOM RADA KONTROLISAN DOZVOLOM CITANJA I UPISA
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity memorija is
    port(
        load: in integer;
        clr,clk,re,we : in std_logic;
        address: in integer range 0 to 63;
        izlaz: out integer

    );
    end entity memorija;
    architecture citajPisi of memorija is
       
        type niz is array (natural range<>) of integer;
            
        begin
            process(clk,clr)
             variable memory:niz(63 downto 0);
              begin
             
           
            if clr='1' then
            for i in range(memory'lenght-1 to 0) loop
             memory(i):=0;
             end loop;
             
           
                elsif clk'event and clk='1' then
                    if we='1' then
                        memory(address):=load;
                        if re='1' then
                            izlaz<=memory(address);
                            end if;
                        end if;
                end if;
                end process;
            end architecture citajPisi;
entity memorijaTB is
    end entity memorijaTB;
    architecture testiraj of memorijaTB is
        signal load,izlaz:integer;
        signal address: integer range 0 to 63;
        signal clk,clr,re,we:std_logic;
        uut: entity work.memorija(citajPisi)
        port map(
            load=>load,
            address=>address,
            clk=>clk,
            clr=>clr,
            re=>re,
            we=>we

        );
        stimuli:process
        begin
            load<=5;
            clr<='1';
            clk<='1'
            clk not clk after 1 ns;
            clk not clk after 5nx;
            re<='0';
            we<='1';
            address<=30;
            re<='1';
            we<='0';
            address<=20;
            re<='1';
            we<='1';
            address<=10;
            wait;
            
            
            end process stimuli;
            end architecture testiraj;