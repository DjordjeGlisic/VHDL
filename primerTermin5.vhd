--PROJEKTOVATI KOMPONENTU KOJA SABIRA DVA SUKCESIVNA PODATKA IZ REGISTRA
library ieee;
use ieee.std_logic_1164_all;
use ieee.numeric_std;

entity adder is
    port(
        in1,in2 in std_logic;
        cin:in std_logic;
        izlaz:out std_logic;
        cout:out std_logic
    );
    end entity adder;
    architecture add of adder is
        process(in1,in2)
        begin
            with bit_vector(cin,in1,in2) select (cout,izlaz)<=
                bit_vector("00") when "000"
                bit_vector("01") when "010"
                bit_vector("01") when "001"
                bit_vector("01") when "100"
                bit_vector("10") when "011"
                bit_vector("10") when "110"
                bit_vector("11") when others;
        end process;

        end architecture add;

entity sabirac7b is
    generic(n:integer:=7);
    port(
        in1,in2 in std_logic_vector(n downto 0);
        cin:in std_logic;
        izlaz:out std_logic_vector(n downto 0);
        cout:out std_logic
    );
    end entity sabirac7b;
    architecture saberi of sabirac7b is
        signal registar:std_logic_vector(n-1 downto 0);
        begin
            G1: for i in 0 to n generate
            grananje:if i=0 generate
            sab1: entity work.adder(add)
            generic map(n=>n)
            port map(
                in1=>in1(0),
                in2=>in2(0),
                cin=>cin,
                cout=>registar(0),
                izlaz=>izlaz(0)

            );
            elsif i=n generate
            sabn: entity work.adder(add)
            generic map(n=>n)
            port map(
                in1=>in1(n),
                in2=>in2(n),
                cin=>registar(n-1),
                cout=>cout,
                izlaz=>izlaz(n)

            );
            else generate
            sabi: entity work.adder(add)
            generic map(n=>n)
            port map(
                in1=>in1(i),
                in2=>in2(i),
                cin=>registar(i-1),
                cout=>registar(i),
                izlaz=>izlaz(i)

            );
            end generate grananje;
            end generate;
       
        end architecture saberi;
entity buff is
    generic(n:integer:=7);
    port(
        ulaz:in std_logic_vector(n downto 0);
        izlaz:out std_logic_vector(n downto 0);
        clk:in bit;
    );
    end entity buff;
    architecture baferuj of buff is
        process(clk)
        begin
            if clk'event and clk='1' then
                izlaz<=ulaz;
                end if;
            end process;
        end architecture baferuj;
entity memorija is
        generic(n:integer:=7);
        generic(m:integer:=31);
        generic(k:integer:=4)
        port(
            din:in std_logic_vector(n downto 0);
            dout:out std_logic_vector(n downto 0);
            addr:in std_logic_vector(k downto 0);
            we:in bit;
            clk:in bit;
        );
        end entity memorija;
        architecture pamti of memorija is
            type polje is array (m downto 0) of std_logic_vector(n downto 0);
            signal mem:polje
            variable index:integer range 0 to m;
            begin
                process(clk,we)
                begin
                    if clk'event and clk='1' then
                        index:=conv_integer(addr);
                        if we='0' then
                            mem(index)<=din;
                            else
                            dout<=mem(index);
                            end if;
                        end if;
                end process;

                end architecture pamti;

entity brojac is
    generic(m:integer:=31);
    generic(n:integer:=4);
    port(
        clk,reset:in bit;
        ulaz:in integer 0 to m;
        izlaz:out std_logic_vector(n downto 0);
    );
    end entity brojac;
    architecture broji of brojac is
        begin
            process(clk,reset)
            variable pom:integer 0 to m;
            begin
                if reset='1' then
                    pom:=ulaz;
                    else
                    if clk'event and clk='1' then
                        if pom=m then
                            pom:=0;
                            else
                            pom:=pom+1;
                            end if; 
                        end if;
                    end if;
                    izlaz<=conv_std_logic_vector(pom);
                end process;
            end architecture broji;

entity kontrolna is
    generic(n:integer:=7);
    generic(m:integer:=31);
    port(
        we:in bit;
       
        clk:in bit;
        reset:in bit;
        --zasto postoji adresa verovatno zasto da se ne krece uvek od nula brojanje tj odredjivanje adrese od koje krece komunikacija vec da moze rucno da se postavi
        addr:in integer 0 to m;
        upis1:out std_logic;
        upis2:out std_logic;

    );
    end entity kontrolna;
    architecture kontrolisi of kontrola is
        type stanja is(sStart,sRead1,sRead2,sWrite);
        signal current_state:stannja;
        signal next_state:stanja;
        signal u1:std_logic;
        signal u2:std_logic
        begin
        process(clk,reset)
        begin
        if reset='1'then
            current_state<=sStart;
           
            else
            if clk'event and clk='1' then
                current_state<=next_state;
                upis1<=u1;
                upis2<=u2;
                end if;

            end if; 
        end process;
        process(we,addr,current_state)
        begin
            if current_state=sStart then
                addr<=0;
                u1<='0';
                u2<='0';
                reset<='1';
                if we='1' then
                    next_state<=sWrite;
                    elsif we='0' then
                        next_state<=sRead1;
                    end if;
            elsif current_state=sWrite then
                reset<='0';
                if we='0' then
                   next_state<=sStart;
                    end if;
            elsif current_state=sRead1 then 
                reset<='0';
                u1<='1';
                u2<='0';
                if we='1' then
                    next_state<=sStart;
                    elsif we='0' then
                      next_state<=sRead2; 
                    end if;
                elsif current_state=sRead2 then 
                u1<='0';
                u2<='1';
                if we='1' then
                    next_state<=sStart;

                    elsif we='0' then
                      next_state<=sRead1; 
                    end if;
            
            end if;

            end process;
        end architecture kontrolisi;
entity komponenta is
    generic(n:integer:=7);
    generic(m:integer:=31);
    generic (k:integer:=4);
    port(
        din:in std_logic_vector(n downto 0);
        we:in bit;
        clk:in bit;
        res:in bit;
        dout:out std_logic_vector(n+1 downto 0);
        
        );
        end entity komponenta;
        architecture komp of komponenta is
            -- kako se ovaj interni signal generise ako nije port 
        signal addr:in integer range 0 to m;
        signal upis1,upis2:std_logic;
        signal adresaMem:std_logic_vector(n downto 0);
        signal podatak:std_logic_vector(n downto 0);
        signal op1,op2:std_logic_vector(n downto 0);
        begin
            cu: entity work.kontolna(kontrolisi)
            generic map(n=>7)
            port map(
                we=>we,
                res=>reset,
                addr=>addr,
                upis1=>upis1,
                upis2=>upis2,
                clk=>clk
            );
            counter: entity work.brojac(broji)
            generic map(n=>n,m=>m)
            port map(
                reset=>res,
                clk=>clk,
                ulaz=>addr,
                izlaz=>adresaMem
            );
            mem:entity work.memorija(pamti)
            generic map(
                n=>n,
                m=>m
            )
            port map(
                din=>din,
                dout=>podatak,
                addr=>adresaMem,
                clk=>clk,
                we=>we

            );
            buf1: entity work.buff(baferuj)
            generic map(n=>n)
            port map(
                clk=>upis1
                ulaz=>podatak,
                izlaz=>op1
            );
            buf2: entity work.buff(baferuj)
            generic map(n=>n)
            port map(
                clk=>upis2
                ulaz=>podatak,
                izlaz=>op2
            );
            sabirac: entity work.sabirac7b(saberi)
            port map(
                in1=>op1,
                in2=>op2,
                cin=>0,
                izlaz=>dout(n downto 0),
                cout=>dout(n+1)
            )


        end architecture komp;
    