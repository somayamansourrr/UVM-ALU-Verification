import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh"

class func_cov extends uvm_subscriber #(item);
	`uvm_component_utils(func_cov)
	item m_item;
	event passed;

	covergroup cg;
		Instructions: coverpoint m_item.ALU_Sel{ 
									option.weight=16;
									bins all []= {[0:$]};
 								   }
     		Transitioning: coverpoint m_item.ALU_Sel{ 
									option.weight=1;
									bins transition = (4'b0010 => 4'b1000 => 4'b1101); 
								    }
                                   
	endgroup

	function new(string name="func_cov", uvm_component parent=null);
		super.new(name,parent);
		cg=new();
	endfunction

	function void build_phase(uvm_phase phase);
		if(!uvm_config_db#(event)::get(this, "", "passed", passed))
        `uvm_fatal("NO_EVENT",{"uvm event must be set for: ",get_full_name(),".passed_event"});

	endfunction

	function void write (item t);
		m_item=t;
	endfunction 
	
	task run_phase(uvm_phase phase);
		forever begin
			@(passed);
				cg.sample();
		end
	endtask

	function void report_phase (uvm_phase phase);
		`uvm_info(get_type_name, $sformatf("Coverage=%0.2f %%", cg.get_coverage()), UVM_LOW);
	endfunction

endclass