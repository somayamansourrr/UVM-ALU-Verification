import uvm_pkg::*;
//import my_pkg::*;
//`include "item.sv"

class scoreboard extends uvm_scoreboard;
  uvm_analysis_imp #(item, scoreboard) item_collect_export;
  item item_q[$];
  `uvm_component_utils(scoreboard)
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  function void write(item req);
    item_q.push_back(req);
  endfunction
  
  task run_phase (uvm_phase phase);
    item sb_item;
	
    forever begin
      wait(item_q.size > 0);
      
      if(item_q.size > 0) begin
        sb_item = item_q.pop_front();
        $display("----------------------------------------------------------------------------------------------------------");
        if(sb_item.A + sb_item.B == sb_item.ALU_Out) begin
          `uvm_info(get_type_name, $sformatf("Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
	  //$display("Addition-SCOREBOARD PASSED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out, sb_item.CarryOut);
        end
        else begin
          `uvm_error(get_name, $sformatf("NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	//$display("Addition-SCOREBOARD FAILED: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out, sb_item.CarryOut);

        end
        $display("----------------------------------------------------------------------------------------------------------");
      end
    end
  endtask
  
endclass