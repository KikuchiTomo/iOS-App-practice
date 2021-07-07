//
//  SecondViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/19.
//

import Foundation
import UIKit

class SecondViewController: UIViewController {
    let view_width = UIScreen.main.bounds.width
    let view_height = UIScreen.main.bounds.height
    
    lazy var imageView: UIImageView = {
        var img_view: UIImageView = UIImageView()
//        let urlString: String = "https://www.bmcomp.co.jp/img/logo.png"
        let urlString = "https://www.bmcomp.co.jp/img/logo.png"
      //  if  let urlString = recvUrlString as? String {
        let url = URL(string: urlString)
        do{
            let imageData = try Data(contentsOf: url!)
            img_view.image = UIImage(data: imageData)
        } catch {
            print("Error : Cat't get image")
            img_view.image = UIImage(named: "piyo")
        }
       // } else {
       //     img_view.image = UIImage(named: "piyo") //nilの場合は固定画像表示
       // }
        print(img_view)
    
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
    
    lazy var button: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.setTitle("next page", for: .normal)
        view.addTarget(self, action: #selector(nextPage(_:)), for: .touchDown)
        return view
    }()
    
    lazy var backbutton: UIButton = {
        let view = UIButton.init()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.backgroundColor = .systemPurple
        view.setTitle("back page", for: .normal)
        view.addTarget(self, action: #selector(prevPage(_:)), for: .touchDown)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        self.navigationController?.navigationBar.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = .systemPurple
        navigationItem.backBarButtonItem = UIBarButtonItem(title: "Subsub Page", style: .plain, target: nil, action: nil)
        
        
        view.addSubview(imageView)
        view.addSubview(button)
        view.addSubview(backbutton)
        
        NSLayoutConstraint.activate([
            button.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0),
            backbutton.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 10),
            backbutton.centerXAnchor.constraint(equalTo: view.centerXAnchor)
        ])
    }
    
    @objc func nextPage(_ sender: UIButton) {
        print(sender)
        let otherViewController = otherViewController()
        self.navigationController?.pushViewController(otherViewController, animated: true)
    }
    
    @objc func prevPage(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}
