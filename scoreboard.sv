`ifndef SCOREBOARD_SV
`define SCOREBOARD_SV

`include "transaction.sv"

class scoreboard;
  
  // Mailbox to receive transactions from the monitor
  mailbox #(transaction) mon2scb;

  // THIS IS THE REFERENCE MODEL: A perfect, fake memory array
  bit [7:0] ref_mem [int];

  // Variables to keep the score
  int pass_count = 0;
  int fail_count = 0;

  // Constructor
  function new(mailbox #(transaction) mon2scb);
    this.mon2scb = mon2scb;
  endfunction

  // Main task to process transactions
  task run();
    transaction tr;
    
    forever begin
      // Wait for a transaction to arrive from the monitor
      mon2scb.get(tr);

      if (tr.we == 1) begin
        // WRITE: Update our reference model
        ref_mem[tr.addr] = tr.data;
        $display("[Scoreboard] WRITE: ADDR = %0d, DATA = %0h written to Reference Model", tr.addr, tr.data);
      end 
      else begin
        // READ: Compare the DUT's output with our Reference Model
        if (ref_mem.exists(tr.addr)) begin
          if (tr.data == ref_mem[tr.addr]) begin
            $display("[Scoreboard] PASS! ADDR = %0d | Expected: %0h, Actual: %0h", tr.addr, ref_mem[tr.addr], tr.data);
            pass_count++;
          end else begin
            $display("[Scoreboard] FAIL! ADDR = %0d | Expected: %0h, Actual: %0h", tr.addr, ref_mem[tr.addr], tr.data);
            fail_count++;
          end
        end else begin
          $display("[Scoreboard] WARNING: Read from uninitialized ADDR = %0d", tr.addr);
        end
      end
    end
  endtask
  
  // Task to print the final score at the end of the simulation
  function void print_score();
    $display("--------------------------------");
    $display("FINAL SCORE");
    $display("Passes: %0d", pass_count);
    $display("Fails:  %0d", fail_count);
    $display("--------------------------------");
  endfunction

endclass

`endif