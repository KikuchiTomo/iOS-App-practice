//
//  DSPKernel.hpp
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/07.
//

#ifndef MyUnitDSPKernel_hpp
#define MyUnitDSPKernel_hpp

#import <AudioToolbox/AudioToolbox.h>
#import <algorithm>

// Put your DSP code into a subclass of DSPKernel.
class MyUnitDSPKernel {
public:
    virtual void process(AUAudioFrameCount frameCount, AUAudioFrameCount bufferOffset) = 0;
    
    // Override to handle MIDI events.
    virtual void handleMIDIEvent(AUMIDIEvent const& midiEvent) {}

    void processWithEvents(AudioTimeStamp const* timestamp, AUAudioFrameCount frameCount, AURenderEvent const* events, AUMIDIOutputEventBlock midiOut);

    AUAudioFrameCount maximumFramesToRender() const {
        return maxFramesToRender;
    }

    void setMaximumFramesToRender(const AUAudioFrameCount &maxFrames) {
        maxFramesToRender = maxFrames;
    }

private:
    void handleOneEvent(AURenderEvent const* event);
    void performAllSimultaneousEvents(AUEventSampleTime now, AURenderEvent const*& event, AUMIDIOutputEventBlock midiOut);

    AUAudioFrameCount maxFramesToRender = 512;
};


#endif /* DSPKernel_h */
