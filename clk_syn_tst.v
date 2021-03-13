// Code your design here
`timescale 1ns/1ns
module clk_syn_tst (
                rst_n,
                clka, 
                clkb, 
                sel_clkb, 
                clk_o
                   );
input rst_n;
input clka;
input clkb;
input sel_clkb;

output clk_o;

reg    sel_clka_d0;
reg    sel_clka_d1;
reg    sel_clka_dly1;
reg    sel_clka_dly2 ;
reg    sel_clka_dly3;
reg    sel_clkb_d0;
reg    sel_clkb_d1;
reg    sel_clkb_dly1;
reg    sel_clkb_dly2;
reg    sel_clkb_dly3;

always @ (posedge clka or negedge rst_n)
begin
    if (!rst_n) 
    begin
        sel_clka_d0 <= 1'b0;
        sel_clka_d1 <= 1'b0;

     end
     else 
     begin
        sel_clka_d0 <= (~sel_clkb) & (~sel_clkb_dly3) ;
        sel_clka_d1 <= sel_clka_d0 ;
     end
 end

// part2
//always @ (posedge clka_n or negedge rst_n)
always @ (negedge clka or negedge rst_n)
begin
    if (!rst_n) 
    begin
     sel_clka_dly1 <= 1'b0;
     sel_clka_dly2 <= 1'b0;
     sel_clka_dly3 <= 1'b0;
    end
    else 
    begin
    sel_clka_dly1 <= sel_clka_d1;
    sel_clka_dly2 <= sel_clka_dly1 ;
    sel_clka_dly3 <= sel_clka_dly2 ;
    end
end
// part3
//always @ (posedge clkb_n or negedge rst_n)
always @ (posedge clkb or negedge rst_n)
begin
   if (!rst_n) 
   begin
   sel_clkb_d0 <= 1'b1;
   sel_clkb_d1 <= 1'b1;
   end
   else 
   begin
   sel_clkb_d0 <= sel_clkb & (~sel_clka_dly3) ;
   sel_clkb_d1 <= sel_clkb_d0 ;
   end
end

// part4
//always @ (posedge clkb_n or negedge rst_n)
always @ (negedge clkb or negedge rst_n)
begin
   if (!rst_n) 
   begin
      sel_clkb_dly1 <= 1'b1;
      sel_clkb_dly2 <= 1'b1;
      sel_clkb_dly3 <= 1'b1;
   end
else 
begin
sel_clkb_dly1 <= sel_clkb_d1;
sel_clkb_dly2 <= sel_clkb_dly1 ;
sel_clkb_dly3 <= sel_clkb_dly2 ;
end
end

// part5
//clk_gate_xxx clk_gate_a ( .CP(clka), .EN(sel_clka_dly3), .Q(clka_g),  .TE(1'b0)   );
//clk_gate_xxx clk_gate_b ( .CP(clkb), .EN(sel_clkb_dly3), .Q(clkb_g),  .TE(1'b0)   );
assign clka_g = clka & sel_clka_dly3 ;
assign clkb_g = clkb & sel_clkb_dly3 ;
assign clk_o = clka_g | clkb_g ;

endmodule
