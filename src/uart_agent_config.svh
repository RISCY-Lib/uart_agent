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
// Description: The agent configuration class for the UART UVM Agent
//==============================================================================

`ifndef __UART_AGENT_CONFIG_SVH__
`define __UART_AGENT_CONFIG_SVH__

class uart_agent_config extends uvm_object;

    localparam string s_my_config_id = "uart_agent_config";

    // UVM Factory Registration Macro
    `uvm_object_utils(uart_agent_config)

    //------------------------------------------
    // Members
    //------------------------------------------

    // BFM Virtual Interfaces
    virtual uart_monitor_bfm mon_bfm;
    virtual uart_driver_bfm  drv_bfm;

    // Baud Configuration
    int baud_rate = 115200;

    // Frame Configuration
    uart_parity_e parity = NONE;
    int           stop_bits = 1;

    // Is the agent active or passive
    uvm_active_passive_enum active = UVM_ACTIVE;
    bit has_functional_coverage = 0;

    //------------------------------------------
    // Methods
    //------------------------------------------

    function new(string name = "uart_agent_config");
        super.new(name);
    endfunction

    // Returns the global uart Agent Configuration
    static function uart_agent_config get_config( uvm_component c );
        uart_agent_config t;

        if (!uvm_config_db #(uart_agent_config)::get(c, "", s_my_config_id, t) )
            `uvm_fatal("CONFIG_LOAD", $sformatf("Cannot get() configuration %s from uvm_config_db. Have you set() it?", s_my_config_id))

        return t;
    endfunction

endclass: uart_agent_config

`endif // __UART_AGENT_CONFIG_SVH__