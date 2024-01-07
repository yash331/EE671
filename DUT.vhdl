-- A DUT entity is used to wrap your design.
--  This example shows how you can do this for the
--  Full-adder.

library ieee;
use ieee.std_logic_1164.all;
entity DUT is --ABC , (8,8,16)
   port(input_vector: in std_logic_vector(31 downto 0);
       	output_vector: out std_logic_vector(16 downto 0)); --prod
end entity;

architecture DutWrap of DUT is
   component MAC is
    port (A, B: in std_logic_vector(7 downto 0); C: in std_logic_vector(15 downto 0);
			Product: out std_logic_vector(15 downto 0); Cout: out std_logic);
   end component;
begin

   -- input/output vector element ordering is critical,
   -- and must match the ordering in the trace file!
   add_instance: MAC 
			port map (
					
					A => input_vector(31 downto 24),
					B => input_vector(23 downto 16),
					C  => input_vector(15 downto 0),
               Cout =>  output_vector(16),                       
					Product => output_vector(15 downto 0)
					
					);  -- order of inputs ABC

end DutWrap;

