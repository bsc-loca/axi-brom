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
 reg [MEM_DATA_WIDTH-1:0] boot_ram [0 : BRAM_LINE-1];
 reg [BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET] ram_addr_dly;

 always_ff @(posedge clka)
   if(ena) begin
      ram_addr_dly <= addra[BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET];
      foreach (wea[i])
        if(wea[i]) boot_ram[addra[BRAM_ADDR_WIDTH-1:BRAM_LINE_OFFSET]][i*8 +:8] <= dina[i*8 +: 8];
   end

 assign douta = boot_ram[ram_addr_dly];

 initial $readmemh("bootrom.mem", boot_ram);


endmodule // fpga_top