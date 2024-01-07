 library ieee;
use ieee.std_logic_1164.all;
library ieee;
use ieee.std_logic_1164.all;
library work;
use work.Gates.all;

entity MAC is
  port (A, B: in std_logic_vector(7 downto 0); C: in std_logic_vector(15 downto 0);
			Product: out std_logic_vector(15 downto 0); Cout: out std_logic);
end entity MAC;

architecture Struct of MAC is 
  
  --stage1 wires
  signal Col1: std_logic_vector(1 downto 1); --1 is for a0b0 and 0th index is for C(0)
  signal Col2: std_logic_vector(2 downto 1);
  signal Col3: std_logic_vector(3 downto 1);
  signal Col4: std_logic_vector(4 downto 1);
  signal Col5: std_logic_vector(5 downto 1);
  signal Col6: std_logic_vector(6 downto 1);
  signal Col7: std_logic_vector(7 downto 1);
  signal Col8: std_logic_vector(8 downto 1);
  signal Col9: std_logic_vector(7 downto 1);
  signal Col10: std_logic_vector(6 downto 1);
  signal Col11: std_logic_vector(5 downto 1);
  signal Col12: std_logic_vector(4 downto 1);
  signal Col13: std_logic_vector(3 downto 1);
  signal Col14: std_logic_vector(2 downto 1);
  signal Col15: std_logic_vector(1 downto 1);
  
  --stage2 wires from adders of above stage
  signal W6: std_logic_vector(1 downto 1);
  signal W7: std_logic_vector(3 downto 1);
  signal W8: std_logic_vector(5 downto 1);
  signal W9: std_logic_vector(6 downto 1);
  signal W10: std_logic_vector(5 downto 1);
  signal W11: std_logic_vector(3 downto 1);
  signal W12: std_logic_vector(1 downto 1);
  
  --stage3 wires from adders of above stage
  signal X4: std_logic_vector(1 downto 1);
  signal X5: std_logic_vector(3 downto 1);
  signal X6: std_logic_vector(4 downto 1);
  signal X7: std_logic_vector(4 downto 1);
  signal X8: std_logic_vector(4 downto 1);
  signal X9: std_logic_vector(4 downto 1);
  signal X10: std_logic_vector(4 downto 1);
  signal X11: std_logic_vector(4 downto 1);
  signal X12: std_logic_vector(4 downto 1);
  signal X13: std_logic_vector(3 downto 1);
  signal X14: std_logic_vector(1 downto 1);
  
  --stage4 wires from adders of above stage
  
  signal Z3: std_logic_vector(1 downto 1);
  signal Z4: std_logic_vector(2 downto 1);
  signal Z5: std_logic_vector(2 downto 1);
  signal Z6: std_logic_vector(2 downto 1);
  signal Z7: std_logic_vector(2 downto 1);
  signal Z8: std_logic_vector(2 downto 1);
  signal Z9: std_logic_vector(2 downto 1);
  signal Z10: std_logic_vector(2 downto 1);
  signal Z11: std_logic_vector(2 downto 1);
  signal Z12: std_logic_vector(2 downto 1);
  signal Z13: std_logic_vector(2 downto 1);
  signal Z14: std_logic_vector(2 downto 1);
  signal Z15: std_logic_vector(1 downto 1);
  
  
  --stage5 wires from adders of above stage
  signal Y2: std_logic_vector(1 downto 1);
  signal Y3: std_logic_vector(2 downto 1);
  signal Y4: std_logic_vector(2 downto 1);
  signal Y5: std_logic_vector(2 downto 1);
  signal Y6: std_logic_vector(2 downto 1);
  signal Y7: std_logic_vector(2 downto 1);
  signal Y8: std_logic_vector(2 downto 1);
  signal Y9: std_logic_vector(2 downto 1);
  signal Y10: std_logic_vector(2 downto 1);
  signal Y11: std_logic_vector(2 downto 1);
  signal Y12: std_logic_vector(2 downto 1);
  signal Y13: std_logic_vector(2 downto 1);
  signal Y14: std_logic_vector(2 downto 1);
  signal Y15: std_logic_vector(2 downto 1);
  signal Y16: std_logic_vector(1 downto 1);
  
  begin
  --8*8 array of and gates==stage1		a7, a6, a5,.....a0
  ---									b7, b6, b5, ....b0 index of b will in row and that of in column
  --right most column is col1 
  --bellow group is for row1
  arr00: andgate port map (A=>A(0) , B=>B(0) , prod=>Col1(1));
  arr01: andgate port map (A=>A(1) , B=>B(0) , prod=>Col2(1));
  arr02: andgate port map (A=>A(2) , B=>B(0) , prod=>Col3(1));
  arr03: andgate port map (A=>A(3) , B=>B(0) , prod=>Col4(1));
  arr04: andgate port map (A=>A(4) , B=>B(0) , prod=>Col5(1));
  arr05: andgate port map (A=>A(5) , B=>B(0) , prod=>Col6(1));
  arr06: andgate port map (A=>A(6) , B=>B(0) , prod=>Col7(1));
  arr07: andgate port map (A=>A(7) , B=>B(0) , prod=>Col8(1));
  
  arr10: andgate port map (A=>A(0) , B=>B(1) , prod=>Col2(2));
  arr11: andgate port map (A=>A(1) , B=>B(1) , prod=>Col3(2));
  arr12: andgate port map (A=>A(2) , B=>B(1) , prod=>Col4(2));
  arr13: andgate port map (A=>A(3) , B=>B(1) , prod=>Col5(2));
  arr14: andgate port map (A=>A(4) , B=>B(1) , prod=>Col6(2));
  arr15: andgate port map (A=>A(5) , B=>B(1) , prod=>Col7(2));
  arr16: andgate port map (A=>A(6) , B=>B(1) , prod=>Col8(2));
  arr17: andgate port map (A=>A(7) , B=>B(1) , prod=>Col9(1));
  
  arr20: andgate port map (A=>A(0) , B=>B(2) , prod=>Col3(3));
  arr21: andgate port map (A=>A(1) , B=>B(2) , prod=>Col4(3));
  arr22: andgate port map (A=>A(2) , B=>B(2) , prod=>Col5(3));
  arr23: andgate port map (A=>A(3) , B=>B(2) , prod=>Col6(3));
  arr24: andgate port map (A=>A(4) , B=>B(2) , prod=>Col7(3));
  arr25: andgate port map (A=>A(5) , B=>B(2) , prod=>Col8(3));
  arr26: andgate port map (A=>A(6) , B=>B(2) , prod=>Col9(2));
  arr27: andgate port map (A=>A(7) , B=>B(2) , prod=>Col10(1));
  
  arr30: andgate port map (A=>A(0) , B=>B(3) , prod=>Col4(4));
  arr31: andgate port map (A=>A(1) , B=>B(3) , prod=>Col5(4));
  arr32: andgate port map (A=>A(2) , B=>B(3) , prod=>Col6(4));
  arr33: andgate port map (A=>A(3) , B=>B(3) , prod=>Col7(4));
  arr34: andgate port map (A=>A(4) , B=>B(3) , prod=>Col8(4));
  arr35: andgate port map (A=>A(5) , B=>B(3) , prod=>Col9(3));
  arr36: andgate port map (A=>A(6) , B=>B(3) , prod=>Col10(2));
  arr37: andgate port map (A=>A(7) , B=>B(3) , prod=>Col11(1));
  
  arr40: andgate port map (A=>A(0) , B=>B(4) , prod=>Col5(5));
  arr41: andgate port map (A=>A(1) , B=>B(4) , prod=>Col6(5));
  arr42: andgate port map (A=>A(2) , B=>B(4) , prod=>Col7(5));
  arr43: andgate port map (A=>A(3) , B=>B(4) , prod=>Col8(5));
  arr44: andgate port map (A=>A(4) , B=>B(4) , prod=>Col9(4));
  arr45: andgate port map (A=>A(5) , B=>B(4) , prod=>Col10(3));
  arr46: andgate port map (A=>A(6) , B=>B(4) , prod=>Col11(2));
  arr47: andgate port map (A=>A(7) , B=>B(4) , prod=>Col12(1));
  
  arr50: andgate port map (A=>A(0) , B=>B(5) , prod=>Col6(6));
  arr51: andgate port map (A=>A(1) , B=>B(5) , prod=>Col7(6));
  arr52: andgate port map (A=>A(2) , B=>B(5) , prod=>Col8(6));
  arr53: andgate port map (A=>A(3) , B=>B(5) , prod=>Col9(5));
  arr54: andgate port map (A=>A(4) , B=>B(5) , prod=>Col10(4));
  arr55: andgate port map (A=>A(5) , B=>B(5) , prod=>Col11(3));
  arr56: andgate port map (A=>A(6) , B=>B(5) , prod=>Col12(2));
  arr57: andgate port map (A=>A(7) , B=>B(5) , prod=>Col13(1));
  
  arr60: andgate port map (A=>A(0) , B=>B(6) , prod=>Col7(7));
  arr61: andgate port map (A=>A(1) , B=>B(6) , prod=>Col8(7));
  arr62: andgate port map (A=>A(2) , B=>B(6) , prod=>Col9(6));
  arr63: andgate port map (A=>A(3) , B=>B(6) , prod=>Col10(5));
  arr64: andgate port map (A=>A(4) , B=>B(6) , prod=>Col11(4));
  arr65: andgate port map (A=>A(5) , B=>B(6) , prod=>Col12(3));
  arr66: andgate port map (A=>A(6) , B=>B(6) , prod=>Col13(2));
  arr67: andgate port map (A=>A(7) , B=>B(6) , prod=>Col14(1));
  
  arr70: andgate port map (A=>A(0) , B=>B(7) , prod=>Col8(8));
  arr71: andgate port map (A=>A(1) , B=>B(7) , prod=>Col9(7));
  arr72: andgate port map (A=>A(2) , B=>B(7) , prod=>Col10(6));
  arr73: andgate port map (A=>A(3) , B=>B(7) , prod=>Col11(5));
  arr74: andgate port map (A=>A(4) , B=>B(7) , prod=>Col12(4));
  arr75: andgate port map (A=>A(5) , B=>B(7) , prod=>Col13(3));
  arr76: andgate port map (A=>A(6) , B=>B(7) , prod=>Col14(2));
  arr77: andgate port map (A=>A(7) , B=>B(7) , prod=>Col15(1));
  
  --stage2
  ha16: HALF_ADDER port map (A=>C(5), B=>Col6(1), S=>W6(1), C=>W7(2)); --haij i is stage and j is column
  
  fa17: Full_Adder port map (A=>C(6), B=>Col7(1), Cin=>Col7(2),  S=>W7(1), Cout=>W8(2));
  ha17: HALF_ADDER port map (A=>Col7(3), B=>Col7(4), S=>W7(3), C=>W8(4));
  
  fa18: Full_Adder port map (A=>C(7), B=>Col8(1), Cin=>Col8(2),  S=>W8(1), Cout=>W9(2));
  fa18ii: Full_Adder port map (A=>Col8(3), B=>Col8(4), Cin=>Col8(5),  S=>W8(3), Cout=>W9(4));
  ha18: HALF_ADDER port map (A=>Col8(6), B=>Col8(7), S=>W8(5), C=>W9(6));
  
  fa19: Full_Adder port map (A=>C(8), B=>Col9(1), Cin=>Col9(2),  S=>W9(1), Cout=>W10(2));
  ha19: HALF_ADDER port map (A=>Col9(3), B=>Col9(4), S=>W9(3), C=>W10(4));
  fa19ii: Full_Adder port map (A=>Col9(5), B=>Col9(6), Cin=>Col9(7),  S=>W9(5), Cout=>W10(5));
  
  fa110: Full_Adder port map (A=>C(9), B=>Col10(1), Cin=>Col10(2),  S=>W10(1), Cout=>W11(2));
  fa110ii: Full_Adder port map (A=>Col10(3), B=>Col10(4), Cin=>Col10(5),  S=>W10(3), Cout=>W11(3));
  
  fa111: Full_Adder port map (A=>C(10), B=>Col11(1), Cin=>Col11(2),  S=>W11(1), Cout=>W12(1));
    
  --stage3
  ha24: HALF_ADDER port map (A=>C(3), B=>Col4(1), S=>X4(1), C=>X5(2));
  
  fa25: Full_Adder port map (A=>C(4), B=>Col5(1), Cin=>Col5(2),  S=>X5(1), Cout=>X6(2));
  ha25: HALF_ADDER port map (A=>Col5(3), B=>Col5(4), S=>X5(3), C=>X6(4));
  
  fa26: Full_Adder port map (A=>W6(1), B=>Col6(2), Cin=>Col6(3),  S=>X6(1), Cout=>X7(2));
  fa26ii: Full_Adder port map (A=>Col6(4), B=>Col6(5), Cin=>Col6(6),  S=>X6(3), Cout=>X7(4));
  
  fa27: Full_Adder port map (A=>W7(1), B=>W7(2), Cin=>W7(3), S=>X7(1), Cout=>X8(2));
  fa27ii: Full_Adder port map (A=>Col7(5), B=>Col7(6), Cin=>Col7(7),  S=>X7(3), Cout=>X8(4));
  
  fa28: Full_Adder port map (A=>W8(1), B=>W8(2), Cin=>W8(3), S=>X8(1), Cout=>X9(2));
  fa28ii: Full_Adder port map (A=>W8(4), B=>W8(5), Cin=>Col8(8), S=>X8(3), Cout=>X9(4));
  
  fa29: Full_Adder port map (A=>W9(1), B=>W9(2), Cin=>W9(3), S=>X9(1), Cout=>X10(2));
  fa29ii: Full_Adder port map (A=>W9(4), B=>W9(5), Cin=>W9(6), S=>X9(3), Cout=>X10(4));
  
  fa210: Full_Adder port map (A=>W10(1), B=>W10(2), Cin=>W10(3), S=>X10(1), Cout=>X11(2));
  fa210ii: Full_Adder port map (A=>W10(4), B=>W10(5), Cin=>Col10(6), S=>X10(3), Cout=>X11(4));
  
  fa211: Full_Adder port map (A=>W11(1), B=>W11(2), Cin=>W11(3), S=>X11(1), Cout=>X12(2));
  fa211ii: Full_Adder port map (A=>Col11(3), B=>Col11(4), Cin=>Col11(5), S=>X11(3), Cout=>X12(4));
  
  fa212: Full_Adder port map (A=>C(11), B=>Col12(1), Cin=>Col12(2), S=>X12(1), Cout=>X13(2));
  fa212ii: Full_Adder port map (A=>Col12(3), B=>Col12(4), Cin=>W12(1), S=>X12(3), Cout=>X13(3));
  
  fa213: Full_Adder port map (A=>C(12), B=>Col13(1), Cin=>Col13(2), S=>X13(1), Cout=>X14(1));
  
  --stage4
  ha33: HALF_ADDER port map (A=>C(2), B=>Col3(1), S=>Z3(1), C=>Z4(2));
  
  fa34: Full_Adder port map (A=>X4(1), B=>Col4(2), Cin=>Col4(3), S=>Z4(1), Cout=>Z5(2));
  fa35: Full_Adder port map (A=>X5(1), B=>X5(2), Cin=>X5(3), S=>Z5(1), Cout=>Z6(2));
  fa36: Full_Adder port map (A=>X6(1), B=>X6(2), Cin=>X6(3), S=>Z6(1), Cout=>Z7(2));
  fa37: Full_Adder port map (A=>X7(1), B=>X7(2), Cin=>X7(3), S=>Z7(1), Cout=>Z8(2));
  fa38: Full_Adder port map (A=>X8(1), B=>X8(2), Cin=>X8(3), S=>Z8(1), Cout=>Z9(2));
  fa39: Full_Adder port map (A=>X9(1), B=>X9(2), Cin=>X9(3), S=>Z9(1), Cout=>Z10(2));
  fa310: Full_Adder port map (A=>X10(1), B=>X10(2), Cin=>X10(3), S=>Z10(1), Cout=>Z11(2));
  fa311: Full_Adder port map (A=>X11(1), B=>X11(2), Cin=>X11(3), S=>Z11(1), Cout=>Z12(2));
  fa312: Full_Adder port map (A=>X12(1), B=>X12(2), Cin=>X12(3), S=>Z12(1), Cout=>Z13(2));
  fa313: Full_Adder port map (A=>X13(1), B=>X13(2), Cin=>X13(3), S=>Z13(1), Cout=>Z14(2));
  fa314: Full_Adder port map (A=>X14(1), B=>C(13), Cin=>Col14(1), S=>Z14(1), Cout=>Z15(1));
  
  --stage5
  ha42: HALF_ADDER port map (A=>C(1), B=>Col2(1), S=>Y2(1), C=>Y3(2));
  
  fa43: Full_Adder port map (A=>Z3(1), B=>Col3(2), Cin=>Col3(3), S=>Y3(1), Cout=>Y4(2));
  fa44: Full_Adder port map (A=>Z4(1), B=>Z4(2), Cin=>Col4(4), S=>Y4(1), Cout=>Y5(2));
  fa45: Full_Adder port map (A=>Z5(1), B=>Z5(2), Cin=>Col5(5), S=>Y5(1), Cout=>Y6(2));
  fa46: Full_Adder port map (A=>Z6(1), B=>Z6(2), Cin=>X6(4), S=>Y6(1), Cout=>Y7(2));
  fa47: Full_Adder port map (A=>Z7(1), B=>Z7(2), Cin=>X7(4), S=>Y7(1), Cout=>Y8(2));
  fa48: Full_Adder port map (A=>Z8(1), B=>Z8(2), Cin=>X8(4), S=>Y8(1), Cout=>Y9(2));
  fa49: Full_Adder port map (A=>Z9(1), B=>Z9(2), Cin=>X9(4), S=>Y9(1), Cout=>Y10(2));
  fa410: Full_Adder port map (A=>Z10(1), B=>Z10(2), Cin=>X10(4), S=>Y10(1), Cout=>Y11(2));
  fa411: Full_Adder port map (A=>Z11(1), B=>Z11(2), Cin=>X11(4), S=>Y11(1), Cout=>Y12(2));
  fa412: Full_Adder port map (A=>Z12(1), B=>Z12(2), Cin=>X12(4), S=>Y12(1), Cout=>Y13(2));
  fa413: Full_Adder port map (A=>Z13(1), B=>Z13(2), Cin=>Col13(3), S=>Y13(1), Cout=>Y14(2));
  fa414: Full_Adder port map (A=>Z14(1), B=>Z14(2), Cin=>Col14(2), S=>Y14(1), Cout=>Y15(2));
  fa415: Full_Adder port map (A=>Z15(1), B=>Col15(1), Cin=>C(14), S=>Y15(1), Cout=>Y16(1));
  
  
  --Full adder of 16 bit
  FA16: Full_Adder16 port map (
			in_A(0)=>C(0),   in_A(1)=>Y2(1),  in_A(2)=>Y3(1), in_A(3)=>Y4(1), in_A(4)=>Y5(1), in_A(5)=>Y6(1), in_A(6)=>Y7(1), in_A(7)=>Y8(1), in_A(8)=>Y9(1), in_A(9)=>Y10(1), in_A(10)=>Y11(1),in_A(11)=>Y12(1), in_A(12)=>Y13(1), in_A(13)=>Y14(1), in_A(14)=>Y15(1), in_A(15)=>Y16(1),
			in_B(0)=>Col1(1),in_B(1)=>Col2(2),in_B(2)=>Y3(2), in_B(3)=>Y4(2), in_B(4)=>Y5(2), in_B(5)=>Y6(2), in_B(6)=>Y7(2), in_B(7)=>Y8(2), in_B(8)=>Y9(2), in_B(9)=>Y10(2), in_B(10)=>Y11(2),in_B(11)=>Y12(2), in_B(12)=>Y13(2), in_B(13)=>Y14(2), in_B(14)=>Y15(2), in_B(15)=>C(15),
			Cin=>'0', Sum=>Product, Cout=>Cout);
  
  
end Struct;
