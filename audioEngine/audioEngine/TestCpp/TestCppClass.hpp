//
//  TestCppClass.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/02.
//

#ifndef TestCppClass_hpp
#define TestCppClass_hpp

#include <stdio.h>
class TestCppClass{
private:
    int myNum_;
public:
    TestCppClass();
    void add(int num);
    void sub(int num);
    void print();   
};

#endif /* TestCppClass_hpp */
