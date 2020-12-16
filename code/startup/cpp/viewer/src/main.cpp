#include <iostream>
#include <opencv2/opencv.hpp>
#include <boost/program_options.hpp>
#include "viewer/viewer.h"

using namespace cv;
using namespace std;
namespace po = boost::program_options;

int main(int argc, char *argv[]) {
  string img_path;

  po::options_description desc("Allowed options");
  desc.add_options()
    ("help,h", "produce help message")
    ("img,i", po::value<string>(&img_path)->required(), "Image path.");
  po::variables_map vm;
  po::store(po::parse_command_line(argc, argv, desc), vm);
  try {
    po::notify(vm);
  } catch (po::required_option &e) {
    if (vm.count("help")) {
      cout << desc << "\n";
      return 1;
    } else {
      cerr << "Error: " << e.what() << endl;
      cout << "use -h to get help message." << endl;
      return 1;
    }
  }


  Mat img = imread(img_path);
  Viewer viewer(img);
  viewer.show();
  return 0;
}
