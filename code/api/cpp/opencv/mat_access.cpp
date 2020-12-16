#include<iostream>
#include<opencv2/opencv.hpp>

using namespace std;
using namespace cv;

Mat get_patch(Mat src, Point pos, Size patch_size) {
  Rect rect = Rect(pos, patch_size);
  return src(rect);
}

// Test
void test_access() {
  Mat x = Mat::ones(3, 3, CV_64FC1);
  Mat y = Mat::ones(2, 2, CV_64FC1);
  auto patch = get_patch(x, Point(0, 0), Size(2, 2));
  cout << "x Before:" << endl << x << endl;
  addWeighted(patch, 1, y, 2, 0, patch);
  cout << "x After addWeighted:" << endl << x << endl;

  x.at<double>(2, 2) += 1;
  cout << "x After increment:" << endl << x << endl;

  Mat z = Mat::ones(3, 3, CV_64FC1) * 3;
  cout << "z:" << endl << z << endl;
  Mat res = z / x;
  cout << "z divide x:" << endl << res << endl;
}

void test_channels() {
  Mat x = Mat(3, 3, CV_8UC3, Scalar(1, 1, 1));
  Mat y = Mat::ones(3, 3, CV_8UC1);
  randu(y, Scalar(1), Scalar(5));
  cout << "x Before:" << endl << x << endl;
  cout << "y:" << endl << y << endl;
  vector<Mat> x_channels;
  split(x, x_channels);
  for (auto channel : x_channels) {
    channel = channel / y;
  }
  merge(x_channels, x);
  cout << "x After:" << endl << x << endl;
}

void test_weight_norm() {
  Mat x = Mat::ones(3, 3, CV_8UC1);
  Mat y = Mat::ones(3, 3, CV_8UC1) * 255;
  cout << "x:" << endl << x << endl;
  cout << "y:" << endl << y << endl;
  double res_1 = norm(x, y, NORM_L2SQR);
  cout << "Norm result 1: " << res_1 << endl;
  x.convertTo(x, CV_64F);
  y.convertTo(y, CV_64F);
  double res_2 = norm((x-y)/3, NORM_L2SQR);
  cout << "Norm result 2: " << res_2 << endl;
}
void test_multi_channel_weight_norm() {
  Mat a = Mat(2, 2, CV_8UC2, Scalar(1, 2));
  Mat b = Mat(2, 2, CV_8UC2, Scalar(3, 4));
  cout << "a:" << endl << a << endl;
  cout << "b:" << endl << b << endl;
  double loss = 0;
  for (int y = 0; y < a.rows; ++y) {
    for (int x = 0; x < a.cols; ++x) {
      auto pixel_a = a.at<Vec3b>(y, x);
      auto pixel_b = b.at<Vec3b>(y, x);
      loss += norm(pixel_b, pixel_a, NORM_L2SQR) * 0.5;
    }
  }
  cout << loss << endl;
}

void test_operation() {
  Mat x = Mat(3, 3, CV_8UC3, Scalar(1, 1, 1));
  cout << "x: " << endl << x << endl;
  cout << "sum: " << sum(sum(x)) << endl;

  Vec3b a(11, 33, 55);
  Vec3b b(22, 44, 66);
  cout << a + b << endl;
  cout << a * 2 << endl;
}

void test_convert_uchar2float() {
  Mat x = Mat::ones(3, 3, CV_8UC1);
  x.at<uchar>(2, 2) = 2;
  cout << "x: " << endl << x << endl;

  x.convertTo(x, CV_32FC1);
  float* mat_data = (float*)x.data;
  cout << "last value of mat: " << *(mat_data + 3*2 + 2) << endl;
  *(mat_data + 3*2 + 2) = 3;
  cout << "x: " << endl << x << endl;
}

void test_convert_uchar2char() {
  Mat x = Mat::ones(3, 3, CV_8UC1)*255;
  x.at<uchar>(2, 2) = 2;
  cout << "x: " << endl << x << endl;

  char* mat_data = (char*)x.data;
  cout << "last value of mat: " << (int)*(mat_data + 3*2 + 2) << endl;
  *(mat_data + 3*2 + 2) = 3;
  cout << "x: " << endl << x << endl;
}

void write_ptr(char* mat) {
  mat[2*3+2] = 2;
}
void test_write_ptr() {
  Mat x = Mat::ones(3, 3, CV_8UC1)*255;
  cout << "x: " << endl << x << endl;
  char* mat_data = (char*)x.data;
  write_ptr(mat_data);
  cout << "x: " << endl << x << endl;
}

void test_modify_rgb() {
  Mat x = Mat(3, 3, CV_8UC3, Scalar(1, 1, 1));
  cout << "x: " << endl << x << endl;
  x.at<Vec3b>(0, 0) = Vec3b(3, 3, 3);
  cout << "x: " << endl << x << endl;
}

void test_attr() {
  Mat x = Mat(3, 3, CV_32FC3, Scalar(1, 2, 3));
  cout << "info:" << endl;
  cout << "Rows: " << x.rows << endl
       << "Cols: " << x.cols << endl
       << "Dims: " << x.dims << endl
       << "Size: " << x.size << endl
       << "Size 0: " << x.size[0] << endl
       << "Size 1: " << x.size[1] << endl
       << "Size 2: " << x.size[2] << endl
       << "Channels: " << x.channels() << endl
       << "Step: " << x.step << endl
       << "Step1: " << x.step1() << endl
       << "Flags: " << x.flags << endl
       << endl;
  float *ptr = x.ptr<float>();
  int step = x.step1();
  int channel = x.channels();
  for (int i = 0; i < x.rows; ++i) {
    cout << "Row " << i << endl;
    for (int j = 0; j < x.cols; ++j) {
      cout << "Col " << j << ": "
           << *(ptr + i * step + j * channel)     << " "
           << *(ptr + i * step + j * channel + 1) << " "
           << *(ptr + i * step + j * channel + 2) << " "
           << endl;
    }
  }
/*
info:
Rows: 3
Cols: 3
Dims: 2
Size: 3 x 3
Size 0: 3
Size 1: 3
Size 2: -1353698432
Channels: 3
Step: 36
Step1: 9
Flags: 1124024341

Row 0
Col 0: 1 2 3
Col 1: 1 2 3
Col 2: 1 2 3
Row 1
Col 0: 1 2 3
Col 1: 1 2 3
Col 2: 1 2 3
Row 2
Col 0: 1 2 3
Col 1: 1 2 3
Col 2: 1 2 3
*/
}

void multiply() {
  Vec2f a(1., 2.);
  Vec2f b(1., 2.);
  cout << 2 * b << endl;
}

void test_save() {
  Mat img = imread("pic/pic.jpg", CV_LOAD_IMAGE_GRAYSCALE);
  img.convertTo(img, CV_32FC1, 1./255);
  imwrite("pic/save.jpg", img);
  // Nope, only 8-bit /16 bit
}

void test_vect() {
  Vec3b a(1, 2, 3);
  Vec3b b(2, 2, 2);
  auto c = Vec3f(a) * 0.2 + Vec3f(b) * 0.8 ;
  cout << Vec3b(c) << endl;
}

void test_max() {
  float data[9] = {1, 2, 3, 4, 5, 6, 7, 8, 9};
  Mat a(Size(3, 3), CV_32FC1, data);
  double a_min, a_max;
  minMaxLoc(a, &a_min, &a_max);
  cout << a << endl;
  cout << a_min << a_max << endl;
}

void test_type() {
  Mat a(Size(3, 3), CV_8UC1);
  cout << CV_8UC1 << " " << a.type() << endl;
  Mat b(Size(3, 3), CV_32FC1);
  cout << CV_32FC1 << " " << b.type() << endl;
}

void test_convert() {
  Mat a(Size(2, 2), CV_8UC3, Scalar(1, 2, 3));
  a.convertTo(a, CV_32F);
  cout << a << endl;
}

void test_point() {
  Point a(100, 100);
  Point b(10, -10);
  cout << a + b << endl;
}

void test_order() {
  int height = 3, width = 2;
  Mat a = Mat::zeros(Size(width, height), CV_8UC1);
  cout << a << endl;
  cout << (a.rows == height) << endl;
  cout << (a.cols == width) << endl;
}

void test_compare_value() {
  Mat a(Size(3,3), CV_8UC1);
  cout << a << endl;
  cout << (a > 0) << endl;
}

int main() {
  test_compare();
}
