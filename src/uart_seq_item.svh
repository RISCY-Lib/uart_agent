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
// Description: The uart UVM Sequence Item Class
//==============================================================================

`ifndef __UART_SEQ_ITEM_SVH__
`define __UART_SEQ_ITEM_SVH__

class uart_seq_item extends uvm_sequence_item;
    `uvm_object_utils(uart_seq_item)

    //----------------------------------------------
    // Data Members (Outputs rand, inputs non-rand)
    //----------------------------------------------

    rand logic [7:0]   data;
    rand uart_dir_e    dir;
         logic         parity_correct;

    //------------------------------------------
    // Methods
    //------------------------------------------

    // Standard UVM Methods:
    function new(string name = "uart_seq_item");
        super.new(name);
    endfunction

    function void do_copy(uvm_object rhs);
        uart_seq_item to_copy;

        if(!$cast(to_copy, rhs)) begin
            `uvm_fatal("do_copy", "cast of rhs object failed")
        end
        super.do_copy(rhs);

        this.data      = to_copy.data;
        this.dir       = to_copy.dir;

    endfunction:do_copy

    function bit do_compare(uvm_object rhs, uvm_comparer comparer);
        uart_seq_item to_copy;

        if(!$cast(to_copy, rhs)) begin
            `uvm_error("do_copy", "cast of rhs object failed")
            return 0;
        end
        return super.do_compare(rhs, comparer) &&
            to_copy.data           === this.data           &&
            to_copy.dir            ==  this.dir            &&
            to_copy.parity_correct === this.parity_correct;
    endfunction

    function string convert2string();
        string s;

        $sformat(s, "uart_seq_item- data: 0x%02X", this.data);

        if (this.dir == RX) $sformat(s, "%s, dir: RX", s);
        else                $sformat(s, "%s, dir: TX", s);

        $sformat(s, "%s, Parity Correct: %0b", s, this.parity_correct);

        return s;
    endfunction:convert2string

    function void do_print(uvm_printer printer);
        printer.m_string = convert2string();
    endfunction:do_print

    function void do_record(uvm_recorder recorder);
        super.do_record(recorder);
    endfunction:do_record

endclass: uart_seq_item

`endif // __UART_SEQ_ITEM_SVH__