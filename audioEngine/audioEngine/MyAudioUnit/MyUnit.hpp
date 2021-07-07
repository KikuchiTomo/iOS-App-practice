//
//  MyAudioUnit.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/03.
//

#ifndef MyUnit_hpp
#define MyUnit_hpp

#include <stdio.h>
//#include "MyBuffer.hpp"

class MyUnit{
private:
    float *datas_;
    int len_;
    float vol_;
public:
    MyUnit();
    
    ~MyUnit(){}

    void setVol(float vol);
    void reset();
    void myEffect(float *d, int len);
};

#endif /* MyAudioUnit_hpp */
