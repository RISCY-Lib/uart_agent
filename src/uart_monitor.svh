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
// Description: The UART UVM Monitor
//==============================================================================

`ifndef __UART_MONITOR_SVH__
`define __UART_MONITOR_SVH__

class uart_monitor extends uvm_component;
    `uvm_component_utils(uart_monitor)

    // Virtual Interface
    local virtual uart_monitor_bfm m_bfm;

    //------------------------------------------
    // Data Members
    //------------------------------------------
    uart_agent_config m_cfg;

    //------------------------------------------
    // Component Members
    //------------------------------------------
    uvm_analysis_port #(uart_seq_item) ap;

    //------------------------------------------
    // Methods
    //------------------------------------------

    // Standard UVM Methods:

    function new(string name = "uart_monitor", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `get_config(uart_agent_config, m_cfg, "uart_agent_config")
        m_bfm = m_cfg.mon_bfm;
        m_bfm.proxy = this;

        ap = new("ap", this);
    endfunction: build_phase

    task run_phase(uvm_phase phase);
        m_bfm.run();
    endtask: run_phase

    function void report_phase(uvm_phase phase);
        // Might be a good place to do some reporting on no of analysis transactions sent etc
    endfunction: report_phase

    // Proxy Methods:
    function void notify_transaction(uart_seq_item item);
        ap.write(item);
    endfunction : notify_transaction

endclass: uart_monitor

`endif // __UART_MONITOR_SVH__