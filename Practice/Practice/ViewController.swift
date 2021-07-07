//
//  ViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/19.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate {
    let view_width = UIScreen.main.bounds.width
    let view_height = UIScreen.main.bounds.height
    var msg: String = ""
    
    let label: UILabel = {
        let view = UILabel.init()
        view.text = "Hello World!"
        view.textColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var imgView: UIImageView = {
        let img_view = UIImageView(image: UIImage(named: "sample"))
        let img_width = img_view.image!.size.width
        let img_height = img_view.image!.size.height

        let scale: CGFloat = 0.6
        let img_per_view = view_width / img_width
        let size_width: CGFloat = CGFloat(img_width*img_per_view) * scale
        let size_height: CGFloat = CGFloat(img_height*img_per_view) * scale
        let rect: CGRect = CGRect(x: 0, y: 0, width: size_width, height: size_height)
        
        img_view.layer.borderWidth = 0
        img_view.layer.cornerRadius = 10
        img_view.layer.masksToBounds = true
        img_view.frame  = rect
        img_view.center = CGPoint(x: view_width/2, y: view_height/2 - 150)
        return img_view
    }()

    lazy var button1: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Modal..", for: .normal)
        view.addTarget(self, action: #selector(openModal(_:)), for: .touchDown)
        return view
    }()
    
    lazy var button2: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Navigation..", for: .normal)
        view.addTarget(self, action: #selector(nextPage(_:)), for: .touchUpInside)
        return view
    }()
    
    var button3: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.setTitleColor(.white, for: .normal)
        view.setTitle("Done...", for: .normal)
        view.addTarget(self, action: #selector(getText(_:)), for: .touchUpInside)
        return view
    }()

    lazy var button4: UIButton = {
           let view = UIButton.init()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.setTitleColor(.white, for: .normal)
           view.setTitle("Alert1..", for: .normal)
           view.addTarget(self, action: #selector(openAlert1(_:)), for: .touchUpInside)
           return view
       }()
    
    lazy var button5: UIButton = {
           let view = UIButton.init()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.setTitleColor(.white, for: .normal)
           view.setTitle("Alert2..", for: .normal)
           view.addTarget(self, action: #selector(openAlert2(_:)), for: .touchUpInside)
           return view
       }()
    
    lazy var button6: UIButton = {
           let view = UIButton.init()
           view.translatesAutoresizingMaskIntoConstraints = false
           view.setTitleColor(.white, for: .normal)
           view.setTitle("Notification..", for: .normal)
           view.addTarget(self, action: #selector(sendNotifi(_:)), for: .touchUpInside)
           return view
    }()
    
    lazy var textFiled: UITextField = {
        let view = UITextField.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.text = msg
        view.backgroundColor = .white
        view.textColor = .systemPurple
        view.layer.cornerRadius = 5
        view.clipsToBounds = true
        view.placeholder = "input message"
        view.returnKeyType = .done
        view.clearButtonMode = .always
        view.borderStyle = .roundedRect
        view.keyboardType = .default
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPurple
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "MainPage", style: .plain, target: nil, action: nil)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "rec-step2"))
        
        let loadTxt = UserDefaults.standard.string(forKey: "my-txt0") ?? "None"
        print(loadTxt)
        self.msg = loadTxt
        
        textFiled.delegate = self
        self.view.addSubview(label)
        self.view.addSubview(imgView)
        self.view.addSubview(button1)
        self.view.addSubview(button2)
        self.view.addSubview(button3)
        self.view.addSubview(button4)
        self.view.addSubview(button5)
        self.view.addSubview(button6)
        self.view.addSubview(textFiled)
        
        NSLayoutConstraint.activate([
            label.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            button1.topAnchor.constraint(equalTo: label.bottomAnchor, constant: 10),
            button1.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button2.topAnchor.constraint(equalTo: button1.bottomAnchor, constant: 10),
            button2.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            textFiled.topAnchor.constraint(equalTo: button2.bottomAnchor, constant: 10),
            textFiled.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button3.topAnchor.constraint(equalTo: textFiled.bottomAnchor, constant: 4),
            button3.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button4.topAnchor.constraint(equalTo: button3.bottomAnchor, constant: 4),
            button4.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button5.topAnchor.constraint(equalTo: button4.bottomAnchor, constant: 4),
            button5.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            button6.topAnchor.constraint(equalTo: button5.bottomAnchor, constant: 4),
            button6.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }

    @objc func openModal(_ sender: UIButton) {
        let firstViewController = RecordView()
        navigationController?.pushViewController(firstViewController, animated: true)
    }
    
    @objc func nextPage(_ sender: UIButton) {
        let firstViewController = FirstViewController()
        firstViewController.msg = msg
        navigationController?.pushViewController(firstViewController, animated: true)
    }
    
    @objc func getText(_ sender: UIButton){
        self.msg = textFiled.text!
        UserDefaults.standard.set(self.msg, forKey: "my-txt0")
    }
    
    
    @objc func openAlert1(_ sender: UIButton){
        //UIAlertControllerのスタイルがalert
        let alert: UIAlertController = UIAlertController(title: "MORU CAR", message:  "hoge", preferredStyle:  UIAlertController.Style.alert)
        // 確定ボタンの処理
        let confirmAction: UIAlertAction = UIAlertAction(title: "fuga", style: UIAlertAction.Style.default, handler:{
            // 確定ボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            print("fuga")
        })
        // キャンセルボタンの処理
        let cancelAction: UIAlertAction = UIAlertAction(title: "piyo", style: UIAlertAction.Style.cancel, handler:{
            // キャンセルボタンが押された時の処理をクロージャ実装する
            (action: UIAlertAction!) -> Void in
            //実際の処理
            print("piyo")
        })

        //UIAlertControllerにキャンセルボタンと確定ボタンをActionを追加
        alert.addAction(cancelAction)
        alert.addAction(confirmAction)

        //実際にAlertを表示する
        present(alert, animated: true, completion: nil)
    }
    
    @objc func openAlert2(_ sender: UIButton){
        //アラート生成
        //UIAlertControllerのスタイルがactionSheet
        let actionSheet = UIAlertController(title: "MORU CAR", message: "PUIPUI", preferredStyle: UIAlertController.Style.actionSheet)

        // 表示させたいタイトル1ボタンが押された時の処理をクロージャ実装する
        let action1 = UIAlertAction(title: "にんじん", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            print("にんじんを選択")
        })
        // 表示させたいタイトル2ボタンが押された時の処理をクロージャ実装する
        let action2 = UIAlertAction(title: "レタス", style: UIAlertAction.Style.default, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            print("レタス")

        })

        // 閉じるボタンが押された時の処理をクロージャ実装する
        //UIAlertActionのスタイルがCancelなので赤く表示される
        let close = UIAlertAction(title: "CLOSE", style: UIAlertAction.Style.destructive, handler: {
            (action: UIAlertAction!) in
            //実際の処理
            print("CLOSE")
        })

        //UIAlertControllerにタイトル1ボタンとタイトル2ボタンと閉じるボタンをActionを追加
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(close)

        //実際にAlertを表示する
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    @objc func sendNotifi(_ sender: UIButton){
        let content = UNMutableNotificationContent()
            content.title = "モルカー"
            content.body = "PUI PUI モルカー　にんじん大好き"
            content.sound = UNNotificationSound.default

            // 直ぐに通知を表示
            let request = UNNotificationRequest(identifier: "immediately", content: content, trigger: nil)
            UNUserNotificationCenter.current().add(request, withCompletionHandler: nil)
    }
    
}

