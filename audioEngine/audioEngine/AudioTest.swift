////
////  AudioTest.swift
////  audioEngine
////
////  Created by TomoKikuchi on 2021/06/30.
////
//
//import Foundation
//import AVFoundation
//
//class AudioTest: NSObject{
//    var audioUnit: AudioUnit?
//    private var audioEngine: AVAudioEngine     = AVAudioEngine()
//    private var audioMixer: AVAudioMixerNode   = AVAudioMixerNode()
//    private var audioPlayer: AVAudioPlayerNode = AVAudioPlayerNode()
//    private var effectAudioUnit: AVAudioUnit   = AVAudioUnit()
//    private var micMuteNode: AVAudioMixerNode  = AVAudioMixerNode()
//    private var nowVol: Float = 0.0
//    
//    private enum AudioState{
//        case playing
//        case stopped
//        case muted
//        case paused
//    }
//    
//    private enum OutputDir{
//        case speaker
//        case headphones
//        case buletooth
//    }
//    
//    private var audioState: AudioState = .stopped
//    private var outputDir: OutputDir = .speaker
//    
//    override init(){
//        setupEffectAudioUnit()
//    }
//    
//    private func setupEffectAudioUnit(){
//        
//        // prepare AudioUnit
//        var audioCompDesc = AudioComponentDescription()
//        audioCompDesc.componentType         = kAudioUnitType_Effect
//        audioCompDesc.componentSubType      = 0xAAAAAA
//        audioCompDesc.componentManufacturer = 0xA0A0A0
//        audioCompDesc.componentFlags        = 0
//        audioCompDesc.componentFlagsMask    = 0
//
//        let compName = "MyEffect"
//        AUAudioUnit.registerSubclass(<#T##cls: AnyClass##AnyClass#>, as: audioCompDesc, name: compName, version: UInt32.max)
//        // オーディオユニットコンポーネントのインスタンスを非同期的に作成
//        AVAudioUnit.instantiate(with: audioCompDesc){ audioUnit, error in
//            guard error == nil, let audioUnit = audioUnit
//            else {
//                print("Error : Cannot instantiate audioUnit")
//            }
//            self.effectAudioUnit = audioUnit
//        }
//        
//        effectAudioUnit.auAudioUnit.currentPreset = effectAudioUnit.auAudioUnit.factoryPresets![0]
//        
//        audioEngine.attach(effectAudioUnit)
//        audioEngine.attach(audioMixer)
//        audioEngine.attach(micMuteNode)
//        audioEngine.attach(audioPlayer)
//        
//        self.connect()
//
//        audioState = .muted
//        audioMixer.volume = 0
//    }
//    
//    private func connect(){
//        let format = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatFloat32, sampleRate: 48000.0, channels: 1, interleaved: true)
//        audioEngine.connect(audioEngine.inputNode, to: micMuteNode, format: format)
//        audioEngine.connect(micMuteNode, to: effectAudioUnit, format: format)
//        audioEngine.connect(effectAudioUnit, to: audioMixer, format: format)
//        audioEngine.connect(audioMixer, to: audioPlayer, format: format)
//        audioEngine.connect(audioPlayer, to: audioEngine.mainMixerNode, format: format)
//    }
//    
//    public func play(){
//        do{
//            try audioEngine.start()
//        }catch{
//            print("Error : Cannot start AVAudioEngine")
//        }
//    }
//    
//    public func stop(){
//        audioEngine.stop()
//    }
//    
//    public func mute(isMute: Bool){
//        if(isMute){
//            nowVol = audioMixer.volume
//            audioMixer.volume = 0
//        }else{
//            audioMixer.volume = nowVol
//        }
//    }
//    
//    public func controllOutputVol(vol: Float){
//        audioMixer.volume = vol
//    }
//}
//    
//   
//
