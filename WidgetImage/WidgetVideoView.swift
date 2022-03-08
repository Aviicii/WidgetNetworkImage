//
//  WidgetVideoView.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/8.
//

import SwiftUI
import AVKit

struct WidgetVideoView: View {
    
    var body: some View {
        VideoPlayer(player: AVPlayer(url: Bundle.main.url(forResource: "2", withExtension: "mp4")!))
    }
}

