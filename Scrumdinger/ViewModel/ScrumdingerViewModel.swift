//
//  ScrumdingerViewModel.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/7/25.
//
import Foundation
import AVFoundation
@MainActor
class MeetingViewModel: ObservableObject {
    @Published var scrum: DailyScrum
    @Published private(set) var scrumTimer: ScrumTimer
    
    private var player: AVPlayer { AVPlayer.sharedDingPlayer }

    init(scrum: DailyScrum) {
        self.scrum = scrum
        self.scrumTimer = ScrumTimer()
    }

    var secondsElapsed: Int {
        scrumTimer.secondsElapsed
    }
    
    var secondsRemaining: Int {
        scrumTimer.secondsRemaining
    }

    var speakers: [ScrumTimer.Speaker] {
        scrumTimer.speakers
    }

    func startScrum() {
            scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
            scrumTimer.speakerChangedAction = {
                self.player.seek(to: .zero)
                self.player.play()
            }
            scrumTimer.startScrum()
        
    }

    func stopScrum() {
        scrumTimer.stopScrum()
        let newHistory = History(attendees: scrum.attendees)
        scrum.history.insert(newHistory, at: 0)
    }

    func skipSpeaker() {
        scrumTimer.skipSpeaker()
    }
}
