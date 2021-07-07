//
//  MyBuffer.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/03.
//

#ifndef MyBuffer_hpp
#define MyBuffer_hpp

#include <stdio.h>
#include <cstdlib>
#include <cstdio>
#include <assert.h>

class MyBuffer{
private:
    bool is_create_ = false;
    int read_index_;
    int write_index_;
    int buffer_length_;
    float *buffer_;
    
    void createBuffer(int length);
    int calcWriteMaxLength();
    int calcReadMaxLength();
    
public:
    MyBuffer(int length);
    ~MyBuffer();
    void clearBuffer(); // Buffer Clear
    void clearWithZero(int length); // Write Zeros
    void writeBuffer(float *datas, int length); // Write multiple data
    void readBuffer( float *datas, int length); // Read  multiple data
    void scanBuffer( float *datas, int length); // Scan  multiple data
    void pushBuffer( float data); // A data write
    float getBuffer(  int index);
    float popBuffer();            // A data read
    void discardBuffer(int length);
    float getBufferData(int readerIndex);
};

#endif /* MyBuffer_hpp */
