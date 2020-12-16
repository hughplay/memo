/*
 * - operator reloading
 * - rounding
 * */
#include<iostream>
#include <math.h>

using namespace std;

float* mul2(float *a, float *b) {
  float *res = new float[2]{a[0]*b[0], a[1]*b[1]};
  return res;
}
class vec2
{
  public:
    float x;
    float y;
    vec2() { this->x = this->y = 0; }
    vec2(float x, float y) {
      this->x = x;
      this->y = y;
    }
    vec2(float x) {
      this->x = x;
      this->y = x;
    }
    ~vec2() {}
    vec2 operator+(const float a) {
      vec2 b;
      b.x = this->x + a;
      b.y = this->y + a;
      return b;
    }
    vec2 operator-(const float a) {
      vec2 b;
      b.x = this->x - a;
      b.y = this->y - a;
      return b;
    }
    vec2 operator*(const float a) {
      vec2 b;
      b.x = this->x * a;
      b.y = this->y * a;
      return b;
    }
    vec2 operator/(const float a) {
      vec2 b;
      b.x = this->x / a;
      b.y = this->y / a;
      return b;
    }
    vec2 operator+(const vec2& a) {
      vec2 b;
      b.x = this->x + a.x;
      b.y = this->y + a.y;
      return b;
    }
    vec2 operator-(const vec2& a) {
      vec2 b;
      b.x = this->x - a.x;
      b.y = this->y - a.y;
      return b;
    }
    vec2 operator*(const vec2& a) {
      vec2 b;
      b.x = this->x * a.x;
      b.y = this->y * a.y;
      return b;
    }
    vec2 operator/(const vec2& a) {
      vec2 b;
      b.x = this->x / a.x;
      b.y = this->y / a.y;
      return b;
    }
};

vec2 operator+(const float a, const vec2 &b) {
  vec2 c;
  c.x = a + b.x;
  c.y = a + b.y;
  return c;
}

ostream& operator<<(ostream& os, const vec2& a) {
  os << "[ " << a.x << ", " << a.y << " ]";
  return os;
}

void test_vec2() {
  vec2 a(1. ,2);
  vec2 b(2. ,4);
  cout << a + b << endl;
  cout << a + 2. << endl;
  cout << a * b << endl;
  cout << a * 2. << endl;
  vec2 c = a / b;
  cout << c << endl;
  cout << a + b * 0 << endl;
  cout << 2 + a << endl;
}

void test_round() {
  float a = 0.4;
  float b = 0.5;
  float c = -0.4;
  float d = -0.5;
  cout << "Num: "   << a << " " << b << " " << c << " " << d << endl;
  cout << "round: " << round(a) << " " << round(b) << " " << round(c) << " " << round(d) << endl;
  cout << "ceil: "  << ceil(a) << " " << ceil(b) << " " << ceil(c) << " " << ceil(d) << endl;
  cout << "floor: " <<floor(a) << " " << floor(b) << " " << floor(c) << " " << floor(d) << endl;
/*
  Num: 0.4 0.5 -0.4 -0.5
  round: 0 1 -0 -1
  ceil: 1 1 -0 -0
  floor: 0 0 -1 -1
*/
}

void test_cast() {
  cout << int(round(3.5)) << endl;
  cout << int(round(3.4)) << endl;
}

void test_array() {
  int size = 10;
  float a[size][size];
  memset(a, 0, size*size*sizeof(float));
  cout << a[9][9] << endl;
}

void test_size() {
  cout << "char: " << sizeof(char) << endl;
  cout << "short: " << sizeof(short) << endl;
  cout << "int: " << sizeof(int) << endl;
  cout << "long: " << sizeof(long) << endl;
  cout << "long long: " << sizeof(long long) << endl;
  cout << "float: " << sizeof(float) << endl;
  cout << "double: " << sizeof(double) << endl;
}

void test_encode() {
  assert(sizeof(int) >= 4);
  int x = 1000, y = 17;
  int a = (x << 16 | y);
  int d_x = a >> 16;
  int d_y = a & ((1 << 16) - 1);
  cout << d_x << " " << d_y << endl;
}

int main() {
  test_encode();
}
