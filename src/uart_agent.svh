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
// Description: The UVM UART Agent
//==============================================================================

`ifndef __UART_AGENT_SVH__
`define __UART_AGENT_SVH__

class uart_agent extends uvm_agent;
    `uvm_component_utils(uart_agent)

    //------------------------------------------
    // Members
    //------------------------------------------
    uart_agent_config m_cfg;

    uvm_analysis_port #(uart_seq_item) ap;
    uart_monitor   m_monitor;
    uart_sequencer m_sequencer;
    uart_driver    m_driver;

    //------------------------------------------
    // Methods
    //------------------------------------------

    // Standard UVM Methods:
    function new(string name = "uart_agent", uvm_component parent = null);
        super.new(name, parent);
    endfunction

    function void build_phase(uvm_phase phase);
        `get_config(uart_agent_config, m_cfg, "uart_agent_config")
        // Monitor is always present
        m_monitor = uart_monitor::type_id::create("m_monitor", this);
        m_monitor.m_cfg = m_cfg;

        // Only build the driver and sequencer if active
        if(m_cfg.active == UVM_ACTIVE) begin
            m_driver = uart_driver::type_id::create("m_driver", this);
            m_driver.m_cfg = m_cfg;
            m_sequencer = uart_sequencer::type_id::create("m_sequencer", this);
        end
    endfunction: build_phase

    function void connect_phase(uvm_phase phase);
        ap = m_monitor.ap;

        // Only connect the driver and the sequencer if active
        if(m_cfg.active == UVM_ACTIVE) begin
            m_driver.seq_item_port.connect(m_sequencer.seq_item_export);
        end
    endfunction: connect_phase
endclass: uart_agent

`endif // __UART_AGENT_SVH__