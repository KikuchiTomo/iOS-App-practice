//
//  AudioTestViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/22.
//

import UIKit
import AVFoundation

class AudioTestViewController: UIViewController{
    
    private var audioEngine: AVAudioEngine!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        audioEngine = AVAudioEngine.init()
        audioEngine.mainMixerNode.outputVolume = 10
        audioEngine.connect(audioEngine.inputNode, to: audioEngine.mainMixerNode, format:audioEngine.inputNode.outputFormat(forBus: 0))
        do {
            try audioEngine.start()
        } catch {
            print("cannot start audioEngine")
            print(error)
        }
    }
}
