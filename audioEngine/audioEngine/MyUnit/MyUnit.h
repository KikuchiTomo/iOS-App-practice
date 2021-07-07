//
//  MyUnit.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

#ifndef MyUnit_h
#define MyUnit_h

#include <stdio.h>
#include <math.h>
#include "MyBuffer.hpp"

class MyUnit{
private:
    float *datas_;
    int len_;
    float vol_;
    float fs_;
    float th_;
    MyBuffer *b_in_;
    MyBuffer *b_out_;
    MyBuffer *b_mid_;
    
public:
    MyUnit(float fs);
    
    ~MyUnit(){}

    float process(float din);
    void setVol(float vol);
    void reset();
    void myEffect(float *d, int len);
};

#endif /* MyUnit_hpp */
