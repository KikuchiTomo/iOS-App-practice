//
//  TimeView.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/22.
//
import Combine
import UIKit

class TimeViewController: UIViewController{
    
    var timeView: UILabel = UILabel.init()
    var timeStr: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Get Date
    
        timeView.translatesAutoresizingMaskIntoConstraints = false
        timeView.text = timeStr
        timeView.textColor = .white
        view.backgroundColor = .systemPurple
        view.addSubview(timeView)
        
        Timer.scheduledTimer( //TimerクラスのメソッドなのでTimerで宣言
          timeInterval: 0.1, //処理を行う間隔の秒
          target: self,  //指定した処理を記述するクラスのインスタンス
          selector: #selector(self.updateTimes(_:)), //実行されるメソッド名
          userInfo: nil, //selectorで指定したメソッドに渡す情報
          repeats: true //処理を繰り返すか否か
        )
        
        NSLayoutConstraint.activate([
            timeView.centerYAnchor.constraint(equalTo:  view.centerYAnchor, constant: 0),
            timeView.centerXAnchor.constraint(equalTo:  view.centerXAnchor, constant: 0)
        ])
    }
    
    @objc func updateTimes(_ sender:Timer){
        let myDate: Date = Date()
        let myCalendar: NSCalendar = NSCalendar(calendarIdentifier: NSCalendar.Identifier.gregorian)!
        
        let myComponetns = myCalendar.components(
                    [
                        NSCalendar.Unit.year,
                        NSCalendar.Unit.month,
                        NSCalendar.Unit.day,
                        NSCalendar.Unit.hour,
                        NSCalendar.Unit.minute,
                        NSCalendar.Unit.second,
                        NSCalendar.Unit.weekday
                    ],from: myDate)
                
        let weekdayStrings: Array = ["nil","日","月","火","水","木","金","土","日"]
        timeStr = ""
        timeStr += "\(myComponetns.year!)年"
        timeStr += "\(myComponetns.month!)月"
        timeStr += "\(myComponetns.day!)日"
        timeStr += "\(myComponetns.hour!)時"
        timeStr += "\(myComponetns.minute!)分"
        timeStr += "\(myComponetns.second!)秒"
        timeStr += "\(weekdayStrings[myComponetns.weekday!])曜日"
        timeView.text = timeStr
    }
}

