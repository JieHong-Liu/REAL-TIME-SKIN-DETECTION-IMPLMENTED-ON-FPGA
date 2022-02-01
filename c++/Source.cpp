#include <iostream>	
#include <vector>
#include <opencv2/core/core.hpp>
#include <opencv2/highgui/highgui.hpp>
#include <opencv2/opencv.hpp>
#include "disjointSet.h"
#include <time.h>
using namespace std;
using namespace cv;

#define Vb 0
#define c1 v[i][j-1]
#define c2 v[i-1][j-1]
#define c3 v[i-1][j]
#define c4 v[i-1][j+1]

void fastLabel(Mat& src);
void resolve(int,int);
struct DisjointSet djs(500); // every label's parent is itself.


int main()
{
	Mat image;
	image = imread("C:/Users/jieho/Documents/coding/papers/fast-labeling/Labeling2.png",0);
	if (image.data == nullptr)
	{
		cerr << "Open Failed!!!" << endl;
	}

	else
	{
		namedWindow("img", WINDOW_AUTOSIZE);
		imshow("img", image);
		fastLabel(image);
	}

	return 0;
}

void fastLabel(Mat& src) 
{
	double START, END;
	START = clock();
	// first scan
	vector <vector<int>> v;
	v.resize(src.rows);
	for (int i = 0; i < src.rows; i++)
	{
		v[i].resize(src.cols);
	}
	Mat bin_src;
	threshold(src, bin_src, 100, 255, THRESH_BINARY); // binary threshold
	Mat dst_label(bin_src.size(), 0);
	int label = 1;
	for (int i = 0; i < dst_label.rows; i++) // first scan
	{
		for (int j = 0; j < dst_label.cols; j++)
		{
			if (bin_src.at<uchar>(i, j) == Vb) // if the pixel is background, then we give label 0;
			{
				v[i][j] = 0;
			}
			else if (i >= 1 && c3 != Vb) // c3 != background
			{
				v[i][j] = djs.find_set(c3);
			}
			else if (j >= 1 && c1 != Vb) // c1 != background
			{
				v[i][j] = djs.find_set(c1);
				if (i>=1 && j+1 <= dst_label.cols-1 && c4 != Vb) // c4 != background
				{
					resolve(c4, c1);
				}
			}
			else if (i >= 1 && j >= 1 && c2 != Vb) // c2 != background
			{
				v[i][j] = djs.find_set(c2);// djs.find_set(c2);
				if (j+1 <= dst_label.cols-1 && c4 != Vb) // c4 != background
				{
					resolve(c2, c4); // resolve c2,c4
				}
			}
			else if (i >= 1 && j+1 <= dst_label.cols-1 && c4)
			{
				v[i][j] = djs.find_set(c4);
			}
			else
			{
				v[i][j] = label;
				label = label + 1;
			}
		}
	}
#if 0
	namedWindow("first scan", WINDOW_AUTOSIZE);
	cv::imshow("first scan", dst_label);
#endif
	for (int i = 0; i < 1024; i++)
	{
		for (int j = 0; j < 1024; j++)
		{
			if (bin_src.at<uchar>(i, j) != Vb) 
			{				
				v[i][j] = djs.find_set(v[i][j]);
				if (v[i][j] == 1) { v[i][j] = 255; }
				dst_label.at<uchar>(i, j) = v[i][j];
			}
		}
	}
	END = clock();
	cout << "fast-label elapsed time :" << (END - START) / CLOCKS_PER_SEC << endl;
	namedWindow("Second Scan", WINDOW_AUTOSIZE);
	cv::imshow("Second Scan", dst_label);
	waitKey(0);
}

void resolve(int a, int b) // combine them into the same label set.
{
	if (a == b) return;
	djs.union_set(a, b);
}
