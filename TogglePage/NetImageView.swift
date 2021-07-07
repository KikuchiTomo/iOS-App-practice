//
//  NetImageView.swift
//  TogglePage
//
//  Created by TomoKikuchi on 2021/06/19.
//

import SwiftUI

struct NetImageView: View {
    
    @ObservedObject var viewModel: URLImageViewModel
       
       var body: some View {
           if let imageData = self.viewModel.downloadData {
               if let image = UIImage(data: imageData) {
                   return Image(uiImage: image).resizable()
               } else {
                   return Image(uiImage: UIImage()).resizable()
               }
           } else {
               return Image(uiImage: UIImage()).resizable()
           }
       }
}
