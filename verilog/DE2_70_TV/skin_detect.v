module skin_detect(
					iDVAL,
					iclk,
					irst_n,
					icb,
					icr,
					oDATA,
					oDVAL
					);
input iDVAL,iclk,irst_n;
input [7:0] icb,icr;
output reg [15:0]oDATA;
output reg oDVAL;

always@(posedge iclk or negedge irst_n)
begin
	if(!irst_n)
		begin
			oDATA = 0;
			oDVAL = 0;
		end	
	else if (iDVAL)
		begin
			if (icb > 8'd85 && icb < 8'd127 && icr > 8'd132 && icr < 8'd155)
				begin
					oDATA = 16'hFFFF;
					oDVAL = 1;
				end
			else
				begin
					oDATA = 16'h0;
					oDVAL = 1;
				end
		end
	else
		begin
			oDVAL = 0;
		end


end

endmodule