--Copyright 1986-2020 Xilinx, Inc. All Rights Reserved.
----------------------------------------------------------------------------------
--Tool Version: Vivado v.2020.1 (win64) Build 2902540 Wed May 27 19:54:49 MDT 2020
--Date        : Tue Dec 29 21:13:26 2020
--Host        : DanielPC running 64-bit major release  (build 9200)
--Command     : generate_target uart_test_wrapper.bd
--Design      : uart_test_wrapper
--Purpose     : IP block netlist
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.all;
library UNISIM;
use UNISIM.VCOMPONENTS.all;
use ieee.std_logic_misc.all;


entity axi_brom is
  port (
    ACLK : IN STD_LOGIC;
    ARESETN : IN STD_LOGIC;
    S_AXI_AWADDR : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    S_AXI_AWLEN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    S_AXI_AWSIZE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_AWBURST : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_AWLOCK : IN STD_LOGIC;
    S_AXI_AWCACHE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_AWPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_AWVALID : IN STD_LOGIC;
    S_AXI_AWREADY : OUT STD_LOGIC;
    S_AXI_WDATA : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    S_AXI_WSTRB : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    S_AXI_WLAST : IN STD_LOGIC;
    S_AXI_WVALID : IN STD_LOGIC;
    S_AXI_WREADY : OUT STD_LOGIC;
    S_AXI_BRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_BVALID : OUT STD_LOGIC;
    S_AXI_BREADY : IN STD_LOGIC;
    S_AXI_ARADDR : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    S_AXI_ARLEN : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    S_AXI_ARSIZE : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_ARBURST : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_ARLOCK : IN STD_LOGIC;
    S_AXI_ARCACHE : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    S_AXI_ARPROT : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    S_AXI_ARVALID : IN STD_LOGIC;
    S_AXI_ARREADY : OUT STD_LOGIC;
    S_AXI_RDATA : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    S_AXI_RRESP : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    S_AXI_RLAST : OUT STD_LOGIC;
    S_AXI_RVALID : OUT STD_LOGIC;
    S_AXI_RREADY : IN STD_LOGIC
    );
end axi_brom;

architecture behavioral of axi_brom is

COMPONENT axi_bram
  PORT (
    s_axi_aclk : IN STD_LOGIC;
    s_axi_aresetn : IN STD_LOGIC;
    s_axi_awaddr : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    s_axi_awlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axi_awsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_awlock : IN STD_LOGIC;
    s_axi_awcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_awprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_awvalid : IN STD_LOGIC;
    s_axi_awready : OUT STD_LOGIC;
    s_axi_wdata : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axi_wstrb : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    s_axi_wlast : IN STD_LOGIC;
    s_axi_wvalid : IN STD_LOGIC;
    s_axi_wready : OUT STD_LOGIC;
    s_axi_bresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_bvalid : OUT STD_LOGIC;
    s_axi_bready : IN STD_LOGIC;
    s_axi_araddr : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    s_axi_arlen : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
    s_axi_arsize : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arburst : IN STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_arlock : IN STD_LOGIC;
    s_axi_arcache : IN STD_LOGIC_VECTOR(3 DOWNTO 0);
    s_axi_arprot : IN STD_LOGIC_VECTOR(2 DOWNTO 0);
    s_axi_arvalid : IN STD_LOGIC;
    s_axi_arready : OUT STD_LOGIC;
    s_axi_rdata : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    s_axi_rresp : OUT STD_LOGIC_VECTOR(1 DOWNTO 0);
    s_axi_rlast : OUT STD_LOGIC;
    s_axi_rvalid : OUT STD_LOGIC;
    s_axi_rready : IN STD_LOGIC;
    bram_rst_a : OUT STD_LOGIC;
    bram_clk_a : OUT STD_LOGIC;
    bram_en_a : OUT STD_LOGIC;
    bram_we_a : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    bram_addr_a : OUT STD_LOGIC_VECTOR(19 DOWNTO 0);
    bram_wrdata_a : OUT STD_LOGIC_VECTOR(127 DOWNTO 0);
    bram_rddata_a : IN STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;


COMPONENT blockrom
  PORT (
    clka  : IN STD_LOGIC;
    ena   : IN STD_LOGIC;
    wea   : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
    addra : IN STD_LOGIC_VECTOR(19 DOWNTO 0);
    dina  : IN STD_LOGIC_VECTOR(127 DOWNTO 0);
    douta : OUT STD_LOGIC_VECTOR(127 DOWNTO 0)
  );
END COMPONENT;

  signal  bram_rst_a    : STD_LOGIC;
  signal  bram_clk_a    : STD_LOGIC;
  signal  bram_en_a     : STD_LOGIC;
  signal  bram_we_a     : STD_LOGIC_VECTOR(15 DOWNTO 0);
  signal  bram_addr_a   : STD_LOGIC_VECTOR(19 DOWNTO 0);
  signal  bram_wrdata_a : STD_LOGIC_VECTOR(127 DOWNTO 0);
  signal  bram_rddata_a : STD_LOGIC_VECTOR(127 DOWNTO 0);
    
begin

inst_bram_ctrl: axi_bram
  PORT MAP (
    s_axi_aclk => ACLK,
    s_axi_aresetn => ARESETN,
    s_axi_awaddr => S_AXI_AWADDR,
    s_axi_awlen => S_AXI_AWLEN,
    s_axi_awsize => S_AXI_AWSIZE,
    s_axi_awburst => S_AXI_AWBURST,
    s_axi_awlock => S_AXI_AWLOCK,
    s_axi_awcache => S_AXI_AWCACHE,
    s_axi_awprot => S_AXI_AWPROT,
    s_axi_awvalid => S_AXI_AWVALID,
    s_axi_awready => S_AXI_AWREADY,
    s_axi_wdata => S_AXI_WDATA,
    s_axi_wstrb => S_AXI_WSTRB,
    s_axi_wlast => S_AXI_WLAST,
    s_axi_wvalid => S_AXI_WVALID,
    s_axi_wready => S_AXI_WREADY,
    s_axi_bresp => S_AXI_BRESP,
    s_axi_bvalid => S_AXI_BVALID,
    s_axi_bready => S_AXI_BREADY,
    s_axi_araddr => S_AXI_ARADDR,
    s_axi_arlen => S_AXI_ARLEN,
    s_axi_arsize => S_AXI_ARSIZE,
    s_axi_arburst => S_AXI_ARBURST,
    s_axi_arlock => S_AXI_ARLOCK,
    s_axi_arcache => S_AXI_ARCACHE,
    s_axi_arprot => S_AXI_ARPROT,
    s_axi_arvalid => S_AXI_ARVALID,
    s_axi_arready => S_AXI_ARREADY,
    s_axi_rdata => S_AXI_RDATA,
    s_axi_rresp => S_AXI_RRESP,
    s_axi_rlast => S_AXI_RLAST,
    s_axi_rvalid => S_AXI_RVALID,
    s_axi_rready => S_AXI_RREADY,
    bram_rst_a => bram_rst_a,
    bram_clk_a => bram_clk_a,
    bram_en_a => bram_en_a,
    bram_we_a => bram_we_a,
    bram_addr_a => bram_addr_a,
    bram_wrdata_a => bram_wrdata_a,
    bram_rddata_a => bram_rddata_a
  );
    
  inst_bram_rom : blockrom
  PORT MAP (
    clka  => bram_clk_a,
    ena   => bram_en_a,
    wea   => bram_we_a,
    addra => bram_addr_a,
    dina  => bram_wrdata_a,
    douta => bram_rddata_a
  );
 


end behavioral;
