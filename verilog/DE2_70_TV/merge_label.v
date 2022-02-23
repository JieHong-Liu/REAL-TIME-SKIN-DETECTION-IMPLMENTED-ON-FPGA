module merge_label  (        
                        iclk,
                        irst_n,
                        ilabel_1, // these label should be merge.
                        ilabel_2,
                        iResolve,
                        iDATA,
                        oDVAL,
                        oDATA, // these label should be change.
                        labeling_finish,
                        read_addr,
                        VGA_X,
                        VGA_Y,
                        readEnable
                    );
input	[10:0]	VGA_X;
input	[10:0]	VGA_Y;
input [5:0] ilabel_1,ilabel_2,iDATA;
input iResolve,labeling_finish;
input iclk,irst_n;
reg [5:0] root_ilabel1,root_ilabel2,tmp_label1,tmp_label2;
reg [8:0] i_counter,j_counter;
reg [5:0] tmpData;
output reg [15:0] oDATA;
output reg oDVAL;
output reg [16:0] read_addr;
output reg readEnable;
reg [6:0] i;
reg [15:0] tmp;
reg [2:0] state = 0;
reg [5:0] djs [63:0];
reg [6:0] counter=0;
reg [5:0] tmpLabel;

always@(posedge iclk or negedge irst_n)
begin
	if(!irst_n)
		begin
			counter <= 0;
			for(i = 0; i < 64; i = i + 1)
				begin
					djs[i] <= i;
				end
		end
	else if(iResolve)
		begin
			if(state == 0) // first time.
				begin
					state <= 1;
					for(i = 0; i < 64; i=i+1)
						begin
							djs[i] <= i; // update the disjoint set.
						end                            
				end
			 // state == 1 (do merge.)
			for(counter = 0; counter<64; counter = counter + 1)
				begin
					if(djs[ilabel_2] >= djs[ilabel_1])
						begin
							if(djs[counter] == djs[ilabel_2])
								djs[counter] <= djs[ilabel_1];
						end
					else
						begin
							if(djs[counter] == djs[ilabel_1])
								djs[counter] <= djs[ilabel_2];
						end
				end
		end
end
    
    
    
always@(posedge iclk or negedge irst_n)
	begin
		if(!irst_n)
			begin
				oDATA <= 0;
				oDVAL <= 0;
				i_counter <= 0;
				j_counter <= 0;
				tmpLabel <= 0;
			end
		
		// second scan.
		else if (labeling_finish)
			begin
                oDVAL <= 1;
                read_addr = i_counter*320 + j_counter;
                
				j_counter <= j_counter + 1;
				if(j_counter == 320)
					begin
						i_counter <= i_counter + 9'b1;
						j_counter <= 9'b0;
						if(i_counter == 240)
							begin
								i_counter <= 9'b0;
								j_counter <= 9'b0;
								oDVAL <= 1'b0;
							end
					end
                
                oDATA <= iDATA;
                
			end
	end
	/*
	always@(output_DATA)
	begin
		case(output_DATA)
			0:oDATA=0;
			1:oDATA=16'h000f;
			2:oDATA=16'h03e0;
			3:oDATA=16'h03ef;
			4:oDATA=16'h7800;
			5:oDATA=16'h780F;
			6:oDATA=16'h7BE0;
			7:oDATA=16'hD69A;
			8:oDATA=16'h7BEF;
			9:oDATA=16'h001F;
			10:oDATA=16'h07E0;
			11:oDATA=16'h07FF;
			12:oDATA=16'hF800;
			13:oDATA=16'hF81F;
			14:oDATA=16'hFFE0;
			15:oDATA=16'hFFFF;
			16:oDATA=16'hFDA0;
			17:oDATA=16'hB7E0;
			18:oDATA=16'hFE19;
			19:oDATA=16'h9A60;
			20:oDATA=16'hFEA0;
			21:oDATA=16'hC618;
			22:oDATA=16'h867D;
			23:oDATA=16'h915C;
			default:
				oDATA=0;
		endcase
	end
    */

	
endmodule


