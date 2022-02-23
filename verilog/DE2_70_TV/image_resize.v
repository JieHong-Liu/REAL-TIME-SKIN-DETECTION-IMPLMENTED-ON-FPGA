module image_resize
(
	iDVAL,
	iclk,
	irst_n,
	oResize_valid
);



input iDVAL;
input iclk;
input irst_n;
output reg oResize_valid;
reg [9:0]x_counter = 0;
reg y_counter = 0;

always@(posedge iclk or negedge irst_n)
begin
		if(!irst_n)
		    begin
				x_counter = 0;
				y_counter = 0;
            end
        else if(iDVAL)
			begin
                if(y_counter == 0)
                    begin
                        if(x_counter % 2 == 0)
                            begin
                                oResize_valid = 1;
                            end
                        else
                            begin
                                oResize_valid = 0;
                            end
                    end
                 
                else if (y_counter == 1)
                    begin
                        oResize_valid = 0;
                    end
                
                x_counter = x_counter + 1;
                if(x_counter == 10'd640)
                    begin
                        x_counter = 0;
                        y_counter = ~y_counter;
                    end
		    end
end



endmodule
