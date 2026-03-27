LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_arith.all;
USE ieee.std_logic_unsigned.all;
--------------------------------------------
entity adder_subtractor is
    generic ( n : integer := 8 );
    port (
        X        : in  std_logic_vector(n-1 downto 0);
        Y        : in  std_logic_vector(n-1 downto 0);
        alufa    : in  std_logic_vector(2 downto 0 );
        res      : out std_logic_vector(n-1 downto 0);
        cout     : out std_logic  
    );
end adder_subtractor;
------------------------------------------------
architecture Structural of adder_subtractor is

    component FA is
        port (
            a    : in  std_logic;
            b    : in  std_logic;
            cin  : in  std_logic;
            s    : out std_logic;
            cout : out std_logic
        );
    end component;

signal reg : std_logic_vector (n-1 downto 0 ) ;
signal X_XOR : std_logic_vector (n-1 downto 0 ) ;

begin   
	X_XOR(0) <= x(0) xor sub_flag;
	
    FA_0 : FA port map (
        a    => X_XOR(0),
        b    => Y(0),
        cin  => sub_flag,    
        s    => res(0),
        cout => reg(0)         
    );
    
    GEN_FA: for i in 1 to n-1 generate
        X_XOR(i) <= x(i) xor sub_flag;
        FA_loop : FA port map (
            a    => X_XOR(i),
            b    => Y(i),
            cin  => reg(i-1),       
            s    => res(i),
            cout => reg(i)      
        );
      
    end generate GEN_FA;
	
    c <= reg(n-1);

end Structural;
