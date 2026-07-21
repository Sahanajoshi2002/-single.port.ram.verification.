`ifndef ENVIRONMENT_SV
`define ENVIRONMENT_SV

`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"

class environment;

  generator  gen;
  driver     drv;
  monitor    mon;
  scoreboard scb;
  
  // The mailbox connecting monitor and scoreboard
  mailbox #(transaction) mon2scb;
  
  virtual ram_if vif;

  function new(virtual ram_if vif);
    this.vif = vif;
    mon2scb = new(); // Create the mailbox
    
    // Instantiate all components
    gen = new();
    drv = new(vif);
    mon = new(vif, mon2scb);
    scb = new(mon2scb);
  endfunction

  task run();
    // Fork runs all these tasks at the exact same time in parallel
    fork
      // Since generator isn't hooked to a mailbox yet, we loop it manually here for now
      begin
        transaction tr;
        repeat(10) begin
          tr = new();
          if (!tr.randomize()) $display("Randomization failed!");
          drv.drive(tr);
        end
      end
      mon.run();
      scb.run();
    join_any // Wait until the 10 transactions are finished
     disable fork;
    
    // Print the final score before finishing
    scb.print_score();
  endtask

endclass

`endif