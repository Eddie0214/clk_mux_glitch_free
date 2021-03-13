// Code your testbench here
// or browse Examples
`timescale 1ns/1ns
module clk_syn_tb;

parameter DLY=1;

reg rst_n;
reg clka;
reg clkb;
reg sel_clkb;

wire clk_o;
clk_syn_tst test1(
                       //input
                       .rst_n           (rst_n), //system reset
                       .clka            (clka), //clock A
                       .clkb            (clkb), //clock B
                       .sel_clkb        (sel_clkb),//pulse input from clka
                       // output 
                       .clk_o           (clk_o)//pulse output in clkb
                  );
initial
begin
  $dumpfile("dump.vcd");
  $dumpvars (0, clk_syn_tb);

rst_n=0;
clka=0;
clkb=0;
sel_clkb=0;
#20 rst_n =1;
#500 sel_clkb=1;
#500 sel_clkb=0;
  #1000 $finish;
end

always #5 clka<=~clka;

always #20 clkb<=~clkb;

//always @(posedge clka or negedge rst_n)
//begin
//if(rst_n==1'b0)
//puls_a_in<=0;
//else
//puls_a_in<=# DLY $random %2;
//end

endmodule
