//------------------------------------------------------------------
// Simulator directives.
//------------------------------------------------------------------
`timescale 1ns/100ps

//------------------------------------------------------------------
// Test module.
//------------------------------------------------------------------
module tb_pcode();

//----------------------------------------------------------------
// Internal constant and parameter definitions.
//----------------------------------------------------------------
// Debug output control.
parameter DEBUG                  = 0;
parameter VCD                    = 1;
// Clock defines.
localparam CLK_HALF_PERIOD       = 1;
localparam CLK_PERIOD            = 2 * CLK_HALF_PERIOD;

localparam SAT_WIDTH = 6;
localparam SREG_WIDTH = 37;
localparam XREG_WIDTH = 12;
//localparam PREG_WIDTH = 32;

//----------------------------------------------------------------
// Register and Wire declarations.
//----------------------------------------------------------------
reg  [31 : 0] error_ctr;
reg  [31 : 0] tc_ctr;

reg                  tb_clk;
reg                  tb_rst;
reg                  tb_en;
reg [ SAT_WIDTH-1:0] tb_sat;
reg [XREG_WIDTH-1:0] tb_x1a;
reg [XREG_WIDTH-1:0] tb_x1b;
reg [XREG_WIDTH-1:0] tb_x2a;
reg [XREG_WIDTH-1:0] tb_x2b;
`ifdef PREG_WIDTH
wire [PREG_WIDTH-1:0]tb_preg;
`else
wire tb_preg;
`endif

//----------------------------------------------------------------
// Device Under Test.
//----------------------------------------------------------------
pcode dut(
    .clk(tb_clk),
    .rst(tb_rst),
    .en(tb_en),
    .sat(tb_sat),
    .ini_x1a(tb_x1a),
    .ini_x1b(tb_x1b),
    .ini_x2a(tb_x2a),
    .ini_x2b(tb_x2b),
    .preg(tb_preg)
);

//----------------------------------------------------------------
// clk_gen
//
// Always running clock generator process.
//----------------------------------------------------------------
always
begin : clk_gen
    #CLK_HALF_PERIOD;
    tb_clk = !tb_clk;
end // clk_gen

//----------------------------------------------------------------
// rst_dut()
//
// Toggle rst to put the DUT into a well known state.
//----------------------------------------------------------------
task rst_dut();
    begin
        $display("*** Toggle rst.");
        tb_rst = 1;

        #(2 * CLK_PERIOD);
        tb_rst = 0;
        $display("");
    end
endtask // rst_dut

//----------------------------------------------------------------
// init_sim()
//
// Initialize all counters and testbed functionality as well
// as setting the DUT inputs to defined values.
//----------------------------------------------------------------
task init_sim();
    begin
        tb_clk  = 0;
        tb_rst  = 0;
        tb_en   = 0;
        tb_sat  = 6'b000000;
        tb_x1a  = 12'h000;
        tb_x1b  = 12'h000;
        tb_x2a  = 12'h000;
        tb_x2b  = 12'h000;
    end
endtask // init_sim

//----------------------------------------------------------------
// timing_verification
//----------------------------------------------------------------
task timing_verification();
integer i;
begin

tb_x1a=001001001000;
tb_x1b=010101010100;
tb_x2a=100100100101;
tb_x2b=010101010100;

tb_rst=1;
        #(2*CLK_PERIOD);
tb_rst=0;

//for(i=0;i<500;i++)
        #(1000*CLK_PERIOD);
/*
tb_x1a=12'd4092;
tb_rst=1;
        #(CLK_PERIOD);
tb_rst=0;

        #(1000*CLK_PERIOD);

tb_x1b=12'd4093;
tb_rst=1;
        #(CLK_PERIOD);
tb_rst=0;

        #(1000*CLK_PERIOD);

tb_x2a=12'd4092;
tb_rst=1;
        #(CLK_PERIOD);
tb_rst=0;

        #(1000*CLK_PERIOD);

tb_x2b=12'd4093;
tb_rst=1;
        #(CLK_PERIOD);
tb_rst=0;
*/

        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);
        #(100000*CLK_PERIOD);


end
endtask // exp32bit_mod2048bit_test

//----------------------------------------------------------------
// main
//----------------------------------------------------------------
initial
begin : main
    if(VCD) begin
        $dumpfile("./iverilog/tb_pcode.vcd");
        $dumpvars(0,tb_pcode);
        //$dumpvars(1,tb_clk, tb_rst, tb_cs, tb_we, tb_address, tb_write_data, tb_read_data);
    end

    $display("   -= Testbench for pcode started =-");
    $display("    =================================");
    $display("");

    init_sim();
    rst_dut();

    timing_verification();
    
    $display("");
    $display("*** pcode simulation done. ***");
    $finish;
end // main
endmodule // tb_modexp

//======================================================================
// EOF tb_modexp.v
//======================================================================