//
//  AVPlayer+Ding.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/7/25.
//

import Foundation
import AVFoundation

extension AVPlayer {
    static let sharedDingPlayer: AVPlayer = {
        guard let url = Bundle.main.url(forResource: "ding", withExtension: "wav") else { fatalError("Failed to find sound file.") }
        return AVPlayer(url: url)
    }()
}
