//
//  TestCppClass.cpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/02.
//

#include "TestCppClass.hpp"

TestCppClass::TestCppClass(){
    myNum_ = 0;
}

void TestCppClass::add(int num){
    myNum_ += num;
}

void TestCppClass::sub(int num){
    myNum_ -= num;
}

void TestCppClass::print(){
    printf("my num : %d\n", myNum_);
}
