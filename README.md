# REAL-TIME-SKIN-DETECTION-IMPLMENTED-ON-FPGA

###### tags: `FPGA`, `C++`, `Image Processing`

## Software Design (C++)

### Fast-connected component Labeling

主要是想讓程式可以知道哪些pixel是同一個物件，哪些不是。

This algorithm is A Two Scan Algorithm.

In the first scan, all provisional labels that belong to a connected component found at this point will be combined in the same equivalent label set and hold the same representative label.

That is, all labels in an equivalent label set are equivalent. Therefore, when processing an object pixel, in the case where there is at least one object pixel in the mask, instead of assigning the minimum label in the mask to the object pixel, we can assign an arbitrary provisional label in the mask to it. This simplifies the labeling operation by avoiding calculation of the minimum label in the mask.


![](https://i.imgur.com/lY3Q4UG.png)

--- 

#### PROPOSED ALGORITHM

![](https://i.imgur.com/KHYtjdp.png)

---

#### Software DEMO
![](https://i.imgur.com/m0Y1wGC.png)


## FGPA Design (Verilog)

接著我們將我們的演算法porting到FPGA-[DE2-70](https://www.terasic.com.tw/cgi-bin/page/archive.pl?Language=Taiwan&CategoryNo=185&No=230)上，並以形態學及物件聯通，實現即時皮膚偵測(REAL TIME SKIN DETECTION)


### 實驗步驟

1. (左上)將相機(Camera)讀近來的影像(640 * 480)，Resize成(320 * 240)的影像

2. (右上)利用YCbCr色彩空間，找到皮膚色的範圍，並將其輸出

3. (左下)將膚色部分的圖片，進行形態學的膨脹及侵蝕，濾掉不相干的雜訊，及加強特徵

4. (右下)將形態學處理好的影像，以硬體描述語言實現物件聯通演算法，將同樣的LABEL標記成相同的顏色，並輸出到螢幕上。

![](https://i.imgur.com/ecGd8tA.png)

![](https://i.imgur.com/M8mc4vr.png)


### 實驗應用

此實驗為張勝傑學長於2012完成的論文(以FPGA實現即時多人臉偵測系統)，於FPGA上的前處理。
當程式知道哪些pixel是同一個物件後，我們就可以對他們進行更進一步的處理。

## Reference

[1] [A Real-Time Multi-Face Detection System Implemented on FPGA](https://hdl.handle.net/11296/d42yf5)
