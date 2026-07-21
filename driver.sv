`ifndef DRIVER_SV
`define DRIVER_SV

`include "transaction.sv"

class driver;

  // Virtual interface handle to connect to the DUT
  virtual ram_if vif;

  // Constructor: Receives the virtual interface from the environment
  function new(virtual ram_if vif);
    this.vif = vif;
  endfunction

  // Drive task: Takes a transaction and pushes the data to the DUT
  task drive(transaction tr);
    // Wait for the next positive edge of the clock
    @(posedge vif.clk);
    
    // Drive the transaction data onto the physical interface pins
    vif.we   <= tr.we;
    vif.addr <= tr.addr;
    vif.din  <= tr.data;
    
    // Optional display to track activity in the console
    $display("[Driver] Driven WE=%0d, ADDR=%0h, DATA=%0h", tr.we, tr.addr, tr.data);
  endtask

endclass

`endif
