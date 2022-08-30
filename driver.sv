import uvm_pkg::*; 


class driver extends uvm_driver#(item);
  virtual add_if vif;
  `uvm_component_utils(driver)
  
  function new(string name = "driver", uvm_component parent = null);
    super.new(name, parent);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual add_if) :: get(this, "", "vif", vif))
      `uvm_fatal(get_type_name(), "Not set at top level");
  endfunction
  
  task run_phase (uvm_phase phase);
    forever begin
      // Driver to the DUT
      seq_item_port.get_next_item(req);
      `uvm_info(get_type_name, $sformatf("A = %0d, B = %0d, ALU_Sel=%0d", req.A, req.B, req.ALU_Sel), UVM_LOW);
      vif.A <= req.A;
      vif.B <= req.B;
      vif.ALU_Sel <= req.ALU_Sel;
      seq_item_port.item_done();
    end
  endtask
endclass