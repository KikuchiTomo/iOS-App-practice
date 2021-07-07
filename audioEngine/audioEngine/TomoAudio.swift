//
//  TomoAudio.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/06/30.
//

import Foundation
import AVFoundation

class AudioSinGenerator{
    var audioUnit: AudioUnit?
    static let sampleRate: Float = 44100.0
    static let toneA: Float = 880.0
    static var frame: Float = 0

    init () {
        prepareAudioUnit()
    }
    
    func prepareAudioUnit(){
        var audioCompDesc = AudioComponentDescription()
        audioCompDesc.componentType = kAudioUnitType_Output
        audioCompDesc.componentSubType = kAudioUnitSubType_RemoteIO
        audioCompDesc.componentManufacturer = kAudioUnitManufacturer_Apple
        audioCompDesc.componentFlags = 0
        audioCompDesc.componentFlagsMask = 0
        
        let audioComp: AudioComponent = AudioComponentFindNext(nil, &audioCompDesc)!
        AudioComponentInstanceNew(audioComp, &audioUnit)
        AudioUnitInitialize(audioUnit!)
        
        
        let renderCallback: AURenderCallback = {(
            inRefCon: UnsafeMutableRawPointer,
            ioActionFlags: UnsafeMutablePointer<AudioUnitRenderActionFlags>,
            inTimeStamp: UnsafePointer<AudioTimeStamp>,
            inBusNumber: UInt32,
            inNumberFrames: UInt32,
            ioData: UnsafeMutablePointer<AudioBufferList>?
        ) -> OSStatus in
            // チャンネルの数分のAudioBuffer参照の取り出し
            let abl = UnsafeMutableAudioBufferListPointer(ioData)
            // フレーム数分のメモリキャパシティ
            let capacity = Int(abl![0].mDataByteSize) / MemoryLayout<Float>.size
            // バッファに値を書き込む
            if let buffer: UnsafeMutablePointer<Float> = abl![0].mData?.bindMemory(to: Float.self, capacity: capacity) {
                for i: Int in 0 ..< Int(inNumberFrames) {
                    // サイン波を生成
                    buffer[i] = sin(AudioSinGenerator.frame * AudioSinGenerator.toneA * 2.0 * Float(Double.pi) / AudioSinGenerator.sampleRate)
                    AudioSinGenerator.frame += 1
                }
            }
            
            return noErr
        }
        
        var callbackStruct: AURenderCallbackStruct = AURenderCallbackStruct(
            inputProc: renderCallback,
            inputProcRefCon: &audioUnit
        )

        // コールバック関数の設定
        AudioUnitSetProperty(
            audioUnit!,
            kAudioUnitProperty_SetRenderCallback,
            kAudioUnitScope_Input,
            0,
            &callbackStruct,
            UInt32(MemoryLayout.size(ofValue: callbackStruct))
        )
        
        // ASBDの作成
        var asbd = AudioStreamBasicDescription()
        asbd.mSampleRate = Float64(AudioSinGenerator.sampleRate)
        asbd.mFormatID = kAudioFormatLinearPCM
        asbd.mFormatFlags = kAudioFormatFlagIsFloat
        asbd.mChannelsPerFrame = 1
        asbd.mBytesPerPacket = UInt32(MemoryLayout<Float32>.size)
        asbd.mBytesPerFrame = UInt32(MemoryLayout<Float32>.size)
        asbd.mFramesPerPacket = 1
        asbd.mBitsPerChannel = UInt32(8 * MemoryLayout<UInt32>.size)
        asbd.mReserved = 0

        // AudioUnitにASBDを設定
        AudioUnitSetProperty(
            audioUnit!,
            kAudioUnitProperty_StreamFormat,
            kAudioUnitScope_Input,
            0,
            &asbd,
            UInt32(MemoryLayout.size(ofValue: asbd))
        )
    }
    /// 再生スタート
    func start() {
        AudioSinGenerator.frame = 0
        AudioOutputUnitStart(audioUnit!) // Remote IO Unit 出力開始
        print("start")
    }

    /// 再生ストップ
    func stop() {
        AudioOutputUnitStop(audioUnit!) // Remote IO Unit 出力停止
        print("stop")
    }
    
    func dispose() {
        AudioUnitUninitialize(audioUnit!)
        AudioComponentInstanceDispose(audioUnit!)
    }
}
