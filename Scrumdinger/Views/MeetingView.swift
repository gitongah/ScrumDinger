//
//  ContentView.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 1/31/25.
//

import SwiftUI
import AVFoundation

struct MeetingView: View {
    @Binding var scrum: DailyScrum
    @StateObject var scrumTimer = ScrumTimer()
    @StateObject var speechRecognizer = SpeechRecognizer()
    @State var isRecording = false
    
    private var player: AVPlayer{AVPlayer.sharedDingPlayer}
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 16)
                .fill(scrum.theme.mainColor)
            VStack {
                MeetingHeaderView(secondsElapsed: scrumTimer.secondsElapsed, secondsRemaining: scrumTimer.secondsRemaining, theme: scrum.theme)
                
                MeetingTimerView(speakers: scrumTimer.speakers, theme: scrum.theme, isRecording: isRecording)
                
                MeetingFooterView(speakers: scrumTimer.speakers, skipAction: scrumTimer.skipSpeaker)
                
            }
            
        }
        .padding()
        .foregroundStyle(scrum.theme.accentColor)
        .onAppear{
            startScrum()
        }
        .onDisappear{
            stopScrum()
        }
        .navigationBarTitleDisplayMode(.inline)
        

    }
    private func startScrum() {

        scrumTimer.reset(lengthInMinutes: scrum.lengthInMinutes, attendees: scrum.attendees)
        scrumTimer.speakerChangedAction =  {
            player.seek(to: .zero)
            player.play()
        }
        speechRecognizer.resetTranscript()
        speechRecognizer.startTranscribing()
        isRecording = true
        scrumTimer.startScrum()
    }
    
    private func stopScrum() {
        scrumTimer.stopScrum()
        speechRecognizer.stopTranscribing()
        isRecording = false
        let newHistory = History(attendees: scrum.attendees, transcript: speechRecognizer.transcript)
        scrum.history.insert(newHistory, at: 0)
        
        
        
    }
}

#Preview {
    MeetingView(scrum: .constant(DailyScrum.sampleData[0]))
}
