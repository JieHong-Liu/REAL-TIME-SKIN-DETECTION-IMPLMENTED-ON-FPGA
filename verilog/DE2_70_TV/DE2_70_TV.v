// --------------------------------------------------------------------
// Copyright (c) 2007 by Terasic Technologies Inc. 
// --------------------------------------------------------------------
//
// Permission:
//
//   Terasic grants permission to use and modify this code for use
//   in synthesis for all Terasic Development Boards and Altera Development 
//   Kits made by Terasic.  Other use of this code, including the selling 
//   ,duplication, or modification of any portion is strictly prohibited.
//
// Disclaimer:
//
//   This VHDL/Verilog or C/C++ source code is intended as a design reference
//   which illustrates how these types of functions can be implemented.
//   It is the user's responsibility to verify their design for
//   consistency and functionality through the use of formal
//   verification methods.  Terasic provides no warranty regarding the use 
//   or functionality of this code.
//
// --------------------------------------------------------------------
//           
//                     Terasic Technologies Inc
//                     356 Fu-Shin E. Rd Sec. 1. JhuBei City,
//                     HsinChu County, Taiwan
//                     302
//
//                     web: http://www.terasic.com/
//                     email: support@terasic.com
//
// --------------------------------------------------------------------
//
// Major Functions:	DE2_70 TV Box 
//
// --------------------------------------------------------------------
//
// Revision History :
// --------------------------------------------------------------------
//   Ver  :| Author            :| Mod. Date :| Changes Made:
//   V1.0 :| Johnny FAN        :| 07/07/09  :| Initial Revision
// --------------------------------------------------------------------

module DE2_70_TV
	(
		////////////////////	Clock Input	 	////////////////////	 
		iCLK_28,						//  28.63636 MHz
		iCLK_50,						//	50 MHz
		iCLK_50_2,						//	50 MHz
		iCLK_50_3,						//	50 MHz
		iCLK_50_4,						//	50 MHz
		iEXT_CLOCK,						//	External Clock
		/////////////// /////	Push Button		////////////////////
		iKEY,							//	Pushbutton[3:0]
		////////////////////	DPDT Switch		////////////////////
		iSW,							//	Toggle Switch[17:0]
		////////////////////	7-SEG Dispaly	////////////////////
		oHEX0_D,						//	Seven Segment Digit 0
		oHEX0_DP,						//  Seven Segment Digit 0 decimal point
		oHEX1_D,						//	Seven Segment Digit 1
		oHEX1_DP,						//  Seven Segment Digit 1 decimal point
		oHEX2_D,						//	Seven Segment Digit 2
		oHEX2_DP,						//  Seven Segment Digit 2 decimal point
		oHEX3_D,						//	Seven Segment Digit 3
		oHEX3_DP,						//  Seven Segment Digit 3 decimal point
		oHEX4_D,						//	Seven Segment Digit 4
		oHEX4_DP,						//  Seven Segment Digit 4 decimal point
		oHEX5_D,						//	Seven Segment Digit 5
		oHEX5_DP,						//  Seven Segment Digit 5 decimal point
		oHEX6_D,						//	Seven Segment Digit 6
		oHEX6_DP,						//  Seven Segment Digit 6 decimal point
		oHEX7_D,						//	Seven Segment Digit 7
		oHEX7_DP,						//  Seven Segment Digit 7 decimal point
		////////////////////////	LED		////////////////////////
		oLEDG,							//	LED Green[8:0]
		oLEDR,							//	LED Red[17:0]
		////////////////////////	UART	////////////////////////
		oUART_TXD,						//	UART Transmitter
		iUART_RXD,						//	UART Receiver
		oUART_CTS,          			//	UART Clear To Send
		iUART_RTS,          			//	UART Requst To Send
		////////////////////////	IRDA	////////////////////////
		oIRDA_TXD,						//	IRDA Transmitter
		iIRDA_RXD,						//	IRDA Receiver
		/////////////////////	SDRAM Interface		////////////////
		DRAM_DQ,						//	SDRAM Data bus 32 Bits
		oDRAM0_A,						//	SDRAM0 Address bus 13 Bits
		oDRAM1_A,						//	SDRAM1 Address bus 13 Bits
		oDRAM0_LDQM0,					//	SDRAM0 Low-byte Data Mask 
		oDRAM1_LDQM0,					//	SDRAM1 Low-byte Data Mask 
		oDRAM0_UDQM1,					//	SDRAM0 High-byte Data Mask
		oDRAM1_UDQM1,					//	SDRAM1 High-byte Data Mask
		oDRAM0_WE_N,					//	SDRAM0 Write Enable
		oDRAM1_WE_N,					//	SDRAM1 Write Enable
		oDRAM0_CAS_N,					//	SDRAM0 Column Address Strobe
		oDRAM1_CAS_N,					//	SDRAM1 Column Address Strobe
		oDRAM0_RAS_N,					//	SDRAM0 Row Address Strobe
		oDRAM1_RAS_N,					//	SDRAM1 Row Address Strobe
		oDRAM0_CS_N,					//	SDRAM0 Chip Select
		oDRAM1_CS_N,					//	SDRAM1 Chip Select
		oDRAM0_BA,						//	SDRAM0 Bank Address
		oDRAM1_BA,	 					//	SDRAM1 Bank Address
		oDRAM0_CLK,						//	SDRAM0 Clock
		oDRAM1_CLK,						//	SDRAM1 Clock
		oDRAM0_CKE,						//	SDRAM0 Clock Enable
		oDRAM1_CKE,						//	SDRAM1 Clock Enable
		////////////////////	Flash Interface		////////////////
		FLASH_DQ,						//	FLASH Data bus 15 Bits (0 to 14)
		FLASH_DQ15_AM1,					//  FLASH Data bus Bit 15 or Address A-1
		oFLASH_A,						//	FLASH Address bus 26 Bits
		oFLASH_WE_N,					//	FLASH Write Enable
		oFLASH_RST_N,					//	FLASH Reset
		oFLASH_WP_N,					//	FLASH Write Protect /Programming Acceleration 
		iFLASH_RY_N,					//	FLASH Ready/Busy output 
		oFLASH_BYTE_N,					//	FLASH Byte/Word Mode Configuration
		oFLASH_OE_N,					//	FLASH Output Enable
		oFLASH_CE_N,					//	FLASH Chip Enable
		////////////////////	SRAM Interface		////////////////
		SRAM_DQ,						//	SRAM Data Bus 32 Bits
		SRAM_DPA, 						//  SRAM Parity Data Bus
		oSRAM_A,						//	SRAM Address bus 22 Bits
		oSRAM_ADSC_N,       			//	SRAM Controller Address Status 	
		oSRAM_ADSP_N,                   //	SRAM Processor Address Status
		oSRAM_ADV_N,                    //	SRAM Burst Address Advance
		oSRAM_BE_N,                     //	SRAM Byte Write Enable
		oSRAM_CE1_N,        			//	SRAM Chip Enable
		oSRAM_CE2,          			//	SRAM Chip Enable
		oSRAM_CE3_N,        			//	SRAM Chip Enable
		oSRAM_CLK,                      //	SRAM Clock
		oSRAM_GW_N,         			//  SRAM Global Write Enable
		oSRAM_OE_N,         			//	SRAM Output Enable
		oSRAM_WE_N,         			//	SRAM Write Enable
		////////////////////	ISP1362 Interface	////////////////
		OTG_D,							//	ISP1362 Data bus 16 Bits
		oOTG_A,							//	ISP1362 Address 2 Bits
		oOTG_CS_N,						//	ISP1362 Chip Select
		oOTG_OE_N,						//	ISP1362 Read
		oOTG_WE_N,						//	ISP1362 Write
		oOTG_RESET_N,					//	ISP1362 Reset
		OTG_FSPEED,						//	USB Full Speed,	0 = Enable, Z = Disable
		OTG_LSPEED,						//	USB Low Speed, 	0 = Enable, Z = Disable
		iOTG_INT0,						//	ISP1362 Interrupt 0
		iOTG_INT1,						//	ISP1362 Interrupt 1
		iOTG_DREQ0,						//	ISP1362 DMA Request 0
		iOTG_DREQ1,						//	ISP1362 DMA Request 1
		oOTG_DACK0_N,					//	ISP1362 DMA Acknowledge 0
		oOTG_DACK1_N,					//	ISP1362 DMA Acknowledge 1
		////////////////////	LCD Module 16X2		////////////////
		oLCD_ON,						//	LCD Power ON/OFF
		oLCD_BLON,						//	LCD Back Light ON/OFF
		oLCD_RW,						//	LCD Read/Write Select, 0 = Write, 1 = Read
		oLCD_EN,						//	LCD Enable
		oLCD_RS,						//	LCD Command/Data Select, 0 = Command, 1 = Data
		LCD_D,						//	LCD Data bus 8 bits
		////////////////////	SD_Card Interface	////////////////
		SD_DAT,							//	SD Card Data
		SD_DAT3,						//	SD Card Data 3
		SD_CMD,							//	SD Card Command Signal
		oSD_CLK,						//	SD Card Clock
		////////////////////	I2C		////////////////////////////
		I2C_SDAT,						//	I2C Data
		oI2C_SCLK,						//	I2C Clock
		////////////////////	PS2		////////////////////////////
		PS2_KBDAT,						//	PS2 Keyboard Data
		PS2_KBCLK,						//	PS2 Keyboard Clock		
		PS2_MSDAT,						//	PS2 Mouse Data
		PS2_MSCLK,						//	PS2 Mouse Clock
		////////////////////	VGA		////////////////////////////
		oVGA_CLOCK,   					//	VGA Clock
		oVGA_HS,						//	VGA H_SYNC
		oVGA_VS,						//	VGA V_SYNC
		oVGA_BLANK_N,					//	VGA BLANK
		oVGA_SYNC_N,					//	VGA SYNC
		oVGA_R,   						//	VGA Red[9:0]
		oVGA_G,	 						//	VGA Green[9:0]
		oVGA_B,  						//	VGA Blue[9:0]
		////////////	Ethernet Interface	////////////////////////
		ENET_D,						//	DM9000A DATA bus 16Bits
		oENET_CMD,						//	DM9000A Command/Data Select, 0 = Command, 1 = Data
		oENET_CS_N,						//	DM9000A Chip Select
		oENET_IOW_N,					//	DM9000A Write
		oENET_IOR_N,					//	DM9000A Read
		oENET_RESET_N,					//	DM9000A Reset
		iENET_INT,						//	DM9000A Interrupt
		oENET_CLK,						//	DM9000A Clock 25 MHz
		////////////////	Audio CODEC		////////////////////////
		AUD_ADCLRCK,					//	Audio CODEC ADC LR Clock
		iAUD_ADCDAT,					//	Audio CODEC ADC Data
		AUD_DACLRCK,					//	Audio CODEC DAC LR Clock
		oAUD_DACDAT,					//	Audio CODEC DAC Data
		AUD_BCLK,						//	Audio CODEC Bit-Stream Clock
		oAUD_XCK,						//	Audio CODEC Chip Clock
		////////////////	TV Decoder		////////////////////////
		iTD1_CLK27,						//	TV Decoder1 Line_Lock Output Clock 
		iTD1_D,    					    //	TV Decoder1 Data bus 8 bits
		iTD1_HS,						//	TV Decoder1 H_SYNC
		iTD1_VS,						//	TV Decoder1 V_SYNC
		oTD1_RESET_N,					//	TV Decoder1 Reset
		iTD2_CLK27,						//	TV Decoder2 Line_Lock Output Clock 		
		iTD2_D,    					    //	TV Decoder2 Data bus 8 bits
		iTD2_HS,						//	TV Decoder2 H_SYNC
		iTD2_VS,						//	TV Decoder2 V_SYNC
		oTD2_RESET_N,					//	TV Decoder2 Reset
		////////////////////	GPIO	////////////////////////////
		GPIO_0,							//	GPIO Connection 0 I/O
		GPIO_CLKIN_N0,     				//	GPIO Connection 0 Clock Input 0
		GPIO_CLKIN_P0,          		//	GPIO Connection 0 Clock Input 1
		GPIO_CLKOUT_N0,     			//	GPIO Connection 0 Clock Output 0
		GPIO_CLKOUT_P0,                 //	GPIO Connection 0 Clock Output 1
		GPIO_1,							//	GPIO Connection 1 I/O
		GPIO_CLKIN_N1,                  //	GPIO Connection 1 Clock Input 0
		GPIO_CLKIN_P1,                  //	GPIO Connection 1 Clock Input 1
		GPIO_CLKOUT_N1,                 //	GPIO Connection 1 Clock Output 0
		GPIO_CLKOUT_P1                  //	GPIO Connection 1 Clock Output 1
	);

//===========================================================================
// PARAMETER declarations
//===========================================================================


//===========================================================================
// PORT declarations
//===========================================================================
////////////////////////	Clock Input	 	////////////////////////
input			iCLK_28;				//  28.63636 MHz
input			iCLK_50;				//	50 MHz
input			iCLK_50_2;				//	50 MHz
input           iCLK_50_3;				//	50 MHz
input           iCLK_50_4;				//	50 MHz
input           iEXT_CLOCK;				//	External Clock
////////////////////////	Push Button		////////////////////////
input	[3:0]	iKEY;					//	Pushbutton[3:0]
////////////////////////	DPDT Switch		////////////////////////
input	[17:0]	iSW;					//	Toggle Switch[17:0]
////////////////////////	7-SEG Dispaly	////////////////////////
output	[6:0]	oHEX0_D;				//	Seven Segment Digit 0
output			oHEX0_DP;				//  Seven Segment Digit 0 decimal point
output	[6:0]	oHEX1_D;				//	Seven Segment Digit 1
output			oHEX1_DP;				//  Seven Segment Digit 1 decimal point
output	[6:0]	oHEX2_D;				//	Seven Segment Digit 2
output			oHEX2_DP;				//  Seven Segment Digit 2 decimal point
output	[6:0]	oHEX3_D;				//	Seven Segment Digit 3
output			oHEX3_DP;				//  Seven Segment Digit 3 decimal point
output	[6:0]	oHEX4_D;				//	Seven Segment Digit 4
output			oHEX4_DP;				//  Seven Segment Digit 4 decimal point
output	[6:0]	oHEX5_D;				//	Seven Segment Digit 5
output			oHEX5_DP;				//  Seven Segment Digit 5 decimal point
output	[6:0]	oHEX6_D;				//	Seven Segment Digit 6
output			oHEX6_DP;				//  Seven Segment Digit 6 decimal point
output	[6:0]	oHEX7_D;				//	Seven Segment Digit 7
output			oHEX7_DP;				//  Seven Segment Digit 7 decimal point
////////////////////////////	LED		////////////////////////////
output	[8:0]	oLEDG;					//	LED Green[8:0]
output	[17:0]	oLEDR;					//	LED Red[17:0]
////////////////////////////	UART	////////////////////////////
output			oUART_TXD;				//	UART Transmitter
input			iUART_RXD;				//	UART Receiver
output			oUART_CTS;          	//	UART Clear To Send
input			iUART_RTS;          	//	UART Requst To Send
////////////////////////////	IRDA	////////////////////////////
output			oIRDA_TXD;				//	IRDA Transmitter
input			iIRDA_RXD;				//	IRDA Receiver
///////////////////////		SDRAM Interface	////////////////////////
inout	[31:0]	DRAM_DQ;				//	SDRAM Data bus 32 Bits
output	[12:0]	oDRAM0_A;				//	SDRAM0 Address bus 13 Bits
output	[12:0]	oDRAM1_A;				//	SDRAM1 Address bus 13 Bits
output			oDRAM0_LDQM0;			//	SDRAM0 Low-byte Data Mask 
output			oDRAM1_LDQM0;			//	SDRAM1 Low-byte Data Mask 
output			oDRAM0_UDQM1;			//	SDRAM0 High-byte Data Mask
output			oDRAM1_UDQM1;			//	SDRAM1 High-byte Data Mask
output			oDRAM0_WE_N;			//	SDRAM0 Write Enable
output			oDRAM1_WE_N;			//	SDRAM1 Write Enable
output			oDRAM0_CAS_N;			//	SDRAM0 Column Address Strobe
output			oDRAM1_CAS_N;			//	SDRAM1 Column Address Strobe
output			oDRAM0_RAS_N;			//	SDRAM0 Row Address Strobe
output			oDRAM1_RAS_N;			//	SDRAM1 Row Address Strobe
output			oDRAM0_CS_N;			//	SDRAM0 Chip Select
output			oDRAM1_CS_N;			//	SDRAM1 Chip Select
output	[1:0]	oDRAM0_BA;				//	SDRAM0 Bank Address
output	[1:0]	oDRAM1_BA;		 		//	SDRAM1 Bank Address
output			oDRAM0_CLK;				//	SDRAM0 Clock
output			oDRAM1_CLK;				//	SDRAM1 Clock
output			oDRAM0_CKE;				//	SDRAM0 Clock Enable
output			oDRAM1_CKE;				//	SDRAM1 Clock Enable
////////////////////////	Flash Interface	////////////////////////
inout	[14:0]	FLASH_DQ;				//	FLASH Data bus 15 Bits (0 to 14)
inout			FLASH_DQ15_AM1;			//  FLASH Data bus Bit 15 or Address A-1
output	[21:0]	oFLASH_A;				//	FLASH Address bus 22 Bits
output			oFLASH_WE_N;			//	FLASH Write Enable
output			oFLASH_RST_N;			//	FLASH Reset
output			oFLASH_WP_N;			//	FLASH Write Protect /Programming Acceleration 
input			iFLASH_RY_N;			//	FLASH Ready/Busy output 
output			oFLASH_BYTE_N;			//	FLASH Byte/Word Mode Configuration
output			oFLASH_OE_N;			//	FLASH Output Enable
output			oFLASH_CE_N;			//	FLASH Chip Enable
////////////////////////	SRAM Interface	////////////////////////
inout	[31:0]	SRAM_DQ;				//	SRAM Data Bus 32 Bits
inout	[3:0]	SRAM_DPA; 				//  SRAM Parity Data Bus
output	[18:0]	oSRAM_A;				//	SRAM Address bus 21 Bits
output			oSRAM_ADSC_N;       	//	SRAM Controller Address Status 	
output			oSRAM_ADSP_N;           //	SRAM Processor Address Status
output			oSRAM_ADV_N;            //	SRAM Burst Address Advance
output	[3:0]	oSRAM_BE_N;             //	SRAM Byte Write Enable
output			oSRAM_CE1_N;        	//	SRAM Chip Enable
output			oSRAM_CE2;          	//	SRAM Chip Enable
output			oSRAM_CE3_N;        	//	SRAM Chip Enable
output			oSRAM_CLK;              //	SRAM Clock
output			oSRAM_GW_N;         	//  SRAM Global Write Enable
output			oSRAM_OE_N;         	//	SRAM Output Enable
output			oSRAM_WE_N;         	//	SRAM Write Enable
////////////////////	ISP1362 Interface	////////////////////////
inout	[15:0]	OTG_D;					//	ISP1362 Data bus 16 Bits
output	[1:0]	oOTG_A;					//	ISP1362 Address 2 Bits
output			oOTG_CS_N;				//	ISP1362 Chip Select
output			oOTG_OE_N;				//	ISP1362 Read
output			oOTG_WE_N;				//	ISP1362 Write
output			oOTG_RESET_N;			//	ISP1362 Reset
inout			OTG_FSPEED;				//	USB Full Speed,	0 = Enable, Z = Disable
inout			OTG_LSPEED;				//	USB Low Speed, 	0 = Enable, Z = Disable
input			iOTG_INT0;				//	ISP1362 Interrupt 0
input			iOTG_INT1;				//	ISP1362 Interrupt 1
input			iOTG_DREQ0;				//	ISP1362 DMA Request 0
input			iOTG_DREQ1;				//	ISP1362 DMA Request 1
output			oOTG_DACK0_N;			//	ISP1362 DMA Acknowledge 0
output			oOTG_DACK1_N;			//	ISP1362 DMA Acknowledge 1
////////////////////	LCD Module 16X2	////////////////////////////
inout	[7:0]	LCD_D;					//	LCD Data bus 8 bits
output			oLCD_ON;				//	LCD Power ON/OFF
output			oLCD_BLON;				//	LCD Back Light ON/OFF
output			oLCD_RW;				//	LCD Read/Write Select, 0 = Write, 1 = Read
output			oLCD_EN;				//	LCD Enable
output			oLCD_RS;				//	LCD Command/Data Select, 0 = Command, 1 = Data
////////////////////	SD Card Interface	////////////////////////
inout			SD_DAT;					//	SD Card Data
inout			SD_DAT3;				//	SD Card Data 3
inout			SD_CMD;					//	SD Card Command Signal
output			oSD_CLK;				//	SD Card Clock
////////////////////////	I2C		////////////////////////////////
inout			I2C_SDAT;				//	I2C Data
output			oI2C_SCLK;				//	I2C Clock
////////////////////////	PS2		////////////////////////////////
inout		 	PS2_KBDAT;				//	PS2 Keyboard Data
inout			PS2_KBCLK;				//	PS2 Keyboard Clock
inout		 	PS2_MSDAT;				//	PS2 Mouse Data
inout			PS2_MSCLK;				//	PS2 Mouse Clock
////////////////////////	VGA			////////////////////////////
output			oVGA_CLOCK;   			//	VGA Clock
output			oVGA_HS;				//	VGA H_SYNC
output			oVGA_VS;				//	VGA V_SYNC
output			oVGA_BLANK_N;			//	VGA BLANK
output			oVGA_SYNC_N;			//	VGA SYNC
output	[9:0]	oVGA_R;   				//	VGA Red[9:0]
output	[9:0]	oVGA_G;	 				//	VGA Green[9:0]
output	[9:0]	oVGA_B;   				//	VGA Blue[9:0]
////////////////	Ethernet Interface	////////////////////////////
inout	[15:0]	ENET_D;					//	DM9000A DATA bus 16Bits
output			oENET_CMD;				//	DM9000A Command/Data Select, 0 = Command, 1 = Data
output			oENET_CS_N;				//	DM9000A Chip Select
output			oENET_IOW_N;			//	DM9000A Write
output			oENET_IOR_N;			//	DM9000A Read
output			oENET_RESET_N;			//	DM9000A Reset
input			iENET_INT;				//	DM9000A Interrupt
output			oENET_CLK;				//	DM9000A Clock 25 MHz
////////////////////	Audio CODEC		////////////////////////////
inout			AUD_ADCLRCK;			//	Audio CODEC ADC LR Clock
input			iAUD_ADCDAT;			//	Audio CODEC ADC Data
inout			AUD_DACLRCK;			//	Audio CODEC DAC LR Clock
output			oAUD_DACDAT;			//	Audio CODEC DAC Data
inout			AUD_BCLK;				//	Audio CODEC Bit-Stream Clock
output			oAUD_XCK;				//	Audio CODEC Chip Clock
////////////////////	TV Devoder		////////////////////////////
input			iTD1_CLK27;				//	TV Decoder1 Line_Lock Output Clock 
input	[7:0]	iTD1_D;    				//	TV Decoder1 Data bus 8 bits
input			iTD1_HS;				//	TV Decoder1 H_SYNC
input			iTD1_VS;				//	TV Decoder1 V_SYNC
output			oTD1_RESET_N;			//	TV Decoder1 Reset
input			iTD2_CLK27;				//	TV Decoder2 Line_Lock Output Clock 		
input	[7:0]	iTD2_D;    				//	TV Decoder2 Data bus 8 bits
input			iTD2_HS;				//	TV Decoder2 H_SYNC
input			iTD2_VS;				//	TV Decoder2 V_SYNC
output			oTD2_RESET_N;			//	TV Decoder2 Reset

////////////////////////	GPIO	////////////////////////////////
inout	[31:0]	GPIO_0;					//	GPIO Connection 0 I/O
input			GPIO_CLKIN_N0;     		//	GPIO Connection 0 Clock Input 0
input			GPIO_CLKIN_P0;          //	GPIO Connection 0 Clock Input 1
inout			GPIO_CLKOUT_N0;     	//	GPIO Connection 0 Clock Output 0
inout			GPIO_CLKOUT_P0;         //	GPIO Connection 0 Clock Output 1
inout	[31:0]	GPIO_1;					//	GPIO Connection 1 I/O
input			GPIO_CLKIN_N1;          //	GPIO Connection 1 Clock Input 0
input			GPIO_CLKIN_P1;          //	GPIO Connection 1 Clock Input 1
inout			GPIO_CLKOUT_N1;         //	GPIO Connection 1 Clock Output 0
inout			GPIO_CLKOUT_P1;         //	GPIO Connection 1 Clock Output 1
///////////////////////////////////////////////////////////////////
//=============================================================================
// REG/WIRE declarations
//=============================================================================

wire	CPU_CLK;
wire	CPU_RESET;
wire	CLK_18_4;
wire	CLK_25;

//	For Audio CODEC
wire		AUD_CTRL_CLK;	//	For Audio Controller

//	For ITU-R 656 Decoder
wire	[15:0]	YCbCr;
wire	[9:0]	TV_X;
wire			TV_DVAL;

//	For VGA Controller
wire	[9:0]	mRed;
wire	[9:0]	mGreen;
wire	[9:0]	mBlue;
wire	[10:0]	VGA_X;
wire	[10:0]	VGA_Y;
wire			VGA_Read;	//	VGA data request
wire			m1VGA_Read;	//	Read odd field
wire			m2VGA_Read;	//	Read even field

//	For YUV 4:2:2 to YUV 4:4:4
wire	[7:0]	mY;
wire	[7:0]	mCb;
wire	[7:0]	mCr;

//	For field select
wire	[15:0]	mYCbCr;
wire	[15:0]	mYCbCr_d;
wire	[15:0]	m1YCbCr;
wire	[15:0]	m2YCbCr;
wire	[15:0]	m3YCbCr;

//	For Delay Timer
wire			TD_Stable;
wire			DLY0;
wire			DLY1;
wire			DLY2;

//	For Down Sample
wire	[3:0]	Remain;
wire	[9:0]	Quotient;

wire			mDVAL;

wire	[15:0]	m4YCbCr;
wire	[15:0]	m5YCbCr;
wire	[8:0]	Tmp1,Tmp2;
wire	[7:0]	Tmp3,Tmp4;

wire SDRAM_CLK;



//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
wire [15:0]out1;
wire [15:0]out2;
wire [15:0]out3;
wire [15:0]out4;
reg [15:0]out_finally;
reg data_wiren1;
reg data_wiren2;
reg data_wiren3;
reg data_wiren4;
reg data_reden1;
reg data_reden2;
reg data_reden3;
reg data_reden4;
reg state;
//////////////////////////////////////////////////////////////////////////////
reg [15:0]writebuff;
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////
//////////////////////////////////////////////////////////////////////////////

//=============================================================================
// Structural coding
//=============================================================================

//	Flash
assign	oFLASH_RST_N	=	1'b1;

//	16*2 LCD Module
assign	oLCD_ON		=	1'b1;	//	LCD ON
assign	oLCD_BLON	=	1'b1;	//	LCD Back Light	

//	All inout port turn to tri-state
assign	SD_DAT		=	1'bz;
assign	AUD_ADCLRCK	=	AUD_DACLRCK;
assign	GPIO_0		=	32'hzzzzzzzzz;
assign	GPIO_1		=	32'hzzzzzzzzz;

//	Disable USB speed select
assign	OTG_FSPEED	=	1'bz;
assign	OTG_LSPEED	=	1'bz;

//	Turn On TV Decoder
//assign	oTD1_RESET_N	=	1'b1;
assign	oTD2_RESET_N	=	1'b1;

//	Set SD Card to SD Mode
assign	SD_DAT3		=	1'b1;

//	Enable TV Decoder
assign	oTD1_RESET_N	=	iKEY[0];

assign	oAUD_XCK	=	AUD_CTRL_CLK;

assign	oLEDG	=	VGA_Y;
assign	oLEDR	=	VGA_X;

assign	m1VGA_Read	=	VGA_Y[0]		?	1'b0		:	VGA_Read	;
assign	m2VGA_Read	=	VGA_Y[0]		?	VGA_Read	:	1'b0		;
assign	mYCbCr_d	=	!VGA_Y[0]		?	m1YCbCr		:
											m2YCbCr		;
assign	mYCbCr		=	m5YCbCr;

assign	Tmp1	=	m4YCbCr[7:0]+mYCbCr_d[7:0];
assign	Tmp2	=	m4YCbCr[15:8]+mYCbCr_d[15:8];
assign	Tmp3	=	Tmp1[8:2]+m3YCbCr[7:1];
assign	Tmp4	=	Tmp2[8:2]+m3YCbCr[15:9];
assign	m5YCbCr	=	{Tmp4,Tmp3};

wire oDRAM_CLK;
assign oDRAM0_CLK = oDRAM_CLK;
assign oDRAM1_CLK = oDRAM_CLK;
//vga clk
wire iTD1_CLK27;


// for resize;
wire enable_left_top,enable_right_top,enable_left_down,enable_right_down;
	
wire [15:0]VGA_in;
wire [15:0]VGA_DATA_LT,VGA_DATA_RT,VGA_DATA_LD,VGA_DATA_RD;

assign enable_left_top   =  VGA_Read  && (VGA_X >=0 	&& VGA_Y >= 0   && VGA_X < 320 && VGA_Y < 240) ? 1 : 0;
assign enable_right_top  =  VGA_Read  && (VGA_X >=320	&& VGA_Y >= 0   && VGA_X < 640 && VGA_Y < 240) ? 1 : 0;
assign enable_left_down  =  VGA_Read  && (VGA_X >=0 	&& VGA_Y >= 240 && VGA_X < 320 && VGA_Y < 480) ? 1 : 0;
assign enable_right_down =  VGA_Read  && (VGA_X >=320 	&& VGA_Y >= 240 && VGA_X < 640 && VGA_Y < 480) ? 1 : 0;
										
assign VGA_in = enable_left_top ? VGA_DATA_LT : (enable_right_top ? VGA_DATA_RT : (enable_left_down ? VGA_DATA_LD : (enable_right_down ? VGA_DATA_RD : 16'b0))); 

// for skin detect;
wire [15:0]skin_DATA;
wire skin_VAL;
//	For image Resize
wire	oResize_valid;
// for dilation and erosion
wire dilation_DATA1,dilation_DATA2,dilation_DATA3,dilation_DATA4,dilation_DATA5,dilation_DATA6,dilation_DATA7,dilation_DATA8;
wire dilation_VAL1,dilation_VAL2,dilation_VAL3,dilation_VAL4,dilation_VAL5,dilation_VAL6,dilation_VAL7,dilation_VAL8;

wire erosion_DATA1,erosion_DATA2,erosion_DATA3,erosion_DATA4,erosion_DATA5,erosion_DATA6,erosion_DATA7,erosion_DATA8,erosion_DATA9,erosion_DATA10;
wire erosion_VAL1,erosion_VAL2,erosion_VAL3,erosion_VAL4,erosion_VAL5,erosion_VAL6,erosion_VAL7,erosion_VAL8,erosion_VAL9,erosion_VAL10;

// For labeling
wire [5:0] output_label;
wire output_label_val,read_enable,labeling_finish;
wire [16:0]read_address,write_address;// dual port ram address from 0~76799
wire [5:0] output_dual_port_data;
wire [5:0] merge_label_1,merge_label_2;
wire [15:0]output_merge_data;
wire output_merge_val;
//	7 segment LUT
SEG7_LUT_8 			u0	(	.oSEG0(oHEX0_D),
							.oSEG1(oHEX1_D),
							.oSEG2(oHEX2_D),
							.oSEG3(oHEX3_D),	
							.oSEG4(oHEX4_D),
							.oSEG5(oHEX5_D),
							.oSEG6(oHEX6_D),
							.oSEG7(oHEX7_D),
							.iDIG(iSW) );
							
//	TV Decoder Stable Check
TD_Detect			u2	(	.oTD_Stable(TD_Stable),
							.iTD_VS(iTD1_VS),
							.iTD_HS(iTD1_HS),
							.iRST_N(iKEY[0])	);

//	Reset Delay Timer
Reset_Delay			u3	(	.iCLK(iCLK_50),
							.iRST(TD_Stable),
							.oRST_0(DLY0),
							.oRST_1(DLY1),
							.oRST_2(DLY2));

//	ITU-R 656 to YUV 4:2:2
ITU_656_Decoder		u4	(	//	TV Decoder Input
							.iTD_DATA(iTD1_D),
							//	Position Output
							.oTV_X(TV_X),
							//	YUV 4:2:2 Output
							.oYCbCr(YCbCr),
							.oDVAL(TV_DVAL),
							//	Control Signals
							.iSwap_CbCr(Quotient[0]),
							.iSkip(Remain==4'h0),
							.iRST_N(DLY1),
							.iCLK_27(iTD1_CLK27)	);

//	For Down Sample 720 to 640
DIV 				u5	(	.aclr(!DLY0),	
							.clock(iTD1_CLK27),
							.denom(4'h9),
							.numer(TV_X),
							.quotient(Quotient),
							.remain(Remain));

//SDRAM CLK
Sdram_PLL sdram_pll1	(
							.inclk0(iTD1_CLK27),
							.c0(SDRAM_CLK),
							.c1(oDRAM_CLK),
							.c2(AUD_CTRL_CLK)
							);

//	SDRAM frame buffer0
Sdram_Control_4Port	u6	(	//	HOST Side
						    .REF_CLK(iTD1_CLK27),
							.CLK_18(),
						    .RESET_N(1'b1),
							//	FIFO Write Side 1
						    .WR1_DATA(YCbCr),
							.WR1(TV_DVAL),
							.WR1_FULL(WR1_FULL),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(640*507),		//	525-18
							.WR1_LENGTH(9'h80),
							.WR1_LOAD(!DLY0),
							.WR1_CLK(iTD1_CLK27),//
							//	FIFO Read Side 1
						    .RD1_DATA(m1YCbCr),
				        	.RD1(m1VGA_Read),
				        	.RD1_ADDR(640*13),			//	Read odd field and bypess blanking
							.RD1_MAX_ADDR(640*253),
							.RD1_LENGTH(9'h80),
				        	.RD1_LOAD(!DLY0),
							.RD1_CLK(iTD1_CLK27),
							//	FIFO Read Side 2
						    .RD2_DATA(m2YCbCr),
				        	.RD2(m2VGA_Read),
				        	.RD2_ADDR(640*267),			//	Read even field and bypess blanking
							.RD2_MAX_ADDR(640*507),
							.RD2_LENGTH(9'h80),
				        	.RD2_LOAD(!DLY0),
							.RD2_CLK(iTD1_CLK27), 
							//	FIFO Write Side 3  // This memory can use.  LEFT TOP.
							.WR3_DATA({mRed[9:5],mGreen[9:4],mBlue[9:5]}),
							.WR3(oResize_valid), 
							.WR3_FULL(WR3_FULL),
							.WR3_ADDR(22'h200000),
							.WR3_MAX_ADDR(22'h200000+320*240),		
							.WR3_LENGTH(9'h80),
							.WR3_LOAD(!DLY0),
							.WR3_CLK(iTD1_CLK27),
							//	FIFO Read Side 3 // LEFT TOP
						    .RD3_DATA(VGA_DATA_LT),
						    .RD3(enable_left_top),
				        	.RD3_ADDR(22'h200000),			
							.RD3_MAX_ADDR(22'h200000+320*240),
							.RD3_LENGTH(9'h80),
				        	.RD3_LOAD(!DLY0),
							.RD3_CLK(iTD1_CLK27),
							//	SDRAM Side
						    .SA(oDRAM0_A),
						    .BA({oDRAM0_BA[1],oDRAM0_BA[0]}),
						    .CS_N(oDRAM0_CS_N),
						    .CKE(oDRAM0_CKE),
						    .RAS_N(oDRAM0_RAS_N),
				            .CAS_N(oDRAM0_CAS_N),
				            .WE_N(oDRAM0_WE_N),
						    .DQ(DRAM_DQ[15:0]),
				            .DQM({oDRAM0_UDQM1,oDRAM0_LDQM0}),
							//.SDR_CLK(oDRAM0_CLK),
							.CLK(SDRAM_CLK)	);

//	SDRAM frame buffer1 // we use this control port. CAN USE WR1,2,3.
Sdram_Control_4Port_1	u61	(	//	HOST Side
						    .REF_CLK(iTD1_CLK27),
							.CLK_18(),
						    .RESET_N(1'b1),
							//	FIFO Write Side 1 // RIGHT TOP  

							.WR1_DATA(skin_DATA),
							.WR1(skin_VAL),
							.WR1_FULL(WR1_FULL),
							.WR1_ADDR(0),
							.WR1_MAX_ADDR(320*240),		
							.WR1_LENGTH(9'h80),
							.WR1_LOAD(!DLY0),
							.WR1_CLK(iTD1_CLK27),
							//	FIFO Read Side 1 // RIGHT TOP
						    .RD1_DATA(VGA_DATA_RT),
				        	.RD1(enable_right_top),
				        	.RD1_ADDR(0),			
							.RD1_MAX_ADDR(320*240),
							.RD1_LENGTH(9'h80),
				        	.RD1_LOAD(!DLY0),
							.RD1_CLK(iTD1_CLK27),


							//	FIFO Write Side 2  // LEFT DOWN
						    .WR2_DATA(erosion_DATA10*16'hFFFF),
							.WR2(erosion_VAL10),
							.WR2_FULL(WR1_FULL),
							.WR2_ADDR(22'h100000),
							.WR2_MAX_ADDR(22'h100000+320*240),		
							.WR2_LENGTH(9'h80),
							.WR2_LOAD(!DLY0),
							.WR2_CLK(iTD1_CLK27),
							//	FIFO Read Side 2 // LEFT DOWN
						    .RD2_DATA(VGA_DATA_LD),
				        	.RD2(enable_left_down),
				        	.RD2_ADDR(22'h100000),			
							.RD2_MAX_ADDR(22'h100000+320*240),
							.RD2_LENGTH(9'h80),
				        	.RD2_LOAD(!DLY0),
							.RD2_CLK(iTD1_CLK27),
							//	FIFO Write Side 3  // RIGHT DOWN 
						    .WR3_DATA(label_data),
							.WR3(label_valid),
							.WR3_FULL(WR3_FULL),
							.WR3_ADDR(22'h200000),
							.WR3_MAX_ADDR(22'h200000+320*240),		
							.WR3_LENGTH(9'h80),
							.WR3_LOAD(!DLY0),
							.WR3_CLK(iTD1_CLK27),
							//	FIFO Read Side 3// RIGHT DOWN
						    .RD3_DATA(VGA_DATA_RD),
				        	.RD3(enable_right_down),
				        	.RD3_ADDR(22'h200000),			
							.RD3_MAX_ADDR(22'h200000+320*240),
							.RD3_LENGTH(9'h80),
				        	.RD3_LOAD(!DLY0),
							.RD3_CLK(iTD1_CLK27),
							//	SDRAM Side
						    .SA(oDRAM1_A),
						    .BA({oDRAM1_BA[1],oDRAM1_BA[0]}),
						    .CS_N(oDRAM1_CS_N),
						    .CKE(oDRAM1_CKE),
						    .RAS_N(oDRAM1_RAS_N),
				            .CAS_N(oDRAM1_CAS_N),
				            .WE_N(oDRAM1_WE_N),
						    .DQ(DRAM_DQ[31:16]),
				            .DQM({oDRAM1_UDQM1,oDRAM1_LDQM0}),
							//.SDR_CLK(oDRAM1_CLK),
							.CLK(SDRAM_CLK));
						
					
//	YUV 4:2:2 to YUV 4:4:4
YUV422_to_444		u7	(	//	YUV 4:2:2 Input
							.iYCbCr(mYCbCr),
							//	YUV	4:4:4 Output
							.oY(mY),
							.oCb(mCb),
							.oCr(mCr),
							//	Control Signals
							.iX(VGA_X),
							.iCLK(iTD1_CLK27),
							.iRST_N(DLY0));


//	YCbCr 8-bit to RGB-10 bit 
YCbCr2RGB 			u8	(	//	Output Side
							.Red(mRed),
							.Green(mGreen),
							.Blue(mBlue),
							.oDVAL(mDVAL),
							//	Input Side
							.iY(mY),
							.iCb(mCb),
							.iCr(mCr),
							.iDVAL(VGA_Read),
							//	Control Signal
							.iRESET(!DLY2),
							.iCLK(iTD1_CLK27));

//	VGA Controller // this module is send the signal from camera to the monitor.



VGA_Ctrl			u9	(	//	Host Side
							
							// these three input color should be change
							
							
							.iRed({VGA_in[15:11],5'b0}),
							.iGreen({VGA_in[10:5],4'b0}),
							.iBlue({VGA_in[4:0],5'b0}),
							/*
							.iRed(mRed),
							.iGreen(mGreen),
							.iBlue(mBlue),
							*/
							.oCurrent_X(VGA_X),
							.oCurrent_Y(VGA_Y),
							.oRequest(VGA_Read),
							//	VGA Side
							.oVGA_R(oVGA_R),
							.oVGA_G(oVGA_G),
							.oVGA_B(oVGA_B),
							.oVGA_HS(oVGA_HS),
							.oVGA_VS(oVGA_VS),
							.oVGA_SYNC(oVGA_SYNC_N),
							.oVGA_BLANK(oVGA_BLANK_N),
							.oVGA_CLOCK(oVGA_CLOCK),
							//	Control Signal // our clk and signal.
							.iCLK(iTD1_CLK27),
							.iRST_N(DLY2)
						);

//	Line buffer, delay one line
Line_Buffer u10	(	.clken(VGA_Read), // VGA_Read to idval
					.clock(iTD1_CLK27),// our clk
					.shiftin(mYCbCr_d),
					.shiftout(m3YCbCr));

Line_Buffer u11	(	.clken(VGA_Read),
					.clock(iTD1_CLK27),
					.shiftin(m3YCbCr),
					.shiftout(m4YCbCr));

AUDIO_DAC 	u12	(	//	Audio Side
					.oAUD_BCK(AUD_BCLK),
					.oAUD_DATA(oAUD_DACDAT),
					.oAUD_LRCK(AUD_DACLRCK),
					//	Control Signals
					.iSrc_Select(2'b01),
			        .iCLK_18_4(AUD_CTRL_CLK),
					.iRST_N(DLY1)	); 

//	Audio CODEC and video decoder setting
I2C_AV_Config 	u1	(	//	Host Side  
						.iCLK(iCLK_50),
						.iRST_N(iKEY[0]),
						//	I2C Side
						.I2C_SCLK(oI2C_SCLK),
						.I2C_SDAT(I2C_SDAT)	);

image_resize a1	(
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.iDVAL(VGA_Read),
					.oResize_valid(oResize_valid)
				);
skin_detect a4 (
					.iDVAL(oResize_valid),
					.irst_n(DLY2),
					.iclk(iTD1_CLK27),
					.icb(mCb),
					.icr(mCr),
					.oDATA(skin_DATA),
					.oDVAL(skin_VAL)
				);



Erosion e1		(
					.iDATA(skin_DATA[0]),
					.iDVAL(skin_VAL),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA1),
					.oDVAL(erosion_VAL1)
				);
Erosion e2		(
					.iDATA(erosion_DATA1),
					.iDVAL(erosion_VAL1),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA2),
					.oDVAL(erosion_VAL2)
				);
				
Dilation d1		(
					.iDATA(erosion_DATA2),
					.iDVAL(erosion_VAL2),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA1),
					.oDVAL(dilation_VAL1)
				);
				
Dilation d2		(
					.iDATA(dilation_DATA1),
					.iDVAL(dilation_VAL1),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA2),
					.oDVAL(dilation_VAL2)
				);				
Dilation d3		(
					.iDATA(dilation_DATA2),
					.iDVAL(dilation_VAL2),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA3),
					.oDVAL(dilation_VAL3)
				);				
Dilation d4		(
					.iDATA(dilation_DATA3),
					.iDVAL(dilation_VAL3),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA4),
					.oDVAL(dilation_VAL4)
				);				
Dilation d5		(
					.iDATA(dilation_DATA4),
					.iDVAL(dilation_VAL4),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA5),
					.oDVAL(dilation_VAL5)
				);				
Dilation d6		(
					.iDATA(dilation_DATA5),
					.iDVAL(dilation_VAL5),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA6),
					.oDVAL(dilation_VAL6)
				);				
Dilation d7		(
					.iDATA(dilation_DATA6),
					.iDVAL(dilation_VAL6),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA7),
					.oDVAL(dilation_VAL7)
				);
				
Dilation d8		(
					.iDATA(dilation_DATA7),
					.iDVAL(dilation_VAL7),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(dilation_DATA8),
					.oDVAL(dilation_VAL8)
				);		
Erosion e3		(
					.iDATA(dilation_DATA8),
					.iDVAL(dilation_VAL8),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA3),
					.oDVAL(erosion_VAL3)
				);

Erosion e4		(
					.iDATA(erosion_DATA3),
					.iDVAL(erosion_VAL3),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA4),
					.oDVAL(erosion_VAL4)
				);
Erosion e5		(
					.iDATA(erosion_DATA4),
					.iDVAL(erosion_VAL4),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA5),
					.oDVAL(erosion_VAL5)
				);
Erosion e6		(
					.iDATA(erosion_DATA5),
					.iDVAL(erosion_VAL5),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA6),
					.oDVAL(erosion_VAL6)
				);
Erosion e7		(
					.iDATA(erosion_DATA6),
					.iDVAL(erosion_VAL6),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA7),
					.oDVAL(erosion_VAL7)
				);

Erosion e8		(
					.iDATA(erosion_DATA7),
					.iDVAL(erosion_VAL7),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA8),
					.oDVAL(erosion_VAL8)
				);								
Erosion e9		(
					.iDATA(erosion_DATA8),
					.iDVAL(erosion_VAL8),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA9),
					.oDVAL(erosion_VAL9)
				);		
Erosion e10		(
					.iDATA(erosion_DATA9),
					.iDVAL(erosion_VAL9),
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.oDATA(erosion_DATA10),
					.oDVAL(erosion_VAL10)
				);



wire label_valid;
wire[15:0] label_data;


labeling a11(
				.iDVAL(erosion_VAL10),
				.iCLK(iTD1_CLK27),
				.iRST_N(DLY2),
				.iDATA(erosion_DATA10),
				.oDATA(label_data),
				.oDVAL(label_valid),
			);


/*
Labeling labeling(
					.iclk(iTD1_CLK27),
					.idata_VAL(erosion_VAL10),
					.irst_n(DLY2),
					.idata(erosion_DATA10),
					.oData(output_label),// this output save into dual port ram
					.oData_VAL(output_label_val),
					.write_addr(write_address),
					.oResolve(oResolve),
					.merge_label_1(merge_label_1),
					.merge_label_2(merge_label_2),
                    .labeling_finish(labeling_finish),
				);


merge_label ML  (
					.iclk(iTD1_CLK27),
					.irst_n(DLY2),
					.ilabel_1(merge_label_1), // these label should be merge.
					.ilabel_2(merge_label_2),
					.iResolve(oResolve),
					.iDATA(output_dual_port_data),
					.oDVAL(output_merge_val),
					.oDATA(output_merge_data), // these label should be change.
                    .labeling_finish(labeling_finish),
                    .read_addr(read_address),
					.VGA_X(VGA_X),
                    .VGA_Y(VGA_Y)
                );   



dual_port_RAM DPR( 
					.clock(iTD1_CLK27),
					.data(output_label),
					.rdaddress(read_address),
					.rden(labeling_finish),
					.wraddress(write_address),
					.wren(output_label_val),
					.q(output_dual_port_data)
				);
*/
endmodule

