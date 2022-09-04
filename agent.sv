import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 

typedef class Sequencer;
typedef class driver;
typedef class monitor; 

class agent extends uvm_agent;
  `uvm_component_utils(agent)
  driver drv;
  Sequencer seqr;
  monitor mon;

  function new(string name = "agent", uvm_component parent = null);
    super.new(name, parent);
 
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    
    if(get_is_active == UVM_ACTIVE) begin 
      drv = driver::type_id::create("drv", this);
      seqr = Sequencer::type_id::create("seqr", this);
    end
    mon = monitor::type_id::create("mon", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    if(get_is_active == UVM_ACTIVE) begin 
      drv.seq_item_port.connect(seqr.seq_item_export);
    end 
  endfunction


endclass