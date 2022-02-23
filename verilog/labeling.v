module Labeling(
					iclk,
					idata_VAL,
					irst_n,
					idata,
					oData,// this output save into dual port ram
					oData_VAL,
					write_addr,
					oResolve,
					merge_label_1,
					merge_label_2,
                    labeling_finish,
				);


input iclk,idata_VAL,irst_n,idata;
output reg [5:0]oData;
output reg oData_VAL;
output reg oResolve;
output reg [5:0] merge_label_1,merge_label_2;
output reg labeling_finish;
reg [5:0] newLabel;
reg [8:0] x,y,a;
reg [5:0] c1,c2,c3,c4;
output reg [16:0]write_addr;// dual port ram address from 0~76799
wire read_enable;

reg [5:0]currentRow[321:0];


always@(posedge iclk or negedge irst_n)
	begin
		if(!irst_n)
			begin
				oData_VAL = 0;
				oData = 0;
				x = 1;
				y = 0;
				newLabel = 1;
				c1 = 0;
				c2 = 0;
				c3 = 0;
				c4 = 0;
				oResolve = 0;
				labeling_finish = 0;
				for(a = 0 ; a < 320; a = a+1)
					begin
						currentRow[a] = 0;
					end
			end
		else if (idata_VAL)
			begin
				oResolve = 0;
				c2 = c3;
            	c1 = currentRow[x-1];
				c3 = currentRow[x];
				c4 = currentRow[x+1];
				
                oData_VAL = idata_VAL;
                if(idata == 0)
                    begin
                        oData = 6'b0;
                    end
                else if (c3 != 0)// check c1,c2,c3,c4
					begin
						oData = c3;
					end
				else if (c1 != 0)
					begin
						oData = c1;
						if(c4 != 0)
							begin
								oResolve = 1;
								if(c4>c2)
									begin
										merge_label_1 = c2;
										merge_label_2 = c4;
									end
								else
									begin
										merge_label_1 = c4;
										merge_label_2 = c2;
									end
							end
					end
				else if(c2!=0)
					begin
						oData = c2;
						if(c4!=0)
						begin
							oResolve = 1;
							if(c4>c2)
								begin
									merge_label_1 = c2;
									merge_label_2 = c4;
								end
							else
								begin
									merge_label_1 = c4;
									merge_label_2 = c2;
								end
						end
					end
				else if (c4!=0)
					begin
						oData = c4;
					end
				else
					begin
						oData	= newLabel;
						newLabel = newLabel+1;
					end
				currentRow[x] = oData;
				write_addr = y*320+x-9'b1;
				x = x+9'b1;
				if(x==321)
					begin
						x = 9'b1;
						y = y + 9'b1;
						if(y == 240)
							begin
								for(a = 0; a <322; a = a + 9'b1)
									begin
										currentRow[a] = 6'b0;
									end
								y = 0;
								newLabel = 1;
								oResolve = 0;
								labeling_finish = 1;
							end
					end
				
            end

        oData_VAL = idata_VAL;
	end
				






endmodule



