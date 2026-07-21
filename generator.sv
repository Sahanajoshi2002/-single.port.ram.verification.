`ifndef GENERATOR_SV
`define GENERATOR_SV

`include "transaction.sv"

class generator;
  
  transaction tr;
  
  task run();
    repeat(10)
    begin
      tr = new();
      assert(tr.randomize());
      
      $display("--------------------------------");
      $display("Generated Transaction");
      $display("WE   = %0d", tr.we);
      $display("ADDR = %0d", tr.addr);
      $display("DATA = %0h", tr.data);
    end
  endtask
  
endclass

`endif
