//
//  ViewController.swift
//  MyAudioEngine
//
//  Created by TomoKikuchi on 2021/06/26.
//

//#e37222
//#07889b
//#66b9bf
//#eeaa7b

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor(hex: "eeaa7b")
        
        self.navigationController?.navigationBar.tintColor = UIColor(hex: "66b9bf")
        self.navigationItem.title = "Home"
        self.navigationItem.backBarButtonItem = UIBarButtonItem(title: "Home", style: .plain, target: nil, action: nil)
        
    }


}

