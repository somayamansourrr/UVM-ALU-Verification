import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 

class item extends uvm_sequence_item;
	rand bit [7:0] A;
	rand bit [7:0] B;
	bit [3:0] ALU_Sel;

	bit [7:0] ALU_Out;
	bit CarryOut;

	function new(string name="item");
		super.new(name);
	endfunction

	`uvm_object_utils_begin(item)
		`uvm_field_int(A,UVM_ALL_ON)
		`uvm_field_int(B,UVM_ALL_ON)
		`uvm_field_int(ALU_Sel,UVM_ALL_ON) //
	`uvm_object_utils_end

//constraints

endclass