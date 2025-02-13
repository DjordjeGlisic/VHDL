library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.std_logic_unsigned.all;
entity DFF is
    port(
        d:in std_logic;
        q:out std_logic;
        clk,clr:in std_logic;
    );
    end entity DFF;
    architecture rad of DFF is
        begin
            if clk'event and clk='1' then
                if clr='1' then
                    q<='0';
                    else
                    q<=d;
                    end if;
                end if;
            end architecture rad;
entity registar is
    generic(
        n:integer:=8;
    );
    port(
        si:in std_logic;
        clr,clk:in std_logic;
        q:out std_logic_vector(n-1 downto 0);
    );
    end entity registar;
    architecture radi of registar is
        variable mem:std_logic_vector(n-1 downto 0);
        begin
            g:for i in range 0 to n-1 generate
            begin
            prviUslov:if i=0 generate
             begin
            uut1: entity work.DFF(rad)
            port map(
                d=>si,
                clk=>clk,
                clr=>clr,
                q=>q(i),
                mem(i):=q
            );
            elsif i=n-1 generate
            uut2: entity work.DFF(rad)
            port map(
                d=>mem(i-1),
                clk=>clk,
                clr=>clr,
                q=>q(i),
            );
            else generate
            uut3: entity work.DFF(rad)
            port map(
                d=>mem(i-1),
                q=>q(i),
                q=>mem(i+1),
                clk=>clk,
                clr=>clr
            );


            end generate prviUslov;
            end generate g;

            end architecture radi;

