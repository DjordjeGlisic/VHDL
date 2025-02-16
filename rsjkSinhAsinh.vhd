--projektovati r s i j k  flip flopove sa sinhronim i asinhronim rezimom rada
library ieee;
use ieee.std_logic_1164.all;
entity rsff is
    port(
        r,s: in std_logic;
        q,qn:out std_logic;
        clk: in bit;
        clr:in bit 

    );
    end entity rsff;
    architecture asyncrsff of rsff is
        begin
            process(clr,clk)
            variable izlaz:std_logic;
            begin
                if clr='1' then
                    izlaz:='0';
                    
                elsif clk'event and clk='1' then
                    if r='0' and s='0' then
                        izlaz:=izlaz;
                        elsif r='1' and s='0' then
                            izlaz:='0';
                            
                            elsif r='0' and s='1' then
                                izlaz:='1';
                                
                                elsif r='1' and s='1' then
                                    izlaz:='x';
                                    qn<='x';
                                    end if;
                    end if;

                    q<=izlaz;
                    if(izlaz!='x') then
                        qn<= not izlaz;
                        end if;
                end process;
            end architecture asyncrsff;
    architecture syncrsff of rsff is
        begin 
        variable izlaz:std_logic;
        process(clk,clr)
        begin
            if clk'event and clk='1' then
                if clr='1' then
                    izlaz:='0';
                    
                    else
                if r='0' and s='0' then
                   izlaz:=izlaz;
                   
                    elsif r='1' and s='0' then
                        izlaz:='0';
                        
                        elsif r='0' and s='1' then
                            izlaz:='1';
                            qn<='0';
                            else
                            izlaz:='X';
                            qn<='X';
                            end if;
                            end if;
               end if;
               q<=izlaz;
               if(izlaz!='X') then
                qn<=not izlaz;
                end if;
            end process;
        end architecture syncrsff;
        -- Code your testbench here
library IEEE;
use IEEE.std_logic_1164.all;
entity testRsff is
end entity testRsff;
architecture test of testRsff is
signal reset,set,izlaz,takt,cisti : std_logic;
begin
uut: entity work.rsff(asyncrsff)
port map(
r=>reset,
s=>set,
q=>izlaz,
clk=>takt,
clr=>cisti
);
inicijalizacija : process
begin
reset<='0';
set<='0';
takt<='0';
cisti<='1';
wait for 2 ns;
cisti<='0';
wait for 2 ns;
reset<='1';
set<='0';
takt<='1';
wait for 1 ns;
takt<='0';
wait for 1 ns;
takt<='1';
reset<='0';
set<='1';
wait for 1 ns;
takt<='0';
wait for 1 ns;
takt<='1';
reset<='1';
set<='1';

end process inicijalizacija;

end architecture test;
        
entity jkff is
    port(
        j,k: in std_logic;
        q : out std_logic;
        clk: in bit;
        clr:in bit 

    );
    end entity jkff;
    architecture asyncjkff of jkff is
        variable q_t:std_logic;
        begin
        
            process(clr,clk)
            begin
                if clr='1' then
                    q_t<='0';
                elsif clk'event and clk='1' then
                    if j='0' and k='0' then
                        q_t<=q_t;
                        elsif j='1' and k='0' then
                            q_t<='1';
                            
                            elsif j='0' and k='1' then
                                q_t<='0';
                                
                                elsif j='1' and k='1' then
                                    q_t<=not q_t;
                                    
                                    end if;
                    end if;
                end process;
                q<=q_t
            end architecture asyncjkff;
    architecture syncjkff of jkff is
        variable q_t:std_logic;
        begin 
        process(clk)
       
        begin
            if clk'event and clk='1' then
                if clr='1' then
                    q_t<='0';
                 
                    else
                if j='0' and k='0' then
                    q_t<=q_t;
                   
                    elsif j='1' and k='0' then
                        q_t<='1';
                        
                        elsif j='0' and k='1' then
                            q_t<='0';
                            
                            else
                            q_t<= not q_t;
                            
                            end if;
                            end if;
               end if;
               q<=q_t;
            end process;
        end architecture syncjkff;
        
        library IEEE;
        use IEEE.std_logic_1164.all;
        entity testJkff is
        end entity testJkff;
        architecture test of testJkff is
        signal reset,set,izlaz,takt,cisti : std_logic;
        begin
        uut: entity work.rsff(asyncrsff)
        port map(
        j=>reset,
        k=>set,
        q=>izlaz,
        clk=>takt,
        clr=>cisti
        );
        inicijalizacija : process
        begin
        reset<='0';
        set<='0';
        takt<='0';
        cisti<='1';
        wait for 2 ns;
        cisti<='0';
        wait for 2 ns;
        reset<='1';
        set<='0';
        takt<='1';
        wait for 1 ns;
        takt<='0';
        wait for 1 ns;
        takt<='1';
        reset<='0';
        set<='1';
        wait for 1 ns;
        takt<='0';
        wait for 1 ns;
        takt<='1';
        reset<='1';
        set<='1';