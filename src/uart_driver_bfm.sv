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
// Description: The UART Bus Functional Model - Driver
//==============================================================================


interface uart_driver_bfm
    ( uart_if uart );

    `include "uvm_macros.svh"
    import uvm_pkg::*;
    import uart_agent_pkg::*;

    //------------------------------------------
    // uart Interface Driving Methods
    //------------------------------------------

    // Initialize uart signals
    task uart_init;
        // TODO: Initialize signals
    endtask : uart_init


    // Drive a uart Command Item
    task drive(uart_seq_item uart_item);
        // TODO: Create the driver logic
    endtask : drive
endinterface: uart_driver_bfm
