#include <iostream>
#include <string>
#include <opencv2/opencv.hpp>
#include "viewer/viewer.h"

using namespace std;
using namespace cv;

Viewer::Viewer(Mat img, string name) {
  this->img = img;
  this->name = name;
}

void Viewer::show() {
  namedWindow(name, WINDOW_AUTOSIZE);
  imshow(name, img);
  waitKey(0);
}

