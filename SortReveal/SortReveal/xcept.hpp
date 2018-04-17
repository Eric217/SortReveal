//
//  xcept.hpp
//  SortReveal
//
//  Created by Eric on 2018/4/18.
//  Copyright © 2018 Eric. All rights reserved.
//

#ifndef xcept_hpp
#define xcept_hpp

#include <iostream>

//为什么一些常量定义在这呢？ Config.h 不知为什么不能同时被OC和C++ include 只好先这样 问题不大

#define ZERO_SIGN '0'
#define LEFT_HIGH 1

#define HFMLEFTPATH '0'
#define HFMRIGHTPATH '1'

using namespace std;

class OutOfBounds {};
class NoMemory {};

#endif /* xcept_hpp */

