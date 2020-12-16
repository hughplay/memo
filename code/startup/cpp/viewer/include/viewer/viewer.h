#pragma once

#include <string>
#include <opencv2/opencv.hpp>

using namespace std;
using namespace cv;

class Viewer {
  public:
    Viewer(Mat img, string name = "Viewer");
    ~Viewer() {}
    void show();

  private:
    string name;
    Mat img;
};


