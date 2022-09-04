import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh"

class testcase_13 extends base_test;
  `uvm_component_utils(testcase_13)
  
  function new(string name = "testcase_13",uvm_component parent=null);
    super.new(name,parent);
  endfunction
  
  task run_phase(uvm_phase phase);
    env_o.agt.drv.vif.ALU_Sel=4'b1100;
    super.run_phase(phase);
  endtask
endclass
