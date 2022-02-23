module Dilation(
				iDATA,
				iDVAL,
				iclk,
				irst_n,
				oDATA,
				oDVAL
				);
input iDATA,iDVAL,iclk,irst_n;
output reg oDATA,oDVAL;

reg	p1,p2,p3,p4,p5,p6,p7,p8,p9;
reg [9:0]pixel_counter = 0;
wire line0,line1,line2;



shift_reg line_buffer(
						.clken(iDVAL),
						.clock(iclk),
						.shiftin(iDATA),
						.taps0x(line0),
						.taps1x(line1),
						.taps2x(line2)
					 );

always@(posedge iclk or negedge irst_n)
begin
	if(!irst_n)
	begin
		oDATA = 0;
		oDVAL = 0;
		pixel_counter = 0;
	end
	else if(iDVAL &&pixel_counter < 642) // 320*3+3;
	begin
		pixel_counter = pixel_counter + 10'b1;
		oDVAL = 0;
	end
	else if (iDVAL && pixel_counter >=  642)
	begin
		p1 <= line0;
		p2 <= p1;
		p3 <= p2;
		
		p4 <= line1;
		p5 <= p4;
		p6 <= p5;
		
		p7 <= line2;
		p8 <= p7;
		p9 <= p8;
		oDATA = p1 | p2 | p3 | p4 | p5 | p6 | p7 | p8 | p9;
		oDVAL = 1;
	end
	else
	begin
		oDVAL = 0;
	end

end



endmodule