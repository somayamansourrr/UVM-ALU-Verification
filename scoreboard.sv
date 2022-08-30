import uvm_pkg::*;


class scoreboard extends uvm_scoreboard;
  uvm_analysis_imp #(item, scoreboard) item_collect_export;
  item item_q[$];
  `uvm_component_utils(scoreboard)
  uvm_event passed;
  
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
    bit [7:0] output_1;
    passed=new();
    forever begin
      wait(item_q.size > 0);
      
      if(item_q.size > 0) begin
        sb_item = item_q.pop_front();
	output_1= sb_item.A + sb_item.B;
        $display("----------------------------------------------------------------------------------------------------------");
        if(sb_item.A + sb_item.B == sb_item.ALU_Out) begin
          `uvm_info(get_type_name, $sformatf("Matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1),UVM_LOW);
        end
        else begin
          `uvm_error(get_name, $sformatf("NOT matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1));

        end
        $display("----------------------------------------------------------------------------------------------------------");
      end
    end
  endtask
  
endclass