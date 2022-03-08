//
//  WidgetImageView.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/7.
//

import SwiftUI

struct WidgetImageView: View {
    let url: String
    let placeholderOne = UIImage(named: "1") //占位图
    
    @ViewBuilder
    var body: some View {
        Image(uiImage: (WidgetImageLoader.shareLoader.getImage(url)))
            .resizable()
    }
    
    
}
