interface clk_if();
  logic tb_clk;
  initial tb_clk<=0;
  always #10 tb_clk=~tb_clk;
endinterface
