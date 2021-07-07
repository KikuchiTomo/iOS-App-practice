//
//  MyUnit.cpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

#include "MyUnit.h"

MyUnit::MyUnit(float fs){
    fs_ = fs;
//    b_in_ = new MyBuffer(fs*2);
//    b_mid_ = new MyBuffer(fs*2);
//    b_out_ = new MyBuffer(fs*2);
    datas_ = nullptr;
    len_ = 0;
    vol_ = 5;
}

void MyUnit::reset(){
    for(int i=0; i<len_; i++) datas_[i] = 0;
    datas_ = nullptr;
    len_ = 0;
}

void MyUnit::setVol(float vol){
    vol_ = vol;
}

void MyUnit::myEffect(float *d, int len){
    for(int i=0; i<len; i++){
        d[i] *= vol_;
    }
}

float MyUnit::process(float din){
    if(th_>3.14159) th_=0;
    th_+=0.0007;
    float a = 1.0 + vol_ * sin(th_);
    return din * a;
}
