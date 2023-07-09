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
// Description: The Defines for the UVM UART Agent
//==============================================================================

`ifndef __UART_DEFINES_SVH__
`define __UART_DEFINES_SVH__

  typedef enum {
    RX,
    TX
  } uart_dir_e;

  typedef enum {
    NONE,
    ODD,
    EVEN
  } uart_parity_e;

  function realtime rate2period(int baud);
    rate2period = 1s/baud;
  endfunction

`endif // __UART_DEFINES_SVH__