import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh"


module tb_top;
  bit clk;
  bit reset;
  always #2 clk = ~clk;
  
  initial begin
    reset = 1;
    #5; 
    reset = 0;
  end

  add_if vif(clk,reset);
  
  alu DUT(  .clk(vif.clk),
		.reset(vif.reset),
		.A(vif.A),
		.B(vif.B),
		.ALU_Sel(vif.ALU_Sel),
		.ALU_Out(vif.ALU_Out),
		.CarryOut(vif.CarryOut));
  
  initial begin
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
  end

  initial begin
    // Use the following command argument: vsim -c -do "run -all" tb_top +UVM_TESTNAME=testcase_1 
    run_test();
  end

endmodule
