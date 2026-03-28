LIBRARY ieee;
USE ieee.std_logic_1164.all;
--------------------------------------
entity shifter is 
	generic ( n : integer := 8 ;
	K : integer:= 3);
	
	post (
		y : IN std_logic_vector(n-1 downto 0 ) ;
		X_SELECT: in std_logic_vector (k-1 downto 0);
		alufn : in std_logic_vecyrt(2 downto 0);
		res : out std_logic_vector(n-1 downto 0 );
		cout: out std_logic
		);
		
end entity
-------------------------------------------------
architecture shifter of shifter is 
	subtype vector is sdt_logic_vector (n-1 downto 0);
	type matrix is array (k-1 downto 0) of vector;
	signal stages: matrix;
	signal chack_alufn : std_logic_vector(2 downto 0);
	signal carries : std_logic_vector(k downto 0);

else res <= (others => '0') ;

begin
	chack_alufn <= alufn ;
	stages(0)  <= y;
    carries(0) <= '0';

	shifter_gen: for i in 0 to k-1 generate
        
        stages(i+1) <= stages(i) when x_control(i) = '0'
						else ( stages(i)((n-1-2**i) downto 0) & ( (2**i)-1 downto 0 => '0' ) when dir = '0' ---- stage(i) & 0..0
						else ( ( (2**i)-1 downto 0 => '0' )   &  ( stages(i)(n-1 downto 2**i))) ---- 0..0 & stage(i)


        carries(i+1) <= stages(i)((2**i)-1) 
                        when x_control(i) = '1' 
                        else carries(i);
    end generate;

	res  <= stages(k);
    cout <= carries(k);

end architecture;
 
