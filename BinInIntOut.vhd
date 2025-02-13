LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
entity brojac is
    generic(
        n:integer:=8;
    );
    port(
        din: unsigned(n-1 downto 0);
        dout:out integer range 0 to  2**n-1;
        clk,ce,we:in std_logic

    );
    end entity brojac;
    architecture broji of brojac is
       begin
       process(clk)
        variable mem:integer range 0 to 2**n-1;
        begin
            if clk'event and clk='1' then
                if we='1' then
                    mem:=to_integer(din);
                    end if;
                    if ce='1' then
                        loop
                            exit when mem=0;
                            mem:=mem-1;
                            end loop;
                        end if;
                        dout<=mem;
                end if;

            
            end process;
            end architecture broji;