//
//  RecordView.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/26.
//

import Foundation
import UIKit
import AVFoundation

class RecordView: UIViewController{
    private var audioEngine: AVAudioEngine!
    private var audioFile: AVAudioFile!
    private var audioPlayerNode: AVAudioPlayerNode = AVAudioPlayerNode.init()

    private var recButton: UIButton!
    private var playButton: UIButton!
    private var filePath: String!
    private var recState: recStateEnum = .stop

    enum recStateEnum{
        case rec, pause, stop
    }

    let format = AVAudioFormat(
        commonFormat: AVAudioCommonFormat.pcmFormatFloat32,
        sampleRate: 44100,
        channels: 1,
        interleaved: true)
    
    override func viewDidLoad() {
        super.viewDidLoad();
        view.backgroundColor = .white
        
        recButton = UIButton()
        recButton.translatesAutoresizingMaskIntoConstraints = false
        recButton.setTitle("Rec & Stop", for: .normal)
        recButton.setTitleColor(.systemPurple, for: .normal)
        recButton.addTarget(self, action: #selector(recAction(_:)), for: .touchUpInside)
        view.addSubview(recButton)
        
        playButton = UIButton()
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.setTitle("Play & Stop", for: .normal)
        playButton.setTitleColor(.systemPurple, for: .normal)
        playButton.addTarget(self, action: #selector(playAction(_:)), for: .touchUpInside)
        view.addSubview(playButton)
        
        InitAudioEngineRecord()
        openAlert(title: "s", msg: "w", button: "s")
        NSLayoutConstraint.activate([
            recButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            recButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            playButton.centerYAnchor.constraint(equalTo: recButton.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    
    func InitAudioEngineRecord(){
        let audioSession = AVAudioSession.sharedInstance()
        print("available input: \(String(describing: audioSession.availableInputs))")
        print("preferred input: \(audioSession.preferredInput)")

        openAlert(title: "INPUTS", msg: "available input: \(String(describing: audioSession.currentRoute.inputs)) , \(String(describing: audioSession.inputDataSources))", button: "OK")

        do {
            let input: AVAudioSessionPortDescription = audioSession.availableInputs![0]
            let result: () = try audioSession.setPreferredInput(input)
            debugAlert(msg:"setPreferredInput result: \(result)")
            debugAlert(msg:"session.currentRoute.inputs: \(audioSession.currentRoute.inputs)")
            try audioSession.setCategory(.playAndRecord)
            try audioSession.setActive(true)
            //try audioSession.overrideOutputAudioPort(.speaker)
        }catch let error{
            print(error)
            self.navigationController?.popViewController(animated: true)
        }
        
        
        audioEngine = AVAudioEngine.init()
        audioEngine.reset()
        // マイク
        print(getAudioFileUrl())
        
        do{
            self.audioFile = try AVAudioFile(
                forWriting: getAudioFileUrl(),
                settings: format!.settings)
        }catch let error{
            print("cannot creat audio File : ", error)
         
        }
        
        let inputNode = audioEngine.inputNode
        
        if(inputNode.inputFormat(forBus: 0).channelCount == 0){
            print("Not enough available inputs!")
            return
        }
        let recFormat = inputNode.inputFormat(forBus: 0)
        inputNode.installTap(onBus: 0, bufferSize: 4049, format: recFormat, block:{
            (buffer, when) in
            do{
                for port in audioSession.currentRoute.inputs{
                    if (port.portType ==  AVAudioSession.Port.headsetMic){
                       try self.audioFile.write(from: buffer)
                    }
                   
                }
                
            }catch let error{
                print("cannot write audio file : ", error)
            }
        })
        
        
        audioEngine.prepare()
    }
    
    
    func getAudioFileUrl() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        print(paths)
        let docsDirect = paths[0]
        let audioUrl = docsDirect.appendingPathComponent("recording.caf")

        return audioUrl
    }
    
    func playSoundFile(){
        do{
            audioFile = try AVAudioFile(
                forReading: getAudioFileUrl())
        }catch{
            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : get (AVAudioFile) audioFile")
            return
        }
        
        do{
            audioEngine.attach(audioPlayerNode)
            audioEngine.connect(audioPlayerNode, to: audioEngine.mainMixerNode, format: format)
            try audioEngine.start()
            audioEngine.prepare()
        }catch{
            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : connect AVAudioPlayerNode")
            return
        }
        
        //audioFilePlayer.play()
    }
    
    func openAlert(title: String, msg: String, button: String){
        let dialog = UIAlertController(title: title, message: msg, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: button, style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }
    
    func debugAlert(msg: String){
        let dialog = UIAlertController(title: "DEBUG", message: msg, preferredStyle: .alert)
        dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(dialog, animated: true, completion: nil)
    }

    @objc func recAction(_ sender: UIButton){
        if(recState == .stop){
            recState = .rec
            recButton.setTitle("Stop", for: .normal)
            do{
                try audioEngine.start()
            }catch let error{
                print("cannot start audio engine : ", error)
            }
        }else{
            recButton.setTitle("Stopped", for: .normal)
            audioEngine.stop()
            recState = .pause
            audioEngine.inputNode.removeTap(onBus: 0)
            playSoundFile()
        }
    }
    
    @objc func playAction(_ sender: UIButton){
        if(recState == .pause && audioPlayerNode.isPlaying){
            playButton.setTitle("Stop", for: .normal)
            audioPlayerNode.stop()
        }else if(recState == .pause && !audioPlayerNode.isPlaying){
            playButton.setTitle("Stopped", for: .normal)
            audioPlayerNode.stop()
            audioPlayerNode.scheduleFile(
                audioFile!,
                at: nil,
                completionCallbackType: .dataPlayedBack){
                (callback) in
                print(self.audioPlayerNode.isPlaying)
            }
            audioPlayerNode.play()
            playButton.setTitle("Stop", for: .normal)
        }
    }
}
