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
    uart_seq_item rx_item;
    uart_seq_item tx_item;

    //------------------------------------------
    // Methods
    //------------------------------------------

    task run();
        rx_item = uart_seq_item::type_id::create("rx_item");
        tx_item = uart_seq_item::type_id::create("tx_item");
        fork
            run_rx_monitor();
            run_tx_monitor();
        join
    endtask: run

    task run_rx_monitor();
        uart_seq_item cloned_item;
        realtime baud_period;

        forever begin
            rx_item.dir = RX;

            // Wait for start bit, then get mid-bit
            @(negedge uart.rx);
            baud_period = rate2period(proxy.m_cfg.baud_rate);

            #(baud_period / 2);

            // Get all of the data bits
            for (int idx = 0; idx < 8; idx++) begin
                #(baud_period);
                rx_item.data[idx] = uart.rx;
            end

            // Check if the parity bit if present
            if (proxy.m_cfg.parity != NONE) begin
                #(baud_period);
                if (proxy.m_cfg.parity == ODD) begin
                    rx_item.parity_correct = (uart.rx === ~^rx_item.data);
                end
                else begin
                    rx_item.parity_correct = (uart.rx === ^rx_item.data);
                end
            end
            else begin
                rx_item.parity_correct = 1'b1;
            end

            // Wait for the stop bits
            repeat(proxy.m_cfg.stop_bits) begin
                #(baud_period);
                assert (uart.rx === 1'b1) else
                    `uvm_error("UART_MON_BFM", "UART Transaction stop-bit not high");
            end

            // Wait for the end of the final stop bit
            #(baud_period / 2);

            // Clone and Publish
            $cast(cloned_item, rx_item.clone());
            proxy.notify_transaction(cloned_item);

        end
    endtask

    task run_tx_monitor();
        uart_seq_item cloned_item;
        realtime baud_period;

        forever begin
            tx_item.dir = TX;

            // Wait for start bit, then get mid-bit
            @(negedge uart.tx);
            baud_period = rate2period(proxy.m_cfg.baud_rate);

            #(baud_period / 2);

            // Get all of the data bits
            for (int idx = 0; idx < 8; idx++) begin
                #(baud_period);
                tx_item.data[idx] = uart.tx;
            end

            // Check if the parity bit if present
            if (proxy.m_cfg.parity != NONE) begin
                #(baud_period);
                if (proxy.m_cfg.parity == ODD) begin
                    tx_item.parity_correct = (uart.tx === ~^tx_item.data);
                end
                else begin
                    tx_item.parity_correct = (uart.tx === ^tx_item.data);
                end
            end
            else begin
                tx_item.parity_correct = 1'b1;
            end

            // Wait for the stop bits
            repeat(proxy.m_cfg.stop_bits) begin
                #(baud_period);
                assert (uart.tx === 1'b1) else
                    `uvm_error("UART_MON_BFM", "UART Transaction stop-bit not high");
            end

            // Wait for the end of the final stop bit
            #(baud_period / 2);

            // Clone and Publish
            $cast(cloned_item, tx_item.clone());
            proxy.notify_transaction(cloned_item);

        end

    endtask

endinterface: uart_monitor_bfm
