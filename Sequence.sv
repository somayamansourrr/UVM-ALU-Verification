import uvm_pkg::*;
`include "uvm_macros.svh"
//`include "item.sv"

class Sequence extends uvm_sequence#(item);
	item req;
	`uvm_object_utils(Sequence)

	function new(string name="Sequence");
		super.new(name);
	endfunction

	task body();
		`uvm_info(get_type_name(),"Sequence: Inside Body",UVM_LOW);
		`uvm_do(req);
	endtask
endclass
