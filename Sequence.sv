import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 


class Sequence extends uvm_sequence#(item);
	item req;
	`uvm_object_utils(Sequence)

	function new(string name="Sequence");
		super.new(name);
	endfunction

	task body();
		`uvm_info(get_type_name(),"Sequence: Inside Body",UVM_LOW);
		for(int i=0;i<4;i++) begin
			//Lower Bound Constraints
			if(i==0) 
				`uvm_do_with(req, {req.A inside {[0:63]}; req.B inside {[0:63]}; })
			//Lower Middle Bound Constraints
			else if(i==1)
				`uvm_do_with(req, {req.A inside {[64:127]}; req.B inside {[64:127]}; })
			//Upper Middle Bound Constraints
			else if(i==2)
				`uvm_do_with(req, {req.A inside {[128:191]}; req.B inside {[128:191]}; })
			//Upper Bound Constraints
			else
				`uvm_do_with(req, {req.A inside {[192:255]}; req.B inside {[192:255]}; })
			#4;
		end
	endtask
endclass
