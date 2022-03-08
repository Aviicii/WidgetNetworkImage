//
//  VideoViewController.swift
//  ShortcutItem
//
//  Created by jekun on 2022/3/8.
//

import UIKit
import AVKit

class VideoViewController: UIViewController {
    
    var player:AVPlayer!
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .gray
        let player = AVPlayer(url: Bundle.main.url(forResource: "2", withExtension: "mp4")!)
        let playerLayer = AVPlayerLayer.init(player: player)
        playerLayer.frame = view.frame
        view.layer.addSublayer(playerLayer)
        player.play()
        self.player = player
        NotificationCenter.default.addObserver(self, selector: #selector(again), name: NSNotification.Name.AVPlayerItemDidPlayToEndTime, object: nil)
    }
    
    @objc func again() {
        self.player.seek(to: .init(value: 0, timescale: 1))
        self.player.play()
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
