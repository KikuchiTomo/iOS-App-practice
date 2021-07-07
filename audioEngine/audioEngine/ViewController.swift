//
//  ViewController.swift
//  audioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

import UIKit

class ViewController: UIViewController {
    enum PlayState {
        case playing
        case stoped
        case paused
    }
    
    enum MuteState {
        case muted
        case not_mute
    }
    
    private var playSlider = UISlider()
    private var playButton = UIButton()
    private var muteButton = UIButton()
    private var effectButton = UIButton()
    private var efctSelector = UIPickerView()
    private var playState: PlayState = .stoped
    private var muteState: MuteState = .muted
    private var myAudioGenerator: AudioSinGenerator = AudioSinGenerator.init()
    private var myAudio: AudioTest2 = AudioTest2.init()
    private var efctState: Bool = false;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        view.addSubview(playButton)
        view.addSubview(effectButton)
        view.addSubview(muteButton)

        createPlayButton()
        createEffectButton()
        createMuteButton()
        
//        let objcpp = TestObjCppClass()
//        objcpp.add(12)
//        objcpp.print()
//        objcpp.sub(20)
//        objcpp.print()
    }

    func changeColorPlessed(button : UIButton, type: String, pless: Bool){
        button.backgroundColor = Color(num: 0)
        let str: String = pless ? type+"_w" : type
        print(str)
        let color: UIColor = pless ?  UIColor(hex: "2e2e2e", alpha: 0.9) : UIColor(hex: "f2f2f2", alpha: 0.9)
        let icon_image = UIImage(named: str)
        button.backgroundColor = color
        button.setImage(icon_image, for: .normal)
        print(button)
    }
    
    func createPlayButton(){
        changeColorPlessed(button: playButton, type: "play", pless: false)
        playButton.contentEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        playButton.layer.cornerRadius = 15
        playButton.layer.borderWidth = 0
        playButton.translatesAutoresizingMaskIntoConstraints = false
        playButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        playButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        playButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/6.0).isActive = true
        playButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/6.0).isActive = true
        playButton.imageView?.contentMode = .scaleAspectFit
        playButton.contentHorizontalAlignment = .fill
        playButton.contentVerticalAlignment = .fill
        playButton.addTarget(self, action: #selector(playButtonAction(_:)), for: .touchUpInside)
    }
    
    func createStopButton(){
        
    }
    
    func createMuteButton(){
        changeColorPlessed(button: muteButton, type: "mic_mute", pless: false)
        muteButton.contentEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        muteButton.layer.cornerRadius = 15
        muteButton.layer.borderWidth = 0
        muteButton.translatesAutoresizingMaskIntoConstraints = false
        muteButton.rightAnchor.constraint(equalTo: playButton.leftAnchor, constant: -15).isActive = true
        muteButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        muteButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/8.0).isActive = true
        muteButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/8.0).isActive = true
        muteButton.imageView?.contentMode = .scaleAspectFit
        muteButton.contentHorizontalAlignment = .fill
        muteButton.contentVerticalAlignment = .fill
        muteButton.addTarget(self, action: #selector(muteButtonAction(_:)), for: .touchUpInside)
    }
    
    func createEffectButton(){
        changeColorPlessed(button: effectButton, type: "slide_sw", pless: false)
        effectButton.contentEdgeInsets = UIEdgeInsets(top: 25, left: 25, bottom: 25, right: 25)
        effectButton.layer.cornerRadius = 15
        effectButton.layer.borderWidth = 0
        effectButton.translatesAutoresizingMaskIntoConstraints = false
        effectButton.leftAnchor.constraint(equalTo: playButton.rightAnchor, constant: 15).isActive = true
        effectButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        effectButton.widthAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/8.0).isActive = true
        effectButton.heightAnchor.constraint(equalTo: view.heightAnchor, multiplier: 1.0/8.0).isActive = true
        effectButton.imageView?.contentMode = .scaleAspectFit
        effectButton.contentHorizontalAlignment = .fill
        effectButton.contentVerticalAlignment = .fill
        effectButton.addTarget(self, action: #selector(effectButtonAction(_:)), for: .touchUpInside)
    }
    
    func createEffectSlector(){
        
    }
    
    func createPlaySlider(){
        
    }
    
    @objc func playButtonAction(_ sender: UIButton){
        if(playState == .paused){
            changeColorPlessed(button: playButton, type: "pause", pless: false)
            playState = .playing
            myAudio.start();
        }else if(playState == .stoped){
            changeColorPlessed(button: playButton, type: "pause", pless: false)
            playState = .playing
            myAudio.start();
        }else if(playState == .playing){
            changeColorPlessed(button: playButton, type: "play", pless: false)
            playState = .paused
            myAudio.stop()
        }
    }
    
    @objc func muteButtonAction(_ sender: UIButton){
        if(muteState == .muted){
            changeColorPlessed(button: muteButton, type: "mic", pless: false)
            muteState = .not_mute
        }else{
            changeColorPlessed(button: muteButton, type: "mic_mute", pless: false)
            muteState = .muted
        }
    }
    
    @objc func effectButtonAction(_ sender: UIButton){
        if(efctState == false){
            changeColorPlessed(button: effectButton, type: "slide_sw", pless: false)
            efctState = true;
        }else{
            changeColorPlessed(button: effectButton, type: "slide_sw_on", pless: false)
            efctState = false;
        }
        myAudio.toggleFilter(tg: efctState);
    }
}

