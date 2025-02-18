library ieee;
use ieee.std_logic_1164.all;

library NX;
use NX.nxPackage.all;

entity flipflop_tb is
end flipflop_tb;

architecture Sim of flipflop_tb is

signal D,clk,reset,Q : std_logic:='0';

component RisingEdge_DFlipFlop_AsyncResetHigh
port (
	D           : in    std_logic;
	Q           : out   std_logic;
	async_reset : in    std_logic;
	clk         : in    std_logic
);
end component;

begin

dut: RisingEdge_DFlipFlop_AsyncResetHigh
  port map(
	D            => D,
	Q            => Q,
	async_reset  => reset,
	clk          => clk
);

---clock
process
begin
    wait for 40 ns;
    clk<=not clk;
end process;

--test bench
process
begin
    reset<='1';
    --initialize inputs
    D <= '0';

    --wait prior to disbale reset
    wait for 13 ns;
    reset<='0';

    --synchronize with clock rising edge
    wait until rising_edge(clk);
    D <= '1';
    wait until rising_edge(clk);
    D <= '0';
    wait until rising_edge(clk);
    wait until rising_edge(clk);
    D <= '1';

    wait for 200 ns;

   assert false report "Test: OK" severity failure;
end process;

end Sim;