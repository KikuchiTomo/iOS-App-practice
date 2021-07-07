//
//  MyBuffer.cpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/03.
//

#include "MyBuffer.hpp"

MyBuffer::MyBuffer(int length){
    createBuffer(length);
    clearBuffer();
}

int MyBuffer::calcWriteMaxLength(){
    // 書き込める長さを求める
    int remain_write_length = write_index_ - read_index_ + buffer_length_;
    remain_write_length    %= buffer_length_;
    return remain_write_length;
}

int MyBuffer::calcReadMaxLength(){
    // 読み込める長さを求める
    int remain_read_length = buffer_length_ - calcWriteMaxLength() - 1;
    return remain_read_length;
}

void MyBuffer::createBuffer(int length){
    // バッファを生成
    if(is_create_) return;
    buffer_ = new float[length];
    buffer_length_ = length;
    is_create_ = true;
}

void MyBuffer::clearBuffer(){
    // ゼロ詰めしてクリア
    read_index_ = 0;
    write_index_ = 0;
    for(int i=0; i<buffer_length_; i++) buffer_[i] = 0;
}

void MyBuffer::clearWithZero(int length){
    // 指定の長さ分をバッファの先頭からゼロ詰め
    if(write_index_<length) length = write_index_;
    for(int i=0; i<length; i++) buffer_[i] = 0;
}

void MyBuffer::writeBuffer(float *datas, int length){
    if(length>calcWriteMaxLength()){
        printf("Over size write.\n");
        return;
    }
    // リングバッファなのではみ出した分は，先頭から書き込む
    for(int i=0; i<length; i++)
        buffer_[(write_index_+i)%buffer_length_] = datas[i];
    // 書き込みindexを書き込んだ分進める
    write_index_ = (write_index_+length)%buffer_length_;
}

void MyBuffer::readBuffer(float *datas, int length){
    scanBuffer(datas, length);
    // 読み込みindexを読み込んだ分戻す
    read_index_ = (read_index_ + length) % buffer_length_;
}

/* 読み込むだけ */
void MyBuffer::scanBuffer(float *datas, int length){
    if(length>calcReadMaxLength()){
         printf("Over size write.\n");
         return;
     }
     // リングバッファなのではみ出した分は，先頭から読み込む
    for(int i=0; i<length; i++) datas[i] = buffer_[(read_index_+i)%buffer_length_];
}

void MyBuffer::pushBuffer(float data){
    writeBuffer(&data, 1);
}

float MyBuffer::popBuffer(){
    float data = 0;
    readBuffer(&data, 1);
    return data;
}

void MyBuffer::discardBuffer(int length){
    if(length > calcReadMaxLength()){
        printf("Over size read");
        return;
    }
    read_index_ = ( read_index_ + length ) % buffer_length_;
}

float MyBuffer::getBuffer(int index){
    if(index > calcReadMaxLength() -1 ){
        return -1;
    }
    int idx = ( index + read_index_ ) % buffer_length_;
    return buffer_[idx];
}
