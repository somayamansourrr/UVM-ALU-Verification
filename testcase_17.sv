import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 


class testcase_17 extends base_test;
  `uvm_component_utils(testcase_17)
  
  function new(string name = "testcase_17", uvm_component parent = null);
    super.new(name, parent);
  endfunction

  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = Sequence::type_id::create("bseq");
    fork
    //Thread1
    begin
    	env_o.agt.drv.vif.ALU_Sel=4'b0010;
	#7; env_o.agt.drv.vif.ALU_Sel=4'b1000;
	#5; env_o.agt.drv.vif.ALU_Sel=4'b1101;
    end

    //Thread2
    repeat(10) begin 
      #5; bseq.start(env_o.agt.seqr);
    end
    join

    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
  endtask

endclass


