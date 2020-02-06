`timescale	1ps / 1ps
////////////////////////////////////////////////////////////////////////////////
//
// Filename:	./main.v
//
// Project:	SDR, a basic Soft(Gate)ware Defined Radio architecture
//
// DO NOT EDIT THIS FILE!
// Computer Generated: This file is computer generated by AUTOFPGA. DO NOT EDIT.
// DO NOT EDIT THIS FILE!
//
// CmdLine:	autofpga autofpga -d -o . global.txt clock36.txt version.txt hexbus.txt gpio.txt amxmit.txt histogram.txt rfscope.txt samplerate.txt
//
// Creator:	Dan Gisselquist, Ph.D.
//		Gisselquist Technology, LLC
//
////////////////////////////////////////////////////////////////////////////////
//
// Copyright (C) 2019-2020, Gisselquist Technology, LLC
//
// This program is free software (firmware): you can redistribute it and/or
// modify it under the terms of the GNU General Public License as published
// by the Free Software Foundation, either version 3 of the License, or (at
// your option) any later version.
//
// This program is distributed in the hope that it will be useful, but WITHOUT
// ANY WARRANTY; without even the implied warranty of MERCHANTIBILITY or
// FITNESS FOR A PARTICULAR PURPOSE.  See the GNU General Public License
// for more details.
//
// You should have received a copy of the GNU General Public License along
// with this program.  (It's in the $(ROOT)/doc directory.  Run make with no
// target there if the PDF file isn't present.)  If not, see
// <http://www.gnu.org/licenses/> for a copy.
//
// License:	GPL, v3, as defined and found on www.gnu.org,
//		http://www.gnu.org/licenses/gpl.html
//
//
////////////////////////////////////////////////////////////////////////////////
//
//
`default_nettype	none
//
//
// Here is a list of defines which may be used, post auto-design
// (not post-build), to turn particular peripherals (and bus masters)
// on and off.  In particular, to turn off support for a particular
// design component, just comment out its respective `define below.
//
// These lines are taken from the respective @ACCESS tags for each of our
// components.  If a component doesn't have an @ACCESS tag, it will not
// be listed here.
//
// First, the independent access fields for any bus masters
`define	HEXBUS_MASTER
// And then for the independent peripherals
`define	RFSCOPE_ACCESS
`define	GPIO_ACCESS
//
// End of dependency list
//
//
//
// Any include files
//
// These are drawn from anything with a MAIN.INCLUDE definition.
//
//
// Finally, we define our main module itself.  We start with the list of
// I/O ports, or wires, passed into (or out of) the main function.
//
// These fields are copied verbatim from the respective I/O port lists,
// from the fields given by @MAIN.PORTLIST
//
module	main(i_clk, i_reset,
		// TRANSMITTER I/O ports
		o_rf_data, o_mic_csn, o_mic_sck, i_mic_miso,
 		// UART/host to wishbone interface
 		i_host_uart_rx, o_host_uart_tx,
		// GPIO ports
		i_gpio, o_gpio);
//
// Any parameter definitions
//
// These are drawn from anything with a MAIN.PARAM definition.
// As they aren't connected to the toplevel at all, it would
// be best to use localparam over parameter, but here we don't
// check
//
// The next step is to declare all of the various ports that were just
// listed above.  
//
// The following declarations are taken from the values of the various
// @MAIN.IODECL keys.
//
	input	wire		i_clk;
	// verilator lint_off UNUSED
	input	wire		i_reset;
	// verilator lint_on UNUSED
	output	wire	[1:0]	o_rf_data;
	output	wire		o_mic_csn, o_mic_sck;
	input	wire		i_mic_miso;
	input	wire		i_host_uart_rx;
	output	wire		o_host_uart_tx;
	localparam	NGPI = 6, NGPO=9;
	// GPIO ports
	input		[(NGPI-1):0]	i_gpio;
	output	wire	[(NGPO-1):0]	o_gpio;
	// Make Verilator happy ... defining bus wires for lots of components
	// often ends up with unused wires lying around.  We'll turn off
	// Ver1lator's lint warning here that checks for unused wires.
	// verilator lint_off UNUSED



	//
	// Declaring interrupt lines
	//
	// These declarations come from the various components values
	// given under the @INT.<interrupt name>.WIRE key.
	//
	wire	gpio_int;	// gpio.INT.GPIO.WIRE


	//
	// Component declarations
	//
	// These declarations come from the @MAIN.DEFNS keys found in the
	// various components comprising the design.
	//
// Looking for string: MAIN.DEFNS
	reg	[31:0]	r_samplerate_counter, r_samplerate_counts,
			r_samplerate_result;

	// Remove this scope tag via inheritance when/if you connect the
	// scope interrupt
	//
	// Virilator lint_off UNUSED
	wire	rfscope_int;
	// Virilator lint_on  UNUSED
	wire		rfdbg_ce;
	wire	[31:0]	rfdbg_data;
	wire	[9:0]	rfdbg_hist;
	wire	[1:0]	rfdbg_sel;
	//
	//
	// UART interface
	//
	//
	localparam  BUSUARTBITS = $clog2(24'h24);
	localparam [23:0] BUSUART = 24'h24;	// 1000000 baud
	//
	wire		w_ck_uart, w_uart_tx;
	wire		rx_host_stb;
	wire	[7:0]	rx_host_data;
	wire		tx_host_stb;
	wire	[7:0]	tx_host_data;
	wire		tx_host_busy;
	//
`include "builddate.v"
	wire	hist_int;
// BUILDTIME doesnt need to include builddate.v a second time
// `include "builddate.v"
	wire		audio_en, rf_en;
	// wire	[1:0]	rfdbg_sel;


	//
	// Declaring interrupt vector wires
	//
	// These declarations come from the various components having
	// PIC and PIC.MAX keys.
	//
	//
	//
	// Define bus wires
	//
	//

	// Bus wb
	// Wishbone definitions for bus wb, component hex
	// Verilator lint_off UNUSED
	wire		wb_hex_cyc, wb_hex_stb, wb_hex_we;
	wire	[10:0]	wb_hex_addr;
	wire	[31:0]	wb_hex_data;
	wire	[3:0]	wb_hex_sel;
	wire		wb_hex_stall, wb_hex_ack, wb_hex_err;
	wire	[31:0]	wb_hex_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb(SIO), component buildtime
	// Verilator lint_off UNUSED
	wire		wb_buildtime_cyc, wb_buildtime_stb, wb_buildtime_we;
	wire	[10:0]	wb_buildtime_addr;
	wire	[31:0]	wb_buildtime_data;
	wire	[3:0]	wb_buildtime_sel;
	wire		wb_buildtime_stall, wb_buildtime_ack, wb_buildtime_err;
	wire	[31:0]	wb_buildtime_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb(SIO), component gpio
	// Verilator lint_off UNUSED
	wire		wb_gpio_cyc, wb_gpio_stb, wb_gpio_we;
	wire	[10:0]	wb_gpio_addr;
	wire	[31:0]	wb_gpio_data;
	wire	[3:0]	wb_gpio_sel;
	wire		wb_gpio_stall, wb_gpio_ack, wb_gpio_err;
	wire	[31:0]	wb_gpio_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb(SIO), component samplerate
	// Verilator lint_off UNUSED
	wire		wb_samplerate_cyc, wb_samplerate_stb, wb_samplerate_we;
	wire	[10:0]	wb_samplerate_addr;
	wire	[31:0]	wb_samplerate_data;
	wire	[3:0]	wb_samplerate_sel;
	wire		wb_samplerate_stall, wb_samplerate_ack, wb_samplerate_err;
	wire	[31:0]	wb_samplerate_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb(SIO), component version
	// Verilator lint_off UNUSED
	wire		wb_version_cyc, wb_version_stb, wb_version_we;
	wire	[10:0]	wb_version_addr;
	wire	[31:0]	wb_version_data;
	wire	[3:0]	wb_version_sel;
	wire		wb_version_stall, wb_version_ack, wb_version_err;
	wire	[31:0]	wb_version_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb, component rfscope
	// Verilator lint_off UNUSED
	wire		wb_rfscope_cyc, wb_rfscope_stb, wb_rfscope_we;
	wire	[10:0]	wb_rfscope_addr;
	wire	[31:0]	wb_rfscope_data;
	wire	[3:0]	wb_rfscope_sel;
	wire		wb_rfscope_stall, wb_rfscope_ack, wb_rfscope_err;
	wire	[31:0]	wb_rfscope_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb, component amtx
	// Verilator lint_off UNUSED
	wire		wb_amtx_cyc, wb_amtx_stb, wb_amtx_we;
	wire	[10:0]	wb_amtx_addr;
	wire	[31:0]	wb_amtx_data;
	wire	[3:0]	wb_amtx_sel;
	wire		wb_amtx_stall, wb_amtx_ack, wb_amtx_err;
	wire	[31:0]	wb_amtx_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb, component wb_sio
	// Verilator lint_off UNUSED
	wire		wb_sio_cyc, wb_sio_stb, wb_sio_we;
	wire	[10:0]	wb_sio_addr;
	wire	[31:0]	wb_sio_data;
	wire	[3:0]	wb_sio_sel;
	wire		wb_sio_stall, wb_sio_ack, wb_sio_err;
	wire	[31:0]	wb_sio_idata;
	// Verilator lint_on UNUSED
	// Wishbone definitions for bus wb, component hist
	// Verilator lint_off UNUSED
	wire		wb_hist_cyc, wb_hist_stb, wb_hist_we;
	wire	[10:0]	wb_hist_addr;
	wire	[31:0]	wb_hist_data;
	wire	[3:0]	wb_hist_sel;
	wire		wb_hist_stall, wb_hist_ack, wb_hist_err;
	wire	[31:0]	wb_hist_idata;
	// Verilator lint_on UNUSED

	//
	// Peripheral address decoding
	//
	//
	// BUS-LOGIC for wb
	//
	//
	// wb Bus logic to handle SINGLE slaves
	//
	reg		r_wb_sio_ack;
	reg	[31:0]	r_wb_sio_data;

	assign	wb_sio_stall = 1'b0;

	initial r_wb_sio_ack = 1'b0;
	always	@(posedge i_clk)
		r_wb_sio_ack <= (wb_sio_stb);
	assign	wb_sio_ack = r_wb_sio_ack;

	always	@(posedge i_clk)
	casez( wb_sio_addr[1:0] )
	2'h0: r_wb_sio_data <= wb_buildtime_idata;
	2'h1: r_wb_sio_data <= wb_gpio_idata;
	2'h2: r_wb_sio_data <= wb_samplerate_idata;
	2'h3: r_wb_sio_data <= wb_version_idata;
	endcase
	assign	wb_sio_idata = r_wb_sio_data;


	//
	// Now to translate this logic to the various SIO slaves
	//
	// In this case, the SIO bus has the prefix wb_sio
	// and all of the slaves have various wires beginning
	// with their own respective bus prefixes.
	// Our goal here is to make certain that all of
	// the slave bus inputs match the SIO bus wires
	assign	wb_buildtime_cyc = wb_sio_cyc;
	assign	wb_buildtime_stb = wb_sio_stb && (wb_sio_addr[ 1: 0] ==  2'h0);  // 0x000
	assign	wb_buildtime_we  = wb_sio_we;
	assign	wb_buildtime_data= wb_sio_data;
	assign	wb_buildtime_sel = wb_sio_sel;
	assign	wb_gpio_cyc = wb_sio_cyc;
	assign	wb_gpio_stb = wb_sio_stb && (wb_sio_addr[ 1: 0] ==  2'h1);  // 0x004
	assign	wb_gpio_we  = wb_sio_we;
	assign	wb_gpio_data= wb_sio_data;
	assign	wb_gpio_sel = wb_sio_sel;
	assign	wb_samplerate_cyc = wb_sio_cyc;
	assign	wb_samplerate_stb = wb_sio_stb && (wb_sio_addr[ 1: 0] ==  2'h2);  // 0x008
	assign	wb_samplerate_we  = wb_sio_we;
	assign	wb_samplerate_data= wb_sio_data;
	assign	wb_samplerate_sel = wb_sio_sel;
	assign	wb_version_cyc = wb_sio_cyc;
	assign	wb_version_stb = wb_sio_stb && (wb_sio_addr[ 1: 0] ==  2'h3);  // 0x00c
	assign	wb_version_we  = wb_sio_we;
	assign	wb_version_data= wb_sio_data;
	assign	wb_version_sel = wb_sio_sel;
	//
	// No class DOUBLE peripherals on the "wb" bus
	//

	assign	wb_rfscope_err= 1'b0;
	assign	wb_amtx_err= 1'b0;
	assign	wb_sio_err= 1'b0;
	assign	wb_hist_err= 1'b0;
	//
	// Connect the wb bus components together using the wbxbar()
	//
	//
	wbxbar #(
		.NM(1), .NS(4), .AW(11), .DW(32),
		.SLAVE_ADDR({
			{ 11'h400 }, //    hist: 0x1000
			{ 11'h300 }, //  wb_sio: 0x0c00
			{ 11'h200 }, //    amtx: 0x0800
			{ 11'h100 }  // rfscope: 0x0400
		}),
		.SLAVE_MASK({
			{ 11'h400 }, //    hist
			{ 11'h700 }, //  wb_sio
			{ 11'h700 }, //    amtx
			{ 11'h700 }  // rfscope
		}),
		.OPT_DBLBUFFER(1'b1))
	wb_xbar(
		.i_clk(i_clk), .i_reset(i_reset),
		.i_mcyc({
			wb_hex_cyc
		}),
		.i_mstb({
			wb_hex_stb
		}),
		.i_mwe({
			wb_hex_we
		}),
		.i_maddr({
			wb_hex_addr
		}),
		.i_mdata({
			wb_hex_data
		}),
		.i_msel({
			wb_hex_sel
		}),
		.o_mstall({
			wb_hex_stall
		}),
		.o_mack({
			wb_hex_ack
		}),
		.o_mdata({
			wb_hex_idata
		}),
		.o_merr({
			wb_hex_err
		}),
		// Slave connections
		.o_scyc({
			wb_hist_cyc,
			wb_sio_cyc,
			wb_amtx_cyc,
			wb_rfscope_cyc
		}),
		.o_sstb({
			wb_hist_stb,
			wb_sio_stb,
			wb_amtx_stb,
			wb_rfscope_stb
		}),
		.o_swe({
			wb_hist_we,
			wb_sio_we,
			wb_amtx_we,
			wb_rfscope_we
		}),
		.o_saddr({
			wb_hist_addr,
			wb_sio_addr,
			wb_amtx_addr,
			wb_rfscope_addr
		}),
		.o_sdata({
			wb_hist_data,
			wb_sio_data,
			wb_amtx_data,
			wb_rfscope_data
		}),
		.o_ssel({
			wb_hist_sel,
			wb_sio_sel,
			wb_amtx_sel,
			wb_rfscope_sel
		}),
		.i_sstall({
			wb_hist_stall,
			wb_sio_stall,
			wb_amtx_stall,
			wb_rfscope_stall
		}),
		.i_sack({
			wb_hist_ack,
			wb_sio_ack,
			wb_amtx_ack,
			wb_rfscope_ack
		}),
		.i_sdata({
			wb_hist_idata,
			wb_sio_idata,
			wb_amtx_idata,
			wb_rfscope_idata
		}),
		.i_serr({
			wb_hist_err,
			wb_sio_err,
			wb_amtx_err,
			wb_rfscope_err
		})
		);

	//
	// Declare the interrupt busses
	//
	// Interrupt busses are defined by anything with a @PIC tag.
	// The @PIC.BUS tag defines the name of the wire bus below,
	// while the @PIC.MAX tag determines the size of the bus width.
	//
	// For your peripheral to be assigned to this bus, it must have an
	// @INT.NAME.WIRE= tag to define the wire name of the interrupt line,
	// and an @INT.NAME.PIC= tag matching the @PIC.BUS tag of the bus
	// your interrupt will be assigned to.  If an @INT.NAME.ID tag also
	// exists, then your interrupt will be assigned to the position given
	// by the ID# in that tag.
	//


	//
	//
	// Now we turn to defining all of the parts and pieces of what
	// each of the various peripherals does, and what logic it needs.
	//
	// This information comes from the @MAIN.INSERT and @MAIN.ALT tags.
	// If an @ACCESS tag is available, an ifdef is created to handle
	// having the access and not.  If the @ACCESS tag is `defined above
	// then the @MAIN.INSERT code is executed.  If not, the @MAIN.ALT
	// code is exeucted, together with any other cleanup settings that
	// might need to take place--such as returning zeros to the bus,
	// or making sure all of the various interrupt wires are set to
	// zero if the component is not included.
	//
	initial	r_samplerate_counter = 0;
	initial	r_samplerate_counts  = 0;
	initial	r_samplerate_result  = 0;
	always @(posedge  i_clk)
	if (i_reset)
	begin
		r_samplerate_counter <= 0;
		r_samplerate_counts  <= 0;
		r_samplerate_result  <= 0;
	end else if (r_samplerate_counter < 36000000-2)
	begin
		r_samplerate_counter <= r_samplerate_counter + 1;
		if (rfdbg_ce)
			r_samplerate_counts <= r_samplerate_counts + 1;
	end else begin
		r_samplerate_counter <= 0;
		r_samplerate_counts  <= 0;
		r_samplerate_result  <= r_samplerate_counts + (rfdbg_ce ? 1:0);
	end

	assign wb_samplerate_stall = 1'b0;
	assign wb_samplerate_ack   = wb_samplerate_stb;
	assign wb_samplerate_idata = r_samplerate_result;
`ifdef	RFSCOPE_ACCESS
	wbscope #(.LGMEM(8),
		.SYNCHRONOUS(1))
	rfscopei(i_clk, rfdbg_ce, 1'b1, rfdbg_data,
		i_clk, wb_rfscope_cyc, wb_rfscope_stb, wb_rfscope_we,
			wb_rfscope_addr[1-1:0],
			wb_rfscope_data, // 32 bits wide
			wb_rfscope_sel,  // 32/8 bits wide
		wb_rfscope_stall, wb_rfscope_ack, wb_rfscope_idata,
		rfscope_int);
`else	// RFSCOPE_ACCESS
	assign	rfscope_int = 0;

	//
	// In the case that there is no wb_rfscope peripheral
	// responding on the wb bus
	assign	wb_rfscope_ack   = 1'b0;
	assign	wb_rfscope_err   = (wb_rfscope_stb);
	assign	wb_rfscope_stall = 0;
	assign	wb_rfscope_idata = 0;

`endif	// RFSCOPE_ACCESS

	//
	// Transmit logic
	//
	amxmit
	amxmiti(i_clk, i_reset, audio_en, rf_en,
		wb_amtx_cyc, wb_amtx_stb, wb_amtx_we,
			wb_amtx_addr[2-1:0],
			wb_amtx_data, // 32 bits wide
			wb_amtx_sel,  // 32/8 bits wide
		wb_amtx_stall, wb_amtx_ack, wb_amtx_idata,
		o_mic_csn, o_mic_sck, i_mic_miso,
		o_rf_data,
		rfdbg_sel, rfdbg_ce, rfdbg_data, rfdbg_hist);

`ifdef	HEXBUS_MASTER
	// The Host USB interface, to be used by the WB-UART bus
	rxuartlite	#(.TIMING_BITS(BUSUARTBITS[4:0]),
				.CLOCKS_PER_BAUD(BUSUART[BUSUARTBITS-1:0]))
	rcv(i_clk, i_host_uart_rx, rx_host_stb, rx_host_data);
	txuartlite	#(.TIMING_BITS(BUSUARTBITS[4:0]),
				.CLOCKS_PER_BAUD(BUSUART[BUSUARTBITS-1:0]))
	txv(i_clk, tx_host_stb, tx_host_data, o_host_uart_tx, tx_host_busy);

	hbbus #(.AW(11))
	genbus(i_clk,
		rx_host_stb, rx_host_data,
		wb_hex_cyc, wb_hex_stb, wb_hex_we,
			wb_hex_addr[11-1:0],
			wb_hex_data, // 32 bits wide
			wb_hex_sel,  // 32/8 bits wide
		wb_hex_stall, wb_hex_ack, wb_hex_idata,wb_hex_err,
		1'b0,	// No interrupts defined
		tx_host_stb, tx_host_data, tx_host_busy);
`else	// HEXBUS_MASTER
`endif	// HEXBUS_MASTER

	assign	wb_version_idata = `DATESTAMP;
	assign	wb_version_ack = wb_version_stb;
	assign	wb_version_stall = 1'b0;
	//
	// Histogram
	//
	histogram #(.AW(10),.NAVGS(16383))
	histi(i_clk, i_reset,
		wb_hist_cyc, wb_hist_stb, wb_hist_we,
			wb_hist_addr[10-1:0],
			wb_hist_data, // 32 bits wide
			wb_hist_sel,  // 32/8 bits wide
		wb_hist_stall, wb_hist_ack, wb_hist_idata,
		rfdbg_ce, rfdbg_hist,
		hist_int);
	assign	wb_buildtime_idata = `BUILDTIME;
	assign	wb_buildtime_ack = wb_buildtime_stb;
	assign	wb_buildtime_stall = 1'b0;
`ifdef	GPIO_ACCESS
	//
	// GPIO
	//
	// This interface should allow us to control up to 16 GPIO inputs,
	// and another 16 GPIO outputs.  The interrupt trips when any of
	// the inputs changes.  (Sorry, which input isn't (yet) selectable.)
	//
	localparam	INITIAL_GPIO = 9'h37;
	wbgpio	#(NGPI, NGPO, INITIAL_GPIO)
		gpioi(i_clk, wb_gpio_cyc, wb_gpio_stb, wb_gpio_we,
			wb_gpio_data, // 32 bits wide
			wb_gpio_sel,  // 32/8 bits wide
		wb_gpio_stall, wb_gpio_ack, wb_gpio_idata,
			i_gpio, o_gpio, gpio_int);

	assign	rf_en     = o_gpio[4];
	assign	audio_en  = o_gpio[5];
	assign	rfdbg_sel = o_gpio[7:6];
`else	// GPIO_ACCESS
	assign	gpio_int = 1'b0;	// gpio.INT.GPIO.WIRE
`endif	// GPIO_ACCESS



endmodule // main.v
