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
// Description: The UART Bus Functional Model - Monitor
//==============================================================================


interface uart_monitor_bfm
    ( uart_if uart );

    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import uart_agent_pkg::*;

    //------------------------------------------
    // Members
    //------------------------------------------
    uart_monitor proxy;

    // Config
    uart_agent_config m_cfg;

    //------------------------------------------
    // Methods
    //------------------------------------------

    task run();
        // TODO: Implement moitor run task
    endtask: run

endinterface: uart_monitor_bfm
