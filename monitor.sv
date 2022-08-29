import uvm_pkg::*;
//import my_pkg::*;
`include "uvm_macros.svh"
//`include "item.sv"

class monitor extends uvm_monitor;
  virtual add_if vif;
  virtual clk_if cif;
  uvm_analysis_port #(item) item_collect_port;
  item mon_item;
  `uvm_component_utils(monitor)
  
  function new(string name = "monitor", uvm_component parent = null);
    super.new(name, parent);
    item_collect_port = new("item_collect_port", this);
    mon_item = new();    //
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual add_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
    if(!uvm_config_db#(virtual clk_if) :: get(this, "", "cif", cif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
     // wait(!vif.reset);
      @(posedge cif.tb_clk);
      mon_item.A = vif.A;
      mon_item.B = vif.B;
	mon_item.ALU_Sel = vif.ALU_Sel;
      `uvm_info(get_type_name, $sformatf("A = %0d, B = %0d, ALU_Sel=%0d", mon_item.A, mon_item.B, mon_item.ALU_Sel), UVM_HIGH);
      @(posedge cif.tb_clk);
      mon_item.ALU_Out = vif.ALU_Out;
	mon_item.CarryOut = vif.CarryOut;
      item_collect_port.write(mon_item);
    end
 endtask
endclass