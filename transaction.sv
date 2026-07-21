`ifndef TRANSACTION_SV
`define TRANSACTION_SV
class transaction;

rand bit we;
rand bit [3:0] addr;
rand bit [7:0] data;

bit [7:0] rdata;

endclass

`endif 