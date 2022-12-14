import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 

typedef class environment;
typedef class Sequence;

class base_test extends uvm_test;
  environment env_o;
  Sequence bseq;
  `uvm_component_utils(base_test)
  
  function new(string name = "base_test", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    env_o = environment::type_id::create("env_o", this);
 
  endfunction
  
  task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    bseq = Sequence::type_id::create("bseq");
    repeat(4) begin 
      #5; bseq.start(env_o.agt.seqr);
    end
    
    phase.drop_objection(this);
    `uvm_info(get_type_name, "End of testcase", UVM_LOW);
  endtask
endclass
