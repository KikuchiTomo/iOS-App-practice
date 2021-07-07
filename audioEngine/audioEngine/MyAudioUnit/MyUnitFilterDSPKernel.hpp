//
//  MyUniFilterDSPKernel.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

#ifndef MyUniFilterDSPKernel_hpp
#define MyUniFilterDSPKernel_hpp

#import "MyUnitDSPKernel.hpp"
#import "MyUnit.h"
#import <vector>

/*
 FilterDSPKernel
 Performs our filter signal processing.
 As a non-ObjC class, this is safe to use from render thread.
 */
class MyUnitFilterDSPKernel : public MyUnitDSPKernel {
public:
    // MARK: Types
    struct FilterState {
    };

    // MARK: Member Functions
    void init(int channelCount, double inSampleRate) {
        unsigned long int cc = static_cast<unsigned long>(channelCount);
        channelStates.resize(cc);
        keroFilter->set_scale(3);
    }

    void setBuffers(AudioBufferList* inBufferList, AudioBufferList* outBufferList) {
        inBufferListPtr = inBufferList;
        outBufferListPtr = outBufferList;
    }
    
    void setKero(bool isKero) {
        isKeroKero = isKero;
        if (!isKero) {
            keroFilter->reset();
        }
    }
    
    void reset() {
    }
    
    void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) override {
        int channelCount = int(channelStates.size());
        // For each sample
        for (int channel = 0; channel < channelCount; ++channel) {
            if (inBufferListPtr->mBuffers[channel].mData ==  outBufferListPtr->mBuffers[channel].mData) {
                continue;
            }
            for (int frameIndex = 0; frameIndex < int(frameCount); ++frameIndex) {
                int frameOffset = frameIndex + int(bufferOffset);
                float* in  = (float*)inBufferListPtr->mBuffers[channel].mData  + frameOffset;
                float* out = (float*)outBufferListPtr->mBuffers[channel].mData + frameOffset;
                if (isKeroKero) {
                    *out = keroFilter->process(*in);
                } else {
                    *out = *in;
                }
            }
        }
    }
    // MARK: Member Variables

private:
    std::vector<FilterState> channelStates;
    
    MyUnit *Filter = new MyUnit();
    bool isKeroKero = false;

    AudioBufferList* inBufferListPtr = nullptr;
    AudioBufferList* outBufferListPtr = nullptr;
};


#endif /* MyUniFilterDSPKernel_h */
