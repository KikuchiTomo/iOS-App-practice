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
    var audioEngine: AVAudioEngine = AVAudioEngine()
    var mixerNode: AVAudioMixerNode!
    private var recButton: UIButton!
    private var playButton: UIButton!
    private var recState: recStateEnum = .stop
    enum recStateEnum{
        case rec, pause, stop
    }

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
        view.addSubview(playButton)
         
        // sessionの用意
        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.record)
        try? session.setActive(true, options: .notifyOthersOnDeactivation)

        // Engineの準備
        //audioEngine = AVAudioEngine()
        print("==0==")
        mixerNode = AVAudioMixerNode()
        mixerNode.volume = 0
        audioEngine.attach(mixerNode)

        print("==1==")
        // インプットからミキサーノードへ繋ぐ
        let input = audioEngine.inputNode
        let inputFormat = input.outputFormat(forBus: 0)
        audioEngine.connect(input, to: mixerNode, format: inputFormat)
        print("==2==")
        // ミキサーノードからメインミキサーノードへ
        let mainMixerNode = audioEngine.mainMixerNode
        let mixerFormat   = AVAudioFormat(commonFormat: .pcmFormatFloat32, sampleRate: inputFormat.sampleRate, channels: 1, interleaved: true)
        audioEngine.connect(mixerNode, to: mainMixerNode, format: mixerFormat)
        print("==3==")
        audioEngine.prepare()
        
        
        NSLayoutConstraint.activate([
            recButton.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            recButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            playButton.centerYAnchor.constraint(equalTo: recButton.bottomAnchor, constant: 20),
            playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
    }
    
    func startRec() throws {
        print("==A==")
        let tapNode: AVAudioNode = mixerNode
        let format = tapNode.outputFormat(forBus: 0)

        print("==B==")
        let documentURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
        let file = try AVAudioFile(forWriting: documentURL.appendingPathComponent("recording.caf"), settings: format.settings)

        print("==C==")
        tapNode.installTap(onBus: 0, bufferSize: 4096, format: format, block: {
            (buffer, time) in
            do{
               try file.write(from: buffer)
            }catch let errno{
                print("cannot write audio file : Error No : ", errno)
            }
        })

        print("==D==")

        try audioEngine.start()
        recState = .rec
    }
    
    func resumeRecording() throws {
      try audioEngine.start()
      recState = .rec
    }

    func pauseRecording() {
      audioEngine.pause()
      recState = .pause
    }

    func stopRecording() {
      // Remove existing taps on nodes
      mixerNode.removeTap(onBus: 0)
      
      audioEngine.stop()
      recState = .stop
    }
    
    @objc func recAction(_ sender: UIButton){
        print(recState)
        if(recState == .stop){
            do{
                try startRec()
            }catch{
                let dialog = UIAlertController(title: "エラ〜", message: "AVAudioEngineのstartに失敗しました", preferredStyle: .alert)
                dialog.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
                self.present(dialog, animated: true, completion: nil)
                self.navigationController?.popViewController(animated: true)
            }
        }else if(recState == .rec){
            pauseRecording()
        }
    }
}
