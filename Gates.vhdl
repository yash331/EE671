library ieee;
use ieee.std_logic_1164.all;

package Gates is
  
component andgate is
    port (A, B: in std_ulogic;
          prod: out std_ulogic);
end component andgate;

component orgate is
    port (A, B: in std_ulogic;
          summ: out std_ulogic);
end component orgate;

component xorgate is
    port (A, B: in std_ulogic;
          uneq: out std_ulogic);
end component xorgate;

component abcgate is
    port (A, B, C: in std_ulogic;
          abc: out std_ulogic);
end component abcgate;

component Cin_map_G is
    port(A, B, Cin: in std_ulogic;
         Bit0_G: out std_ulogic);
end component Cin_map_G;

component HALF_ADDER is
   port (A, B: in std_logic; S, C: out std_logic);
  end component HALF_ADDER;

component Full_Adder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end component Full_Adder;

component Full_Adder16  is
  port (in_A, in_B: in std_logic_vector(15 downto 0); Cin: in std_logic;
			Sum: out std_logic_vector(15 downto 0); Cout: out std_logic);
end component Full_Adder16;

end package Gates;

-- simple gates with trivial architectures

library IEEE;
use IEEE.std_logic_1164.all;
entity andgate is
    port (A, B: in std_ulogic;
          prod: out std_ulogic);
end entity andgate;
architecture trivial of andgate is
begin
    prod <= A AND B AFTER 126 ps; --40+86
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;
entity orgate is
    port (A, B: in std_ulogic;
          summ: out std_ulogic);
end entity orgate;
architecture trivial of orgate is
begin
    summ <= A or B AFTER 126 ps; --40+86
end architecture trivial;


library IEEE;
use IEEE.std_logic_1164.all;
entity xorgate is
    port (A, B: in std_ulogic;
          uneq: out std_ulogic);
end entity xorgate;
architecture trivial of xorgate is
begin
    uneq <= A XOR B AFTER 232 ps; --60+2*86
end architecture trivial;

library IEEE;
use IEEE.std_logic_1164.all;
entity abcgate is
    port (A, B, C: in std_ulogic;
          abc: out std_ulogic);
end entity abcgate;

architecture trivial of abcgate is
begin -- A + C.(A+B) with a trivial architecture
    abc <= A OR (B AND C) AFTER 222 ps; --50+2*86
end architecture trivial;
    
library IEEE;
use IEEE.std_logic_1164.all;
entity Cin_map_G is
    port(A, B, Cin: in std_ulogic;
         Bit0_G: out std_ulogic);
end entity Cin_map_G;
architecture trivial of Cin_map_G is
begin
    Bit0_G <= (A AND B) OR (Cin AND (A OR B)) AFTER 232 ps;  --60+2*86
end architecture trivial;


library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity HALF_ADDER is
   port (A, B: in std_ulogic; S, C: out std_ulogic);
end entity HALF_ADDER;

architecture Equations of HALF_ADDER is
begin

	sum1: xorgate port map (A=>A, B=>B, uneq=>S);
	crr1: andgate port map (A=>A, B=>B, prod=>C);
   
end architecture Equations;


library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;
entity Full_Adder  is
  port (A, B, Cin: in std_logic; S, Cout: out std_logic);
end entity Full_Adder;
architecture Struct of Full_Adder is
  signal tC, tS, U, V: std_logic;
begin
  -- component instances
  
  ha: HALF_ADDER 
       port map (A => A, B => B, S => tS, C => tC);

  -- propagate carry.
  a1: andgate port map (A => tS, B => Cin, prod => V);
  o1: orgate  port map (A => V, B => tC, summ => Cout);

  -- final sum.
  x1: xorgate port map (A => tS, B => Cin, uneq => S);
end Struct;



library IEEE;
use IEEE.std_logic_1164.all;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity Full_Adder16  is
  port (in_A, in_B: in std_logic_vector(15 downto 0); Cin: in std_logic;
			Sum: out std_logic_vector(15 downto 0); Cout: out std_logic);
end entity Full_Adder16;

architecture Struct of Full_Adder16 is --I used terminology given in old slides so G0 is G1 for me
  signal G1: std_logic_vector(15 downto 1);--as G(0) is C(1) so no need of 0 index 
  signal P1: std_logic_vector(15 downto 0);
  signal G2, P2: std_logic_vector(7 downto 0);
  signal G3, P3: std_logic_vector(3 downto 0);
  signal G4, P4: std_logic_vector(1 downto 0);
  signal G5, P5: std_logic_vector(0 downto 0);
  signal C: std_logic_vector(15 downto 1);--that's how we defined it C0 is input carry and c16 is Cout
  
  
  begin
  --stage 1
  -- gij, pij => i is level and j is corresponding bit
  --G1 computing	and G1(0) is c1
  g10: Cin_map_G port map (A => in_A(0), B => in_B(0), Cin=>Cin, Bit0_G => C(1)); --right most block
  g11: andgate port map (A => in_A(1), B => in_B(1), prod => G1(1));
  g12: andgate port map (A => in_A(2), B => in_B(2), prod => G1(2));
  g13: andgate port map (A => in_A(3), B => in_B(3), prod => G1(3));
  g14: andgate port map (A => in_A(4), B => in_B(4), prod => G1(4));
  g15: andgate port map (A => in_A(5), B => in_B(5), prod => G1(5));
  g16: andgate port map (A => in_A(6), B => in_B(6), prod => G1(6));
  g17: andgate port map (A => in_A(7), B => in_B(7), prod => G1(7));
  g18: andgate port map (A => in_A(8), B => in_B(8), prod => G1(8));
  g19: andgate port map (A => in_A(9), B => in_B(9), prod => G1(9));
  g110:andgate port map (A => in_A(10), B => in_B(10), prod => G1(10));
  g111:andgate port map (A => in_A(11), B => in_B(11), prod => G1(11));
  g112:andgate port map (A => in_A(12), B => in_B(12), prod => G1(12));
  g113:andgate port map (A => in_A(13), B => in_B(13), prod => G1(13));
  g114:andgate port map (A => in_A(14), B => in_B(14), prod => G1(14));
  g115:andgate port map (A => in_A(15), B => in_B(15), prod => G1(15));

  --P1 computing
  p10: xorgate port map (A => in_A(0), B => in_B(0), uneq => P1(0));
  p11: xorgate port map (A => in_A(1), B => in_B(1), uneq => P1(1));
  p12: xorgate port map (A => in_A(2), B => in_B(2), uneq => P1(2));
  p13: xorgate port map (A => in_A(3), B => in_B(3), uneq => P1(3));
  p14: xorgate port map (A => in_A(4), B => in_B(4), uneq => P1(4));
  p15: xorgate port map (A => in_A(5), B => in_B(5), uneq => P1(5));
  p16: xorgate port map (A => in_A(6), B => in_B(6), uneq => P1(6));
  p17: xorgate port map (A => in_A(7), B => in_B(7), uneq => P1(7));
  p18: xorgate port map (A => in_A(8), B => in_B(8), uneq => P1(8));
  p19: xorgate port map (A => in_A(9), B => in_B(9), uneq => P1(9));
  p110:xorgate port map (A => in_A(10), B => in_B(10), uneq => P1(10));
  p111:xorgate port map (A => in_A(11), B => in_B(11), uneq => P1(11));
  p112:xorgate port map (A => in_A(12), B => in_B(12), uneq => P1(12));
  p113:xorgate port map (A => in_A(13), B => in_B(13), uneq => P1(13));
  p114:xorgate port map (A => in_A(14), B => in_B(14), uneq => P1(14));
  p115:xorgate port map (A => in_A(15), B => in_B(15), uneq => P1(15));
  
  --Stage 2
  --G2 computing
  --g2i => G_2,(2i+1,2i) = G_1,(2i+1) + P_1,(2i+1)*G_1,2i where i=0,1,..7
  g20: abcgate port map (A=>G1(1), B=>C(1), C=>P1(1), abc=>G2(0));
  g21: abcgate port map (A=>G1(3), B=>G1(2), C=>P1(3), abc=>G2(1));
  g22: abcgate port map (A=>G1(5), B=>G1(4), C=>P1(5), abc=>G2(2));
  g23: abcgate port map (A=>G1(7), B=>G1(6), C=>P1(7), abc=>G2(3));
  g24: abcgate port map (A=>G1(9), B=>G1(8), C=>P1(9), abc=>G2(4));
  g25: abcgate port map (A=>G1(11), B=>G1(10), C=>P1(11), abc=>G2(5));
  g26: abcgate port map (A=>G1(13), B=>G1(12), C=>P1(13), abc=>G2(6));
  g27: abcgate port map (A=>G1(15), B=>G1(14), C=>P1(15), abc=>G2(7));
  
  --p2i => P_2,(2i+1,2i) = P_1,(2i+1)*P_1,2i  where i=0,1,..7
  p20: andgate port map (A=>P1(1), B=>P1(0), prod=>P2(0));
  p21: andgate port map (A=>P1(3), B=>P1(2), prod=>P2(1));
  p22: andgate port map (A=>P1(5), B=>P1(4), prod=>P2(2));
  p23: andgate port map (A=>P1(7), B=>P1(6), prod=>P2(3));
  p24: andgate port map (A=>P1(9), B=>P1(8), prod=>P2(4));
  p25: andgate port map (A=>P1(11), B=>P1(10), prod=>P2(5));
  p26: andgate port map (A=>P1(13), B=>P1(12), prod=>P2(6));
  p27: andgate port map (A=>P1(15), B=>P1(14), prod=>P2(7));
  
  --Stage 3
  --g3k => G_3,(4i+3, 4i) = G_2,(4i+3,4i+2) + G_2,(4i+1,4i)*P_2,(4i+3,4i+2)  where i=0,1,..3
  g30: abcgate port map (A=>G2(1), B=>G2(0), C=>P2(1), abc=>G3(0));
  g31: abcgate port map (A=>G2(3), B=>G2(2), C=>P2(3), abc=>G3(1));
  g32: abcgate port map (A=>G2(5), B=>G2(4), C=>P2(5), abc=>G3(2));
  g33: abcgate port map (A=>G2(7), B=>G2(6), C=>P2(7), abc=>G3(3));	 
  
  --p3k => P_3,(4i+3, 4i) = P_2,(4i+3,4i+2)*P_2,(4i+1,4i)  where i=0,1,..3
  p30: andgate port map (A=>P2(1), B=>P2(0), prod=>P3(0));
  p31: andgate port map (A=>P2(3), B=>P2(2), prod=>P3(1));
  p32: andgate port map (A=>P2(5), B=>P2(4), prod=>P3(2));
  p33: andgate port map (A=>P2(7), B=>P2(6), prod=>P3(3));
  
  --Stage 4
  --g4k => G_4,(8i+7, 8i) = G_3,(8i+7, 8i+4) + G_3,(8i+3,8i)*P_3,(8i+7,8i+4)   where i=0,1
  g40: abcgate port map (A=>G3(1), B=>G3(0), C=>P3(1), abc=>G4(0));
  g41: abcgate port map (A=>G3(3), B=>G3(2), C=>P3(3), abc=>G4(1));
  
  --p4k => P_4,(8i+7, 8i) = P_3,(8i+7,8i+4)*P_3,(8i+3,8i) wherei=0,1
  p40: andgate port map (A=>P3(1), B=>P3(0), prod=>P4(0));
  p41: andgate port map (A=>P3(3), B=>P3(2), prod=>P4(1));
  
  --Stage 5
  g50: abcgate port map (A=>G4(1), B=>G4(0), C=>P4(1), abc=>G5(0));
  p50: andgate port map (A=>P4(1), B=>P4(0), prod=>P5(0));
  
  --Carry generate, from only G and P lev-0
  --c1 is G1(0)
  c2: abcgate port map (A=>G2(0), B=>P2(0), C=>Cin, abc=>C(2));
  c4: abcgate port map (A=>G3(0), B=>P3(0), C=>Cin, abc=>C(4));
  c8: abcgate port map (A=>G4(0), B=>P4(0), C=>Cin, abc=>C(8));
  c16: abcgate port map (A=>G5(0), B=>P5(0), C=>Cin, abc=>Cout);
  
  --internal carries from the above lev-0 => lev-1
  --c1=G1(0), c2=G2(0), c4=G3(0), c8=G4(0), c16=G5(0)
  c3: abcgate port map (A=>G1(2), B=>P1(2), C=>C(2), abc=>C(3));--C3 = G12 + P12 · C2
  c5: abcgate port map (A=>G1(4), B=>P1(4), C=>C(4), abc=>C(5));
  c9: abcgate port map (A=>G1(8), B=>P1(8), C=>C(8), abc=>C(9));
 
--7,6->c8,  9,8->c10   11,10->c12   13,12->c14   15,14->c16 from second stage
--3,0->c4,  7,4->c8,   11,8->c12,  15,12->c16 from 3rd stage
  --internal carries from the above lev-0,1 => lev-2
  c6: abcgate port map (A=>G2(2), B=>P2(2), C=>C(4), abc=>C(6));--C6 = G25,4 + P25,4 · C4
  c10: abcgate port map (A=>G2(4), B=>P2(4), C=>C(8), abc=>C(10));--C10 = G29,8 + P29,8 · C8
  c12: abcgate port map (A=>G3(2), B=>P3(2), C=>C(8), abc=>C(12));--C12 = G3(11,8) + P2(11,8)·C8
  
  --internal carries from the above lev-0,1,2 => lev-3
  c7: abcgate port map (A=>G1(6), B=>P1(6), C=>C(6), abc=>C(7)); 
  c11: abcgate port map (A=>G1(10), B=>P1(10), C=>C(10), abc=>C(11)); 
  c13: abcgate port map (A=>G1(12), B=>P1(12), C=>C(12), abc=>C(13)); 
  c14: abcgate port map (A=>G2(6), B=>P2(6), C=>C(12), abc=>C(14)); --C14 = G213,12 + P213,12·C12
  
  c15: abcgate port map (A=>G1(14),B=>P1(14), C=>C(14), abc=>C(15));--from c14
  
  
  --Sum generate
  s0: xorgate port map (A=>P1(0), B=>Cin, uneq=>Sum(0));
  s1: xorgate port map (A=>P1(1), B=>C(1), uneq=>Sum(1));
  s2: xorgate port map (A=>P1(2), B=>C(2), uneq=>Sum(2));
  s3: xorgate port map (A=>P1(3), B=>C(3), uneq=>Sum(3));
  s4: xorgate port map (A=>P1(4), B=>C(4), uneq=>Sum(4));
  s5: xorgate port map (A=>P1(5), B=>C(5), uneq=>Sum(5));
  s6: xorgate port map (A=>P1(6), B=>C(6), uneq=>Sum(6));
  s7: xorgate port map (A=>P1(7), B=>C(7), uneq=>Sum(7));
  s8: xorgate port map (A=>P1(8), B=>C(8), uneq=>Sum(8));
  s9: xorgate port map (A=>P1(9), B=>C(9), uneq=>Sum(9));
  s10: xorgate port map (A=>P1(10), B=>C(10), uneq=>Sum(10));
  s11: xorgate port map (A=>P1(11), B=>C(11), uneq=>Sum(11));
  s12: xorgate port map (A=>P1(12), B=>C(12), uneq=>Sum(12));
  s13: xorgate port map (A=>P1(13), B=>C(13), uneq=>Sum(13));
  s14: xorgate port map (A=>P1(14), B=>C(14), uneq=>Sum(14));
  s15: xorgate port map (A=>P1(15), B=>C(15), uneq=>Sum(15));
    
  
end architecture Struct;


    