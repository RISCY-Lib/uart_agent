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
    // Members
    //------------------------------------------
    // Config
    uart_agent_config m_cfg;

    //------------------------------------------
    // uart Interface Driving Methods
    //------------------------------------------

    // Initialize uart signals
    task uart_init;
        uart.rx = 1'b1;
    endtask : uart_init


    // Drive a uart Command Item
    task drive(uart_seq_item uart_item);
        realtime baud_period;

        baud_period = rate2period(m_cfg.baud_rate);

        // Only drive rx packets
        if (uart_item.dir == TX) begin
            `uvm_warning("UART_DRV_BFM", "Can't drive UART Item with TX Direction")
            return;
        end

        // Start bit
        uart.rx <= 1'b0;
        #(baud_period);

        // Transmit each bit
        for (int idx = 0; idx < 8; idx++) begin
            uart.rx <= uart_item.data[idx];
            #(baud_period);
        end

        // Handle parity bit
        if (m_cfg.parity == ODD) begin
            uart.rx = ~^uart_item.data;
            #(baud_period);
        end
        else if (m_cfg.parity == EVEN) begin
            uart.rx = ^uart_item.data;
            #(baud_period);
        end

        // Handle the stop bits
        repeat (m_cfg.stop_bits) begin
            uart.rx <= 1'b1;
            #(baud_period);
        end

    endtask : drive
endinterface: uart_driver_bfm
