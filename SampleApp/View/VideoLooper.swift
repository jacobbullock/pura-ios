//
//  VideoLooper.swift
//  SampleApp
//
//  Created by Jacob Bullock on 1/17/24.
//

import UIKit
import SwiftUI
import AVFoundation

struct VideoLooperView: UIViewRepresentable {
    typealias UIViewType = VideoLooper
    
    let videoURL: String
  
    func makeUIView(context: Context) -> VideoLooper {
        return VideoLooper(videoURL: videoURL)
    }
    
    func updateUIView(_ uiView: VideoLooper, context: Context) {
        // Updates the state of the specified view with new information from SwiftUI.
    }
}

class VideoLooper: UIView {

    private var looper: AVPlayerLooper!
    
    init(videoURL: String) {
        super.init(frame: .zero)
        backgroundColor = .gray

        guard let url = URL(string: videoURL) else { return }
        
        let playerItem = AVPlayerItem(url: url)
                
        let queuePlayer = AVQueuePlayer(playerItem: playerItem)
        let playerLayer = AVPlayerLayer(player: queuePlayer)

        self.looper = AVPlayerLooper.init(player: queuePlayer, templateItem: playerItem)
        
        playerLayer.videoGravity = .resizeAspectFill
        self.layer.addSublayer(playerLayer)
        
        playerLayer.frame = CGRect(x: 0, y: 0, width: 150, height: 150)

        queuePlayer.play()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
