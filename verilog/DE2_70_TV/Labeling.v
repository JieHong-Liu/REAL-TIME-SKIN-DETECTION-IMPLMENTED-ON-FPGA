module labeling(iDVAL,iCLK,iRST_N,iDATA,oDATA,oDVAL);
	input iDVAL,iCLK,iRST_N,iDATA;
	output reg oDVAL;
	output reg[15:0] oDATA;
	
	reg[5:0] now_label;
	reg[5:0] ex_row[319:0],C2;
	reg[5:0] djs[63:0],equal_index,ram;
	reg[3:0] state;
	reg[8:0] row,col;
	reg[5:0] new_label;
	
	integer i;

	reg[8:0] i_counter,j_counter;
	reg morphological_syn;
	
always@(posedge iCLK or negedge iRST_N)
	begin
		if(!iRST_N)
			begin
				i_counter<=0;
				j_counter<=0;
			end
		else
			begin
				if(iDVAL)
					begin
						if(j_counter==319)
							begin
								j_counter<=0;
								if(i_counter==239)
									begin
										i_counter <= 0;
										morphological_syn <= 1 ;
									end
								else
									begin
										i_counter <= i_counter + 1 ;
										morphological_syn <= 0 ;
									end	
							end
						else
							begin
								j_counter <= j_counter + 1;
								morphological_syn<=0;
							end	
					end
			end
	end
	
always@(posedge iCLK or negedge iRST_N)
	begin
		if(!iRST_N)
			begin
				state<=0;
				row<=0;
				col<=0;
				C2<=0;
				new_label<=1;
				equal_index<=1;
				now_label<=0;
				wren<=0;
			end
		else
			begin
				case(state)
					0:
						begin
							if(col==319)
								begin
									col<=0;
								end	
							else
                                begin
    								col<=col+1;
                                end
    						ex_row[col]<=0;

							if(col<64)
                                begin
    								djs[col]<=0;
                                end
    						C2<=0;
							new_label<=1;
							equal_index<=1;
							
							if(morphological_syn)
								state<=1;
						end
					1:
						begin
							if(iDVAL)
								begin
									if(row>0 && row<239 && col<319)//no need to calculate c2.
										C2<=ex_row[col]; 
									else
										C2<=0;
										
									if(iDATA)
										begin											
											if(ex_row[col])// check C3!= Vb
												begin
													now_label<=ex_row[col];
//													ex_row[col]<=ex_row[col];
												end
											else if(ex_row[col-1])//then check C1
												begin
													now_label	<=	ex_row[col-1];
													ex_row[col]	<=	ex_row[col-1]; // c3 = c2;
													
													if(ex_row[col+1])// C4 != Vb
														begin
															if (djs[ex_row[col-1]] == 0 && djs[ex_row[col+1]] == 0)//resolve c1 and c4.
                                                                begin
																	djs[ex_row[col-1]] <= equal_index;
																	djs[ex_row[col+1]] <= equal_index;
																	equal_index<=equal_index+1;
																end
															else if (djs[ex_row[col-1]]!= djs[ex_row[col+1]])
																begin
																	if (djs[ex_row[col-1]] == 0)
																		djs[ex_row[col-1]] <= djs[ex_row[col+1]];
																	else if (djs[ex_row[col+1]] == 0)
																		djs[ex_row[col+1]] <= djs[ex_row[col-1]];
																	else
																		begin
																			ram = djs[ex_row[col+1]];
																			for (i = 63; i >= 1; i=i-1)
																				begin
																					if (djs[i] == ram)
																						djs[i] <= djs[ex_row[col-1]];
																				end
																		end
																end
														end
												end
											else if(C2)//C2
												begin
													now_label<=C2;
													ex_row[col]<=C2;
													
													if(ex_row[col+1])//C4
														begin
															if ( djs[C2] == 0 && djs[ex_row[col+1]] == 0)//unused label
																begin
																	djs[C2] <= equal_index;
																	djs[ex_row[col+1]] <= equal_index;
																	equal_index<=equal_index+1;
																end
															else if (djs[C2]!= djs[ex_row[col+1]])//c2 != c4, then do resolve.
																begin
																	if (djs[C2] == 0)
																		djs[C2] <= djs[ex_row[col+1]];
																	else if (djs[ex_row[col+1]] == 0)
																		djs[ex_row[col+1]] <= djs[C2];
																	else
																		begin
																			ram = djs[ex_row[col+1]];//blocking
																			for (i = 63; i >= 1; i=i-1)//
																				begin
																					if (djs[i] == ram)
																						djs[i] <= djs[C2];
																				end
																		end
																end
														end
												end
											else if(ex_row[col+1])//check C4
												begin
													now_label<=ex_row[col+1];
													ex_row[col]<=ex_row[col+1];
												end
											else
												begin
													now_label <= new_label;
													ex_row[col] <= new_label;
													new_label <= new_label+1;
												end
										end
									else
										begin
											now_label <= 0;
											ex_row[col] <= 0;
										end
										
									if(col==319)
										begin
											col<=0;
											if(row==239)
												begin
													row<=0;
													state<=2;
												end
											else
												begin
													row<=row+1;
												end
										end
									else
										begin
											col<=col+1;
										end
									wren<=1;
								end
							else
								wren<=0;
						end
					2://label assign done
						begin
							wren<=0; // no need to write.
							if(merge_finish)
								begin
									state<=3;
								end
						end
					3:
						begin
							if(morphological_syn)
								begin
									state<=1;
								end
							
							for(i=0;i<320;i=i+1) // clear the ex_row;
								begin
									ex_row[i]<=0;
								end
							for(i=0;i<64;i=i+1)
								begin
									djs[i]<=0; // clear the disjoint set.
								end
							C2<=0;
							new_label<=1;
							equal_index<=1;
						end
				endcase
			end
	end
	
always@(*)
	begin
		case(output_label)
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

reg[5:0] output_label;	
reg[8:0] sec_row,sec_col;
reg merge_finish;

always@(posedge iCLK or negedge iRST_N)//second refresh label
	begin
		if(!iRST_N)
			begin
				sec_row<=0;
				sec_col<=0;
				rden<=0;
				merge_finish<=0;
			end
		else
			begin
				if(state==2) // second scan.
					begin
						rden<=1;
						
						if(djs[labeling_data]==0)//unused label
							begin
								output_label<=labeling_data;
							end
						else
							begin
								output_label<=djs[labeling_data];
							end

						if(sec_col==319)
							begin
								sec_col<=0;
								if(sec_row==239)
									begin
										sec_row<=0;
										rden<=0;
										merge_finish<=1;
									end
								else
									begin
										sec_row<=sec_row+1;
										merge_finish<=0;
									end
							end
						else
							begin
								sec_col<=sec_col+1;
								merge_finish<=0;
							end
						oDVAL<=1;
					end
				else
					begin
						rden<=0;
						oDVAL<=0;
						merge_finish<=0;
					end
			end
	end
reg wren,rden;
wire[5:0] labeling_data;

wire[16:0] wraddress;
assign 	wraddress = row * 320 + col;//address:0~76799(0~320*240-1)

wire[16:0] rdaddress;
assign 	rdaddress = sec_row * 320 + sec_col;//address:0~76799(0~320*240-1)

dual_port_RAM DPR( 
					.clock(iCLK),
					.data(now_label),
					.rdaddress(rdaddress),
					.rden(rden),
					.wraddress(wraddress),
					.wren(wren),
					.q(labeling_data)
				);
endmodule
