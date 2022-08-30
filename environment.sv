import uvm_pkg::*;
`include "uvm_macros.svh"
`include "agent.sv";
`include "scoreboard.sv";
`include "func_cov.sv";


class environment extends uvm_env;
  `uvm_component_utils(environment)
  agent agt;
  scoreboard sb;
  func_cov fc;
 
  function new(string name = "environment", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agt = agent::type_id::create("agt", this);
    sb = scoreboard::type_id::create("sb", this);
    fc = func_cov::type_id::create("fc", this);
  endfunction
  
  function void connect_phase(uvm_phase phase);
    agt.mon.item_collect_port.connect(sb.item_collect_export);
    agt.mon.item_collect_port.connect(fc.analysis_export);
  endfunction
endclass
