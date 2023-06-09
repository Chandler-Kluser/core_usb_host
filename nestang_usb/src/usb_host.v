module usb_host(
    input sys_clk,
    input sys_resetn,
    output [1:0] led
);

wire clk;
reg [23:0] counter;

Gowin_rPLL pll (
    .clkout(clk),   // 48MHz clock for USB
    .clkin(sys_clk) // 27MHz clock
);

usbh_host #(48000000) usb_host_inst (
//     Inputs
    .clk_i(clk),
    .rst_i(sys_resetn),
    .cfg_awvalid_i(cfg_awvalid_i),
    .cfg_awaddr_i(cfg_awaddr_i),
    .cfg_wvalid_i(cfg_wvalid_i),
    .cfg_wdata_i(cfg_wdata_i),
    .cfg_wstrb_i(cfg_wstrb_i),
    .cfg_bready_i(cfg_bready_i),
    .cfg_arvalid_i(cfg_arvalid_i),
    .cfg_araddr_i(cfg_araddr_i),
    .cfg_rready_i(cfg_rready_i),
    .utmi_data_in_i(utmi_data_in_i),
    .utmi_txready_i(utmi_txready_i),
    .utmi_rxvalid_i(utmi_rxvalid_i),
    .utmi_rxactive_i(utmi_rxactive_i),
    .utmi_rxerror_i(utmi_rxerror_i),
    .utmi_linestate_i(utmi_linestate_i),

//     Outputs
    .cfg_awready_o(cfg_awready_o),
    .cfg_wready_o(cfg_wready_o),
    .cfg_bvalid_o(cfg_bvalid_o),
    .cfg_bresp_o(cfg_bresp_o),
    .cfg_arready_o(cfg_arready_o),
    .cfg_rvalid_o(cfg_rvalid_o),
    .cfg_rdata_o(cfg_rdata_o),
    .cfg_rresp_o(cfg_rresp_o),
    .intr_o(intr_o),
    .utmi_data_out_o(utmi_data_out_o),
    .utmi_txvalid_o(utmi_txvalid_o),
    .utmi_op_mode_o(utmi_op_mode_o),
    .utmi_xcvrselect_o(utmi_xcvrselect_o),
    .utmi_termselect_o(utmi_termselect_o),
    .utmi_dppulldown_o(utmi_dppulldown_o),
    .utmi_dmpulldown_o(utmi_dmpulldown_o)
  );


always @(posedge clk) begin
    counter <= counter + 1;
end

assign led[0] = counter[23];
assign led[1] = sys_resetn;

endmodule