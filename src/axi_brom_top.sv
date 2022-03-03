// Copyright 2022 Barcelona Supercomputing Center-Centro Nacional de Supercomputación

// Licensed under the Apache License, Version 2.0 (the "License");
// you may not use this file except in compliance with the License.
// You may obtain a copy of the License at
// 
//     http://www.apache.org/licenses/LICENSE-2.0
// 
// Unless required by applicable law or agreed to in writing, software
// distributed under the License is distributed on an "AS IS" BASIS,
// WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
// See the License for the specific language governing permissions and
// limitations under the License.

// Author: Daniel J.Mazure, BSC-CNS
// Date: 22.02.2022
// Description: 


module axi_brom (
         
 input  [15:0] addra ,
 input  clka         ,
 input  [127:0] dina ,
 output [127:0] douta,
 input  ena          ,
 input  [15:0] wea   
);



// channel for BRAM and DRAM
localparam MEM_DATA_WIDTH = 128;
localparam BRAM_ADDR_WIDTH = 16;     // 64 KB
localparam BRAM_LINE = 2 ** BRAM_ADDR_WIDTH  * 8 / MEM_DATA_WIDTH;
localparam BRAM_LINE_OFFSET = $clog2(MEM_DATA_WIDTH/8); 
  
 
 // the inferred BRAMs
 reg [MEM_DATA_WIDTH-1:0] ram [0 : BRAM_LINE-1];
 reg [BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET] ram_addr_dly;

 always_ff @(posedge clka)
   if(ena) begin
      ram_addr_dly <= addra[BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET];
      foreach (wea[i])
        if(wea[i]) ram[addra[BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET]][i*8 +:8] <= dina[i*8 +: 8];
   end

 assign douta = ram[ram_addr_dly];

 initial $readmemh("initrom.mem", ram);


endmodule // fpga_top