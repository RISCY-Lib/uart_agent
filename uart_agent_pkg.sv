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
// Description: The Package for the UVM UART Agent
//==============================================================================


package uart_agent_pkg;

    import uvm_pkg::*;
    `include "uvm_macros.svh"
    `include "config_macro.svh"

    `include "src/uart_defines.svh"

    `include "src/uart_seq_item.svh"
    `include "src/uart_agent_config.svh"
    `include "src/uart_driver.svh"
    `include "src/uart_monitor.svh"
    typedef uvm_sequencer #(uart_seq_item) uart_sequencer;
    `include "src/uart_agent.svh"

endpackage: uart_agent_pkg
