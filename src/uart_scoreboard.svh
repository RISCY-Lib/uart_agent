//==============================================================================
// A UART UVM Agent
// Copyright (C) 2023  RISCY-Lib Contributors
//
// This library is free software; you can redistribute it and/or
// modify it under the terms of the GNU Lesser General Public
// License as published by the Free Software Foundation; either
// version 2.1 of the License, or (at your option) any later version.
//
// This library is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the GNU
// Lesser General Public License for more details.
//
// You should have received a copy of the GNU Lesser General Public
// License along with this library; If not, see <https://www.gnu.org/licenses/>.
//==============================================================================


//==============================================================================
// Description: The UART UVM Scoreboard
//==============================================================================

`ifndef __UART_SCOREBOARD_SVH__
`define __UART_SCOREBOARD_SVH__

class uart_scoreboard extends uvm_scoreboard;
    `uvm_component_utils (uart_scoreboard)

    //------------------------------------------
    // Members
    //------------------------------------------
    // TLM Analysis Port to receive data objects from other TB components
    uvm_analysis_imp #(uart_seq_item, uart_scoreboard) ap_imp;


    function new (string name = "uart_scoreboard", uvm_component parent = null);
        super.new (name, parent);
    endfunction


    // Instantiate the analysis port, because afterall, its a class object
    function void build_phase (uvm_phase phase);
        ap_imp = new ("ap_imp", this);
    endfunction


    // Define action to be taken when a packet is received via the declared analysis port
    virtual function void write (uart_seq_item uart_frame);
        // TODO: implement
    endfunction


    // Run Comparison Checks/Tasks
    virtual task run_phase(uvm_phase phase);
        // TODO: Implement
    endtask : run_phase


    // Perform any remaining comparisons or checks before end of simulation
    virtual function void check_phase (uvm_phase phase);
        super().check_phase(phase)
    endfunction

endclass

`endif // __UART_SCOREBOARD_SVH__