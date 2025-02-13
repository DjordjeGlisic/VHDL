-- Code your design here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity bcd is
    port(
        clk,clr: in std_logic;
        izlaz:out std_logic_vector(3 downto 0)


    );
    end entity bcd;
    architecture broji of bcd is
        begin
        process(clk,clr)
            variable memorija : std_logic_vector(3 downto 0);
            variable fleg : std_logic;
            begin
                if clr='1' then
                    memorija:="0000";
                    fleg:='0';
                    else
                    if clk'event and clk='1' then
                        fleg:= not fleg;
                        if fleg='1' then
                            case memorija is
                                when "0000" => memorija:="0001";
                                when "0001" => memorija:="0010";
                                when "0010" => memorija:="0011";
                                when "0011" => memorija:="0100";
                                when "0100" => memorija:="0101";
                                when "0101" => memorija:="0110";
                                when "0110" => memorija:="0111";
                                when "0111" => memorija:="1000";
                                when "1000" => memorija:="1001";
                                when others => memorija:="0000";
                                end case;
                            end if;
                    end if;
                            
                        
                        
                        
                        
                end if;
                izlaz<=memorija;
            end process;
            end architecture broji;
            -- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;
use IEEE.std_logic_arith.all;
use IEEE.std_logic_unsigned.all;

entity brojacTest is
    end entity brojacTest;
    architecture testiranje of brojacTest is
        
            signal izlaz : std_logic_vector(3 downto 0);
            signal clr,clk :std_logic;
            begin
            uut: entity work.bcd(broji)
            port map(
                izlaz =>izlaz,
                clk =>clk,
                clr=>clr

            );
            stimuli:process
            begin
                clr<='1';
                clk<='0';
                wait for 10 ns;
                clr<='0';
                clk<= not clk after 1 ns;
                wait until clk='1';
                wait;
                end process stimuli;
            end architecture testiranje;