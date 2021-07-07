//
//  MyAudioUnit.cpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/03.
//

#include "MyUnit.hpp"

MyUnit::MyUnit(){
    datas_ = nullptr;
    len_ = 0;
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
