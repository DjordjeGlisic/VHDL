-- PROJEKTOVATI BCD BRPOJAC KOJI BROJI UNAZAD NA OSNOVU PODATAKTA KOJI RPIMA SA ULAZA DIN 
-- PODATAK SA DIN KORISTI DA POCEV OD NJEGA GENERISE SVE PODATKE DO NULE NA IZLAZ DOUT VODECI RACUNA DA LI SE RADI O POZITIVNOM ILI NEGATIVNOM BROJU
--ZA NEGATIVAN BROJ IMPLEMENTIRANTI BCD(4 BTINI) BROJAC
--a) u potpunom komplementu
--b) u nepotpunom komplementu
--v) napisti arhitekturu koja vrsi dekodiranje bcd broja u potunom  komplementu
--------------------------------------------------------------------------------------------------------
--koncepti prebacivanje od binarnog u int podatak radi alu operacija i koriscenje for petlje
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;
USE IEEE.STD_LOGIC_SIGNED.ALL;

entity pkBcd is
    generic(
        n:integer:=4;
    );
    port(
        din: in unsigned( n-1 downto 0);
        neg:in std_logic;
        dout:out unsigned( n-1 downto 0);
        clk,we,ce:in std_logic;
    );
    end entity pkBcd;
    architecture brojiPk of pkBcd is
        begin
            count:process
            variable mem : unsigned(n-1 downto 0);
            variable pom: unsigned(n-1 downto 0)
            begin
                wait until clk'event and clk='1';
                if clk'event and clk='1' then
                    if we='1' then
                        mem:=din;
                        if(to_integer(mem)>16) then
                            mem:=to_unsigned(9,n-1);
                        end if;
                        if neg='1' then
                            for i in 0 to n-1 loop
                                if mem(i)='1' then
                                    mem(i):=0;
                                    else
                                    mem(i):='1';
                                    end if;
                                end loop;
                                mem:=to_unsigned(to_integer(pom)+1,n-1);
                            end if;
                         elsif ce='1' then
                            pom:=mem
                            for i in  to_integer(mem) downto 0 loop
                                pom:=to_unsigned(to_integer(pom)-1,n-1);
                                dout<=mem;
                                wait for 1 ns;       
                                end loop;
                               
                    end if;
                end if;
                end process;
            end architecture brojiPk;
entity nkBcd is
    generic(n:integer:=8);
port(
    din:unsigned(n-1 downto 0);
    dout:unsigned(n-1 downto 0);
    clk,ce,we,neg:std_logic;

);
end entity nkBcd;
architecture kodirajUPk of nkBcd is
    begin
        rad:process
        variable pom:unsigned(n-1 downto 0);
        variable mem:integer range 0 to 2**n;
        begin
            wait until clk'event and clk='1';
            if clk'event and clk='1' then
                if we='1' then
                    pom:=din;
                    mem:=to_integer(pom);
                    if(mem>16) then
                        mem:=9;
                    end if;
                    if neg='1' then
                    for i in n-1 downto  0 loop
                        if(pom(i)='1') then
                            pom(i):='0';
                            else
                            pom(i):='1';
                            end if;
                        end loop;
               
                       


                    else
                    dout<=din;
                    wait for 2 ns;
                    end if;
                    elsif ce='1' then
                        mem=to_integer(pom);
                        wait for 2 ns;
                        dout<=to_unsigned(mem,n-1);
                        for i in mem downto 0 loop
                            mem:=mem-1;
                            dout<=to_unsigned(mem,n-1);
                            wait for 2ns;
                            end loop;
                        end if;
                    end if;
            end process rad;
        end architecture kodirajUPk;
        architecture dekodiraj of pkBcd is
            begin
                rad:process
                variable pom:unsigned(n-1 downto 0);
                variable mem:integer range 0 to 2**n;
                begin
                    wait until clk'event and clk='1';
                    if clk'event and clk='1' then
                        if we='1' then
                            pom:=din;
                            if neg='1' then
                            mem:=to_integer(pom)-1;
                            pom:=to_unsigned(mem,n-1);
                            for i in n-1 to 0 loop
                                if(pom(i)='1') then
                                    pom(i):='0';
                                    else
                                    pom(i):='1';
                                    end if;
                                end loop;
                                dout<=pom
                               
        
        
                            else
                            dout<=din;
                            wait for 2 ns;
                            end if;
                            elsif ce='1' then
                                wait for 2 ns;
                                dout<=to_unsigned(mem,n-1);
                                for i in mem to 0 loop
                                    mem:=mem-1;
                                    dout<=to_unsigned(mem,n-1);
                                    wait for 2ns;
                                    end loop;
                                end if;
                            end if;
                    end process rad;
                end architecture dekodiraj;