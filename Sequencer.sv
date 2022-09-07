import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh"

typedef class item;

// This class is not necessary, could just use uvm_sequencer class directly
class Sequencer extends uvm_sequencer#(item);
	`uvm_component_utils(Sequencer)

	function new(string name="Sequencer",uvm_component parent=null);
		super.new(name,parent);
	endfunction

	function void build_phase(uvm_phase phase);
		super.build_phase(phase);
	endfunction
endclass
