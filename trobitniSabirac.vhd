library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_artihm.all;
entity sabirac1b is
port(
    op1,op2,cin: in bit;
    sum,cout:out bit;
);
end entity sabirac1b;
architecture saberi1b of sabirac1b is
  
    begin
        with bit_vector(cin,op1,op2) select
            (cout,sum) <=  bit_vector("00") when "000",
                           bit_vector("01") when "001",
                           bit_vector("01") when "010",
                           bit_vector("10") when "011",
                           bit_vector("10") when "100",
                           bit_vector("01") when "101",  
                            bit_vector("10") when "110",
                            bit_vector("11") when "111";

      
                        
    end architecture saberi1b;
    entity sabirac3b is
        port(
            operand1, operand2 : in bit_vector(2 downto 0);
            cin3b,cout3b: in bit;
            sumiranje: out bit_vector(2 downto 0);

            );
        end entity sabirac3b;
        architecture trobitnoSabiranje of sabirac3b is
            signal c01,c12 : bit;
            begin
                sab1 : entity work.sabirac1b
                port map
                (
                   operand1(0)<=op1,
                    operand2(0)<=op2,
                    cin3b<=cin;
                    sumiranje(0)<=sum,
                    c01<=cout;

                );
                sab2 : entity work.sabirac1b
                port map
                (
                    operand1(1)<=op1,
                    operand2(1)<=op2,
                    cin3b<=c01;
                    sumiranje(1)<=sum,
                    c12<=cout;

                );
                sab3 : entity work.sabirac1b
                port map
                (
                    operand1(2)<=op1,
                    operand2(2)<=op2,
                    cin<=c12;
                    sumiranje(2)<=sum,
                    cout3b<=cout;

                );
            
            end architecture trobitnoSabiranje;
            entity testiranjeSabiraca is
                end entity testiranjeSabiraca;
                architecture test of testiranjeSabiraca is
                    signal prvi,drugi,suma : bit_vector(2 downto 0);
                    signal ulazni,izlazni:bit;
                    begin
                        uut : entity work.sabirac3b(trobitnoSabiranje)
                        port map (
                            operand1=>prvi,
                            operand2=>drugi,
                            cin3b=>ulazni,
                            cout3b=>izlazni;

                        );
                        inicijalizacija:process 
                        begin
                            prvi<="000";
                            drugi<="000";
                            cin3b<='0'
                            wait 1 ns;
                            prvi<="001";
                            drugi<="001";
                            cin3b<='1'
                            wait 1 ns;
                            prvi<="010";
                            drugi<="001";
                            cin3b<='0'
                            wait 1 ns;
                            prvi<="100";
                            drugi<="001";
                            cin3b<='1'
                            wait 1 ns;
                            prvi<="001";
                            drugi<="001";
                            cin3b<='1'
                            wait 1 ns;
                            prvi<="000";
                            drugi<="000";
                            cin3b<='1'
                            wait 1 ns;
                            end process inicijalizacija;

                        end architecture test;