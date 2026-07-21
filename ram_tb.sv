`include "ram_if.sv"
`include "transaction.sv"
`include "generator.sv"
`include "driver.sv"
`include "monitor.sv"
`include "scoreboard.sv"
`include "environment.sv"

module ram_tb;

    ram_if vif();

    ram dut(
        .clk(vif.clk),
        .we(vif.we),
        .addr(vif.addr),
        .din(vif.din),
        .dout(vif.dout)
    );

    environment env;

    // Clock generation
    always #5 vif.clk = ~vif.clk;

    initial begin
        vif.clk = 0;

        env = new(vif);

        env.run();

        #100;
        $finish;
    end

endmodule