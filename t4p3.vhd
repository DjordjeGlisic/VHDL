-- PROJEKTOVATI KOLO KOJE IMITIRA RAD D FLIP FLOPA ODNOSNO ULAZNI INT PODATAK SALJE NA IZLAZ ALI SA ZAKASNJENJEM OD 3 KLOK CIKLUSA
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity kolo is
    port(
        din: in integer;
        dout: out integer;
        clk,clr: in std_logic
    );
    end entity kolo;
    architecture kasni of kolo is
        type niz is array (natural range<>) of integer;
        begin
        process(clk,clr)
        variable mem:niz(3 downto 0);
        begin
        if clr='1' then
            mem:=(others=>0);
            elsif clk'event and clk='1' then
            mem:=mem(1 to 3)&din;
    end if;
    dout<=mem(0);
            end process;
    end kasni ; 
  entity testiraj is
    end entity testiraj;
    architecture test of testiraj is
        signal din,dout: integer;
        signal clr,clk:std_logic;
        begin
            uut: entity work.kolo(kasni)
            port map(
                din=>din,
                dout=>dout,
                clk=>clk,
                clr=>clr

            );
            stimuli:process
            begin
                clr<='1';
                wait for 1 ns;
                clr<=not clr after 1 ns;
                din<=5;
                clk<='0';
                clk<= not clk after 5 ns;
                wait for 5 ns;
                din<=7;
                clk<='0';
                clk<= not clk after 5 ns;
                din<=8;
                clk<='0';
                clk<= not clk after 5 ns;
                wait;
                end process stimuli;
            end architecture test;