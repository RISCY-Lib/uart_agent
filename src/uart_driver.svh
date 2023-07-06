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
// Description: The UART UVM Driver
//==============================================================================

`ifndef __UART_DRIVER_SVH__
`define __UART_DRIVER_SVH__

class uart_driver extends uvm_driver #(uart_seq_item);
    `uvm_component_utils(uart_driver)

    //------------------------------------------
    // Members
    //------------------------------------------

    // Virtual Interface
    local virtual uart_driver_bfm m_bfm;

    // Config
    uart_agent_config m_cfg;

    // Sequence Item
    uart_seq_item uart_item;

    // TODO: Any custom class members

    //------------------------------------------
    // Methods
    //------------------------------------------

    // Standard UVM Methods:
    function new(string name = "uart_driver", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        super.build_phase(phase);
        `get_config(uart_agent_config, m_cfg, "uart_agent_config")
        m_bfm = m_cfg.drv_bfm;
    endfunction : build_phase

    task run_phase(uvm_phase phase);

        // TODO: Implement driving

    endtask: run_phase
endclass: uart_driver

`endif // __UART_DRIVER_SVH__