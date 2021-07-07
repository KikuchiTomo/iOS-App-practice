//
//  AudioPlayerTesrViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/22.
//

import UIKit
import AVFoundation

class AudioPlayerTestViewController: UIViewController{
    
    private var audioEngine: AVAudioEngine = AVAudioEngine()
    private var audioFile : AVAudioFile?
    private var audioFilePlayer : AVAudioPlayerNode = AVAudioPlayerNode()
    
    private let audioFileName: String = "noraneko"
    private let audioFileType: String = "mp3"
    
    lazy var button: UIButton = {
        let view = UIButton()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("Play and Pause", for: .normal)
        view.setTitleColor(.systemPurple, for: .normal)
        view.addTarget(self, action: #selector(playAndPause(_:)), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        playSoundFile(FileName: "noraneko", FileType: "mp3")
        view.addSubview(button)
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo:  view.centerYAnchor, constant: 0),
            button.centerXAnchor.constraint(equalTo:  view.centerXAnchor, constant: 0)
        ])
    }
    
    func playSoundFile(FileName: String, FileType: String){
        guard let soundFileURL = Bundle.main.url(forResource: FileName, withExtension: FileType) else {
            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : get sound file URL")
            return
        }
        
        print(soundFileURL)
        do{
            audioFile = try AVAudioFile(forReading: soundFileURL)
        }catch{
            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : get (AVAudioFile) audioFile")
            return
        }
        
        do{
            audioEngine.attach(audioFilePlayer)
            audioEngine.connect(audioFilePlayer, to: audioEngine.mainMixerNode, format: audioFile!.processingFormat)
            try audioEngine.start()
            audioEngine.prepare()
        }catch{
            print("[ERROR]: (function) playSoundFile in [AudioPlayerTestViewController: AVAudioPlayerDelegate] : connect AVAudioPlayerNode")
            return
        }
        
        //audioFilePlayer.play()
    }
    
    @objc func playAndPause(_ sender: UIButton){
        if audioFilePlayer.isPlaying {
            audioFilePlayer.pause()
            
            button.setTitle("PLAY", for: .normal)
            
        }else {
            
            audioFilePlayer.stop()
            // プレイヤのスケジュール
            audioFilePlayer.scheduleFile(audioFile!, at: nil, completionCallbackType: .dataPlayedBack) { (callback) in
                print(self.audioFilePlayer.isPlaying)
            }
            
            audioFilePlayer.play()
            
            button.setTitle("PAUSE", for: .normal)
            
            
        }
    }
}
