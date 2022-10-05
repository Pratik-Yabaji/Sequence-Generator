library ieee;
use ieee.std_logic_1164.all;

package Flipflops is

component dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end component dff_set;

component dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end component dff_reset;

end package Flipflops;

--D flip flop with set
library ieee;
use ieee.std_logic_1164.all;

entity dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end entity dff_set;
architecture behav of dff_set is

begin

dff_set_proc: process (clock,set)

begin

if(set='1')then 
Q <= '1';
elsif (clock'event and (clock='1')) then
Q <= D;

end if ;
end process dff_set_proc;
end behav;

--D flip flop with reset

library ieee;
use ieee.std_logic_1164.all;

entity dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end entity dff_reset;
architecture behav of dff_reset is

begin
dff_reset_proc: process (clock,reset)

begin
if(reset='1')then 
Q <= '0';
elsif (clock'event and (clock='1')) then
Q <= D; 
end if ;
end process dff_reset_proc;
end behav;

library ieee;
use ieee.std_logic_1164.all;

-- write the Flipflops packege declaration

entity Sequence_Generator is

port (reset,clock: in std_logic;
y:out std_logic);

end entity Sequence_Generator;

architecture struct of Sequence_generator is
signal D :std_logic_vector(2 downto 0);
signal Q:std_logic_vector(2 downto 0);

component dff_set is port(D,clock,set:in std_logic;Q:out std_logic);
end component dff_set;

component dff_reset is port(D,clock,reset:in std_logic;Q:out std_logic);
end component dff_reset;

begin

	D(2) <= (not(Q(1)) and Q(0)) or (Q(2) and (not(Q(0))));
	D(1) <= Q(2) or (Q(1) and Q(0));
	D(0) <= Q(2) or (not(Q(1)));

	dff2: dff_set port map(D => D(2),clock => clock,set => reset, Q => Q(2));
	dff1: dff_set port map(D => D(1),clock => clock,set => reset, Q => Q(1));
	dff0: dff_set port map(D => D(0),clock => clock,set => reset, Q => Q(0));
	
	y <= Q(0);
	
end struct;