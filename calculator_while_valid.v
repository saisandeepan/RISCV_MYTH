\m5_TLV_version 1d: tl-x.org
\m5
   
   // ============================================
   // Welcome, new visitors! Try the "Learn" menu.
   // ============================================
   
   //use(m5-1.0)   /// uncomment to use M5 macro library.
\SV
   // Macro providing required top-level module definition, random
   // stimulus support, and Verilator config.
   m5_makerchip_module   // (Expanded in Nav-TLV pane.)
\TLV
   $reset = *reset;
   
   |calc
      @1
         $val1[31:0] = $reset ? 32'b0 : >>2$output[31:0];
         $val2[31:0] = $rand2[3:0];
         $count[0:0] = $reset ? 1'b0 : !>>1$count;
         $valid[0:0] = $count;
         $valid_or_reset = $valid || $reset;
         
      ?$valid_or_reset   
         @1 
            $sum[31:0] = $val1 + $val2;
            $diff[31:0] = $val1 - $val2;
            $mul[31:0] = $val1 * $val2;
            $div[31:0] = $val1 / $val2;
         @2
            $output[31:0] = ($op[1:0] == 2'b00) ? $sum :
                            ($op[1:0] == 2'b01) ? $diff :
                            ($op[1:0] == 2'b10) ? $mul :
                                                  $div ;
   
   // Assert these to end simulation (before the cycle limit).
   *passed = *cyc_cnt > 40;
   *failed = 1'b0;
\SV
   endmodule
