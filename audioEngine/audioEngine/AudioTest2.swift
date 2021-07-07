//
//  AudioTest2.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/07/02.
//


import Foundation
import AVFoundation

class AudioTest2: NSObject{
    var audioUnit: AudioUnit?
    private var audioEngine: AVAudioEngine     = AVAudioEngine()
    private var audioMixer: AVAudioMixerNode   = AVAudioMixerNode()
    private var audioPlayer: AVAudioPlayerNode = AVAudioPlayerNode()
    private var effectAudioUnit: AVAudioUnit   = AVAudioUnit()
    private var micMuteNode: AVAudioMixerNode  = AVAudioMixerNode()
    private var nowVol: Float = 0.0
    private var isFilter = false;
    
    private enum AudioState{
        case playing
        case stopped
        case muted
        case paused
    }

    private enum OutputDir{
        case speaker
        case headphones
        case buletooth
    }

    private var audioState: AudioState = .stopped
    private var outputDir: OutputDir = .speaker

    override init(){
        super.init()
        setupAudioUnit()
    }

    private func setupAudioUnit(){
        // Componentの構造を指定
        var audioCompDesc = AudioComponentDescription()
        audioCompDesc.componentType         = kAudioUnitType_Effect
        audioCompDesc.componentSubType      = 0x004247
        audioCompDesc.componentManufacturer = 0x424d43
        audioCompDesc.componentFlags        = 0
        audioCompDesc.componentFlagsMask    = 0

        let compName = "MyAudioUnit"
        AUAudioUnit.registerSubclass(AUMyUnitFilter.self, as: audioCompDesc, name: compName, version: UInt32.max)
        // オーディオユニットコンポーネントのインスタンスを非同期的に作成
        AVAudioUnit.instantiate(with: audioCompDesc){ audioUnit, error in
            guard error == nil, let audioUnit = audioUnit
            else {
                print("Error : Cannot instantiate audioUnit")
                return;
            }
            self.effectAudioUnit = audioUnit
        }
        
        effectAudioUnit.auAudioUnit.currentPreset = effectAudioUnit.auAudioUnit.factoryPresets![0]

        audioEngine.attach(effectAudioUnit)
        audioEngine.attach(audioMixer)
        audioEngine.attach(micMuteNode)
        audioEngine.attach(audioPlayer)

        self.connect()

        audioState = .muted
        audioMixer.volume = 0
        
        (effectAudioUnit.auAudioUnit as! AUMyUnitFilter).setMyUnit(isMyUnit: true)
       
        return;
    }

    public func toggleFilter(tg: Bool){
        (effectAudioUnit.auAudioUnit as! AUMyUnitFilter).setMyUnit(isMyUnit: tg)
    }
    
    private func connect(){
        //let format = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatFloat32, sampleRate: 48000.0, channels: 1, interleaved: true)
        let hardwareSampleRate = audioEngine.inputNode.inputFormat(forBus: 0).sampleRate
        let format = AVAudioFormat(commonFormat: AVAudioCommonFormat.pcmFormatFloat32, sampleRate: hardwareSampleRate, channels: 1, interleaved: true)
        //let format = audioEngine.inputNode.inputFormat(forBus: 0)
        //print("\(format)")
        audioEngine.connect(audioEngine.inputNode, to: effectAudioUnit, format: format)
        //audioEngine.connect(micMuteNode, to: effectAudioUnit, format: format)
        //audioEngine.connect(effectAudioUnit, to: audioPlayer, format: format)
        //audioEngine.connect(audioMixer, to: audioPlayer, format: format)
        audioEngine.connect(effectAudioUnit, to: audioEngine.mainMixerNode, format: format)
    }

    func getAudioFileUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.caf")

        return audioUrl
    }
    
    public func start(){
        do{
            try audioEngine.start()
        }catch{
            print("Error : Cannot start AVAudioEngine")
        }
    }

    public func stop(){
        audioEngine.stop()
    }

    public func mute(isMute: Bool){
        if(isMute){
            nowVol = audioMixer.volume
            audioMixer.volume = 0
        }else{
            audioMixer.volume = nowVol
        }
    }

//    public func playRecData(){
//        do{
//            var audioFile: AVAudioFile = try AVAudioFile(forReading: getAudioFileUrl())
//        }catch{
//            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : get (AVAudioFile) audioFile")
//            return
//        }
//
//        do{
//
//        }catch{
//    }
    
    public func controllOutputVol(vol: Float){
        audioMixer.volume = vol
    }
}



