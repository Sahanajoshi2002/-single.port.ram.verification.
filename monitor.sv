`ifndef MONITOR_SV
`define MONITOR_SV

`include "transaction.sv"

class monitor;
  
  virtual ram_if vif;
  mailbox #(transaction) mon2scb;

  function new(virtual ram_if vif, mailbox #(transaction) mon2scb);
    this.vif = vif;
    this.mon2scb = mon2scb;
  endfunction

  task run();
    transaction tr;
    forever begin
      @(posedge vif.clk);
      
      // Wait a tiny bit after the clock edge to sample stable signals
      #1; 
      
      tr = new();
      tr.we   = vif.we;
      tr.addr = vif.addr;
      tr.data = (vif.we) ? vif.din : vif.dout; // If write, sample din. If read, sample dout.
      
      // Send the transaction to the scoreboard
      mon2scb.put(tr);
    end
  endtask
  
endclass

`endif
