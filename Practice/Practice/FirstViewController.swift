//
//  SecondViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/19.
//

import Foundation
import UIKit

class FirstViewController: UIViewController {
    
    var msg: String = ""
    
    lazy var button: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.setTitleColor(.systemPurple, for: .normal)
        view.setTitle("next page", for: .normal)
        view.addTarget(self, action: #selector(nextPage(_:)), for: .touchDown)
        return view
    }()
    
    lazy var label: UILabel = {
        let view = UILabel.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .white
        view.text = msg
        view.textColor = .systemGray
        return view
    }()
    
    lazy var button2: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.systemPurple, for: .normal)
        view.setTitle("Map...", for: .normal)
        view.addTarget(self, action: #selector(openMap(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var button3: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("AudioTest...", for: .normal)
        view.setTitleColor(.systemPurple, for: .normal)
        view.addTarget(self, action: #selector(openAudioTestView(_:)), for: .touchUpInside)
        return view
    }()
    
    lazy var button4: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitle("AudioPlayer...", for: .normal)
        view.setTitleColor(.systemPurple, for: .normal)
        view.addTarget(self, action: #selector(openAudioPlayerView(_:)), for: .touchUpInside)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPurple
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Sub Page", style: .plain, target: nil, action: nil)
        
        view.backgroundColor = .white
        view.addSubview(button)
        view.addSubview(button2)
        view.addSubview(button3)
        view.addSubview(button4)
        view.addSubview(label)
                
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 10),
            button4.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func nextPage(_ sender: UIButton) {
        print(sender)
        let secondViewController = SecondViewController()
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
    
    @objc func openMap(_ sender: UIButton){
        let mapViewController = MapViewController.init()
        navigationController?.pushViewController(mapViewController, animated: true)
    }
    
    @objc func openAudioTestView(_ sender: UIButton){
        let audioViewController = AudioTestViewController()
        self.navigationController?.pushViewController(audioViewController, animated: true)
    }
    
    @objc func openAudioPlayerView(_ sender: UIButton){
        let audioPlayerViewController = AudioPlayerTestViewController()
        self.navigationController?.pushViewController(audioPlayerViewController, animated: true)
    }
}

