module ram(
    input  logic clk,
    input  logic we,
    input  logic [3:0] addr,
    input  logic [7:0] din,
    output logic [7:0] dout
);

logic [7:0] mem [0:15];

always_ff @(posedge clk) begin
    if (we)
        mem[addr] <= din;
    else
        dout <= mem[addr];
end

endmodule