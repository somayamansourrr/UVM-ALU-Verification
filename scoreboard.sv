import uvm_pkg::*;
import my_pkg::*;
`include "uvm_macros.svh" 

class scoreboard extends uvm_scoreboard;
  uvm_analysis_imp #(item, scoreboard) item_collect_export;
  item item_q[$];
  event passed;

  `uvm_component_utils(scoreboard)
  
  function new(string name = "scoreboard", uvm_component parent = null);
    super.new(name, parent);
    item_collect_export = new("item_collect_export", this);
  endfunction
  
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(event)::get(this, "", "passed", passed))
        `uvm_fatal("NO_EVENT",{"uvm event must be set for: ",get_full_name(),".passed_event"});
    
  endfunction
  
  function void write(item req);
    item_q.push_back(req);
  endfunction
  
  task run_phase (uvm_phase phase);
    item sb_item;
    bit [7:0] output_1;
    bit carry_out;
    forever begin
      wait(item_q.size > 0);
      if(item_q.size > 0) begin
        sb_item = item_q.pop_front();
	case(sb_item.ALU_Sel)
		4'b0000:
			begin
			{carry_out, output_1} = sb_item.A + sb_item.B;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
				if(carry_out == sb_item.CarryOut) begin
          				`uvm_info(get_type_name, $sformatf("Addition Matched: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,sb_item.CarryOut),UVM_LOW);
          				 ->passed;
				end
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Addition NOT matched: A = %0d, B = %0d, ALU_Out = %0d, CarryOut=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,sb_item.CarryOut));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end

		4'b0001: //Subtraction
			begin
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A - sb_item.B == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Subtraction Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Subtraction NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end

		4'b0010: // Multiplication
			begin
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A * sb_item.B == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Multiplication Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Multiplication NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end

		4'b0011: //Division
			begin
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A / sb_item.B == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Division Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Division NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b0100: // Logical Shift Left
			begin
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A <<1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical Shift Left Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical Shift Left NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b0101: // Logical Shift Right
			begin
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A >> 1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical Shift Right Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical Shift Right NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b0110: // Rotate Left
			begin
			output_1= {sb_item.A[6:0] , sb_item.A[7]};
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Rotate Left Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Rotate Left NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b0111: // Rotate Right
			begin
			output_1= {sb_item.A[0] , sb_item.A[7:1]};
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Rotate Right Matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Rotate Right NOT matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1000: // Logical AND
			begin
			output_1= sb_item.A & sb_item.B;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical And Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical And NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1001: // Logical OR
			begin
			output_1= sb_item.A | sb_item.B;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical OR Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical OR NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1010: // Logical XOR
			begin
			output_1= sb_item.A ^ sb_item.B;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical XOR Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical XOR NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1011: // Logical NOR
			begin
			output_1= ~(sb_item.A | sb_item.B);
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical NOR Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical NOR NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1100: // Logical NAND
			begin
			output_1= ~(sb_item.A & sb_item.B);
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical NAND Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical NAND NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1101: // Logical XNOR
			begin
			output_1= ~(sb_item.A ^ sb_item.B);
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Logical XNOR Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Logical XNOR NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1110: // Greater Comparison
			begin
			output_1=(sb_item.A > sb_item.B)?8'd1:8'd0;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Greater Comparison Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Greater Comparison NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		4'b1111: // Equal Comparison
			begin
			output_1=(sb_item.A == sb_item.B)?8'd1:8'd0;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(output_1 == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Equal Comparison Matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out),UVM_LOW);
          			->passed;
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("Equal Comparison NOT matched: A = %0d, B = %0d, ALU_Out = %0d", sb_item.A, sb_item.B, sb_item.ALU_Out));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		default:
			begin
			output_1= sb_item.A + sb_item.B;
        		$display("----------------------------------------------------------------------------------------------------------");
        		if(sb_item.A + sb_item.B == sb_item.ALU_Out) begin
          			`uvm_info(get_type_name, $sformatf("Matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1),UVM_LOW);
          			// done.trigger();
			end
       			else begin
         			 `uvm_error(get_name, $sformatf("NOT matched: A = %0d, B = %0d, ALU_Out = %0d, output_1=%0d", sb_item.A, sb_item.B, sb_item.ALU_Out,output_1));
	

        		end
        		$display("----------------------------------------------------------------------------------------------------------");
     			end
		endcase
	end
    end
  endtask
  
endclass