`define c1 label[i*320+(j-1)]
`define c2 label[(i-1)*320+(j-1)]
`define c3 label[(i-1)*320+j]
`define c4 label[(i-1)*320+(j+1)]




module fastLabel();
    // first we need an array to store the labels.
    reg [31:0] label [320*240-1:0]; // 500 個 32bit 的字元組成
    reg [7:0] pictures [320*240-1:0]; // the picture is set to the 320*240.    // 儲存影像資訊的register.
    integer i,j;
    integer m = 0 ;
    parameter Vb = 8'b0;
    parameter pic_rows = 240;
    parameter pic_cols = 320;
    always @(label[0]) // do when picture change.
    begin
        // do binary threshold to the pictures;
        for (i = 0 ; i < 240; i = i + 1)
        begin
            // store the row data into the pictures[i]
    
            // after store into the pictures[i], visit every col in order.
            for (j = 0; j < 320 ; j = j + 1)
            begin
                if(pictures[i*320+j] == Vb)
                begin
                    label[i*320+j] = Vb;
                end
                else if(i>= 1 && label[(i-1)*320+j] != Vb) // c3;
                begin
                    label[i*320+j] = label[(i-1)*320+j]; // c3;
                end
                else if (j>= 1 && label[i*320+(j-1)] != Vb) // c1;
                begin
                    label[i*320+j] = label[i*320+(j-1)];
                    if(i>=1 && j+1 <= 320-1 && label[(i-1)*320+(j+1)] != Vb) // c4
                    begin
                        // do resolve(label[(i-1)*320+(j+1)],label[i*320+(j-1)]);//resolve(c4,c1);
                    end
                end
                else if (i >= 1 && j >= 1 && label[(i-1)*320+(j-1)]!= Vb) // c2
                begin
                    label[i*320+j] = label[(i-1)*320+(j-1)]; // c2;
                    if((j+1) <= (pic_cols - 1)  && label[(i-1)*320+(j+1)] != Vb) // c4
                    begin
                        // do resolve(c2,c4);
                    end
                end
                else if (i >= 1 && j+1 <= (pic_cols-1) && label[(i-1)*320+(j+1)] )
                begin
                    label[i*pic_cols+j] = label[(i-1)*320+(j+1)];
                end
                else
                begin
                    label[i*pic_cols+j] = m;
                    m = m+1; // update the label when give a new label.
                end
            end
        end
    end
endmodule

// function [1:0] resolve;
//     input [7:0]a,b;
//     begin
//         resolve = a + b;
//     end
// endfunction
