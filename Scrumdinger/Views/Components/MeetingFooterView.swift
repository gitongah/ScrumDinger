//
//  MeetingFooterView.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/7/25.
//

import SwiftUI

struct MeetingFooterView: View {
    let speakers : [ScrumTimer.Speaker]
    let skipAction: () -> Void
    
    private var speakerNumber: Int? {
        guard let index = speakers.firstIndex(where: { !$0.isCompleted}) else{ return nil}
        return index + 1
            
    }
    
    private var isLastSpeaker: Bool {
        return speakers.dropLast().allSatisfy {
            $0.isCompleted
        }
    }
    private var speakerText: String {
        guard let speakerNumber = speakerNumber else { return "" }
        return "Speaker \(speakerNumber) of \(speakers.count)"
    }
    
    var body: some View {
        VStack {
            HStack {
                if isLastSpeaker {
                    Text("Last Speaker")
                }else{
                    Text(speakerText)
                    Spacer()
                    Button(action: skipAction) {
                        Image(systemName: "forward.fill")
                    }
                    .accessibilityLabel(Text("Next Speaker"))
                    
                }
            }
        }
        .padding([.bottom, .horizontal])
    }
}

#Preview {
    MeetingFooterView(speakers: DailyScrum.sampleData[0].attendees.speakers, skipAction: {})
}
