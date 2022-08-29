import uvm_pkg::*;
//import my_pkg::*;
`include "base_test.sv";
`include "uvm_macros.svh"
//`include "item.sv"

module tb_top;
  /*bit clk;
  bit reset;
  always #2 clk = ~clk;
  
  initial begin
    //clk = 0;
    reset = 1;
    #5; 
    reset = 0;
  end
*/
  add_if vif();
  clk_if cif();	
  
  alu DUT(.A(vif.A),
		.B(vif.B),
		.ALU_Sel(vif.ALU_Sel),
		.ALU_Out(vif.ALU_Out),
		.CarryOut(vif.CarryOut));
  
  initial begin
    // set interface in config_db
    uvm_config_db#(virtual add_if)::set(uvm_root::get(), "*", "vif", vif);
    uvm_config_db#(virtual clk_if)::set(uvm_root::get(), "*", "cif", cif);
  end
  initial begin
    run_test("base_test");
  end
endmodule
