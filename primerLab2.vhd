-- PROJEKTOVATI BCD BROJAC PO MODULU 8 SA SINHRONIM RADOM POSREDSTVOM DOZVOLA BROJANJA I UPISA
--KLJUCNI KONCEPTI BBOX,WBOX,SEKV KOLO,PROCESI,SWITCH-CASE STRUKTURA,INSRTANCIRANJE,TESTVENCH
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
entity bcd is
    generic(
        n:integer:=3;
    );
    port(
        din:in std_logic_vector(n-1 downto 0);
        ce:in std_logic;
        we:in std_logic;
        clk:in std_logic;
        dout:out std_logic_vector(n-1 downto 0);
    );
    end entity bcd;
    architecture broji of bcd is
        begin
            process(clk)
            variable mem: std_logic_vector(n-1 downto 0);
            begin
                if clk'event and clk='1' then
                    if we='1' then
                        mem:=din;
                        
                    elsif ce='1' then
                        loop
                            exit when mem="000";
                            case mem is
                                when "111"=>mem:="110";
                                when "110"=>mem:="101";
                                when "101"=> mem:="100";
                                when "100" => mem:="011";
                                when "011" => mem:="010";
                                when "010"=>mem:="001";
                                when "001"=> mem:="000";
                                when others => mem:="000";
                                end case;
                                end loop;
                                    end if;
                                    end if;
                                    dout<=mem;
                end process;

            end architecture broji;
-- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity bcdTest is
    generic(n:integer:=3);
    end entity bcdTest;
    architecture testiraj of bcdTest is
        signal clk,ce,we: std_logic;
        signal din,dout:std_logic_vector(n-1 downto 0);

        begin
            uut: entity work.bcd(broji)
            port map(
                clk=>clk,
                ce=>ce,
                we=>we,
                din=>din,
                dout=>dout
            );
            process(clk)
            begin
                clk<= not clk after 2 ns;
                end process;
            stimuli: process
                begin
                    clk<='0';
                    ce<='0';
                    we<='1';
                    din<="110";
                    ce<='1';
                    we<='0';
                    wait for 5 ns;
                    ce<='0';
                    we<='1';
                    din<="111";
                    ce<='1';
                    we<='0';
                    wait for 5 ns;
                    ce<='0';
                    we<='1';
                    din<="111";
                    ce<='1';
                    we<='0';
                    wait;
                    end process stimuli; 
            end architecture testiraj;