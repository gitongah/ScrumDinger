//
//  MeetingTimerView.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/19/25.
//

import SwiftUI

struct MeetingTimerView: View {
    let speakers : [ScrumTimer.Speaker]
    let theme : Theme
    let isRecording : Bool
    
    private var currentSpeaker: String{
        speakers.first(where: { !$0.isCompleted})?.name ?? "Someone"
    }
    var body: some View {
        Circle()
            .strokeBorder(lineWidth: 24)
            .overlay {
                VStack{
                    Text(currentSpeaker)
                        .font(.title)
                    
                    Text("is speaking")
                    Image(systemName: isRecording ? "mic" : "mic.slash")
                        .font(.title)
                        .padding(.top)
                        .accessibilityLabel(isRecording ? "with transcription" : "without transcription ")
                }
                .accessibilityElement(children: .combine)
                .foregroundStyle(theme.accentColor)

                
            }
            .overlay{
                ForEach(speakers.indices, id: \.self){ index in
                    let speaker = speakers[index]
                    if speaker.isCompleted{
                        SpeakerArc(speakerIndex: index, totalSpeakers: speakers.count)
                            .rotation(Angle(degrees: -90))
                            .stroke(theme.mainColor, lineWidth: 12)
                    }
  
                }
                
            }
            .padding(.horizontal)
    }
}


#Preview {
    var speaker : [ScrumTimer.Speaker] {
        [ScrumTimer.Speaker(name: "Bill", isCompleted: true), ScrumTimer.Speaker(name: "Cathy", isCompleted: false)]
    }
    MeetingTimerView(speakers: speaker, theme: .yellow, isRecording: true)
}
