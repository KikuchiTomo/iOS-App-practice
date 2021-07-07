//
//  MyUnitFilterDSPKernelAdapter.mm
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

#import <AVFoundation/AVFoundation.h>
#import <CoreAudioKit/AUViewController.h>
#import "MyUnitFilterDSPKernel.hpp"
#import "BufferedAudioBus.hpp"
#import "MyUnitFilterDSPKernelAdapter.h"

@implementation MyUnitFilterDSPKernelAdapter {
    // C++ members need to be ivars; they would be copied on access if they were properties.
    MyUnitFilterDSPKernel  _kernel;
    BufferedInputBus _inputBus;
}

- (instancetype)init {

    if (self = [super init]) {
        AVAudioFormat *format = [[AVAudioFormat alloc] initStandardFormatWithSampleRate:44100 channels:2];
        // Create a DSP kernel to handle the signal processing.
        _kernel.init(int(format.channelCount), format.sampleRate);
        
        // Create the input and output busses.
        _inputBus.init(format, 8);
        _outputBus = [[AUAudioUnitBus alloc] initWithFormat:format error:nil];
    }
    return self;
}

- (AUAudioUnitBus *)inputBus {
    return _inputBus.bus;
}

- (void)setMyUnit:(Boolean)isMyUnit {
    _kernel.setMyUnit(isMyUnit);
}

- (void)reset {
    _kernel.reset();
}

- (AUAudioFrameCount)maximumFramesToRender {
    return _kernel.maximumFramesToRender();
}

- (void)setMaximumFramesToRender:(AUAudioFrameCount)maximumFramesToRender {
    _kernel.setMaximumFramesToRender(maximumFramesToRender);
}

- (void)allocateRenderResources {
    _inputBus.allocateRenderResources(self.maximumFramesToRender);
    _kernel.init(int(self.outputBus.format.channelCount), self.outputBus.format.sampleRate);
}

- (void)deallocateRenderResources {
    _inputBus.deallocateRenderResources();
}

#pragma mark - AUAudioUnit (AUAudioUnitImplementation)

// Subclassers must provide a AUInternalRenderBlock (via a getter) to implement rendering.
- (AUInternalRenderBlock)internalRenderBlock {
    /*
     Capture in locals to avoid ObjC member lookups. If "self" is captured in
     render, we're doing it wrong.
     */
    // Specify captured objects are mutable.
    __block MyUnitFilterDSPKernel *state = &_kernel;
    __block BufferedInputBus *input = &_inputBus;

    return Block_copy(^AUAudioUnitStatus(AudioUnitRenderActionFlags *actionFlags,
                              const AudioTimeStamp       *timestamp,
                              AVAudioFrameCount           frameCount,
                              NSInteger                   outputBusNumber,
                              AudioBufferList            *outputData,
                              const AURenderEvent        *realtimeEventListHead,
                              AURenderPullInputBlock      pullInputBlock) {

        AudioUnitRenderActionFlags pullFlags = 0;

        if (frameCount > state->maximumFramesToRender()) {
            return kAudioUnitErr_TooManyFramesToProcess;
        }

        AUAudioUnitStatus err = input->pullInput(&pullFlags, timestamp, frameCount, 0, pullInputBlock);

        if (err != 0) { return err; }

        AudioBufferList *inAudioBufferList = input->mutableAudioBufferList;

        /*
         Important:
         If the caller passed non-null output pointers (outputData->mBuffers[x].mData), use those.
         If the caller passed null output buffer pointers, process in memory owned by the Audio Unit
         and modify the (outputData->mBuffers[x].mData) pointers to point to this owned memory.
         The Audio Unit is responsible for preserving the validity of this memory until the next call to render,
         or deallocateRenderResources is called.
         If your algorithm cannot process in-place, you will need to preallocate an output buffer
         and use it here.
         See the description of the canProcessInPlace property.
         */

        // If passed null output buffer pointers, process in-place in the input buffer.
        AudioBufferList *outAudioBufferList = outputData;
        if (outAudioBufferList->mBuffers[0].mData == nullptr) {
            for (UInt32 i = 0; i < outAudioBufferList->mNumberBuffers; ++i) {
                outAudioBufferList->mBuffers[i].mData = inAudioBufferList->mBuffers[i].mData;
            }
        }

        state->setBuffers(inAudioBufferList, outAudioBufferList);
        state->processWithEvents(timestamp, frameCount, realtimeEventListHead, nil /* MIDIOutEventBlock */);
        
        return noErr;
    });
}

@end
