//
//  SecondViewController.swift
//  Practice
//
//  Created by TomoKikuchi on 2021/06/19.
//

import Foundation
import UIKit

class otherViewController: UIViewController {
    let SW = UIScreen.main.bounds.size.width
    let SH = UIScreen.main.bounds.size.height
    let inView = UIView()
    let scrollView = UIScrollView()
    
    let page_title: UILabel = {
        let view: UILabel = UILabel()
        view.text = "Scroll View"
        view.backgroundColor = .white
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemPurple
        
        inView.backgroundColor = .white
        scrollView.addSubview(inView)
        view.addSubview(scrollView)
        
        scrollView.translatesAutoresizingMaskIntoConstraints = false
        scrollView.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 0).isActive = true
        scrollView.rightAnchor.constraint(equalTo: view.rightAnchor, constant: 0).isActive = true
        scrollView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0).isActive = true
        
        inView.translatesAutoresizingMaskIntoConstraints = false
        inView.widthAnchor.constraint(equalToConstant: SW).isActive = true
        inView.heightAnchor.constraint(equalToConstant: (SH * 2)).isActive = true
        inView.leftAnchor.constraint(equalTo: scrollView.leftAnchor, constant: 0).isActive = true
        inView.rightAnchor.constraint(equalTo: scrollView.rightAnchor, constant: 0).isActive = true
        inView.topAnchor.constraint(equalTo: scrollView.topAnchor, constant: 0).isActive = true
        inView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor, constant: 0).isActive = true
        /*
        NSLayoutConstraint.activate([
            page_title.centerYAnchor.constraint(equalTo: view.centerYAnchor, constant: 0),
            page_title.centerXAnchor.constraint(equalTo: view.centerXAnchor, constant: 0)
        ])
         */
    }
}
