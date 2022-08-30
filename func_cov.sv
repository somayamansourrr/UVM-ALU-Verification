import uvm_pkg::*;
`include "uvm_macros.svh"
`include "add_if.sv"

class func_cov extends uvm_component;
	`uvm_component_utils(func_cov)
	//item m_item;
	uvm_event passed;
	virtual add_if vif;

	covergroup cg @(passed);
		Instructions: coverpoint vif.ALU_Sel { option.weight=16;
								   bins all []= {[0:$]};
 			
                                    }
	endgroup

	function new(string name="func_cov", uvm_component parent=null);
		super.new(name,parent);
		cg=new();
	endfunction

	
	/*function void write (item t);
		m_item=t;
		passed.wait_trigger;
		cg.sample();
		$display("Coverage=%0.2f %%", cg.get_coverage());
	endfunction */

	task run_phase(uvm_phase phase);
    		forever begin
      		@(passed);
      		cg.sample();
			$display("Coverage=%0.2f %%", cg.get_coverage());
    		end
  	endtask
endclass