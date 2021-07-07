//
//  listWithIconType.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import Foundation

struct ListWithIcon{
    let id: Int
    let src: String
    let title: String
    let body: String
    
    init(id: Int, src: String, title: String, body: String){
        self.id = id
        self.src = src
        self.title = title
        self.body = body
    }
}
