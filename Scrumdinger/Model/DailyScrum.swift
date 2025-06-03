//
//  DailyScrum.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/2/25.
//
import Foundation

struct DailyScrum: Identifiable, Codable{
    let id: UUID
    var title: String
    var attendees: [Attendees]
    var lengthInMinutes: Int
    var theme: Theme
    var history: [History] = []
    var lengthInMinutesAsDouble: Double {
        get{
            Double(lengthInMinutes)
        }
        set {
            lengthInMinutes = Int(newValue)
        }
    }
    
    init(id: UUID = UUID(), title: String, attendees: [String], lengthInMinutes: Int, theme: Theme) {
        self.id = id
        self.title = title
        self.attendees = attendees.map {Attendees(name: $0)}
        self.lengthInMinutes = lengthInMinutes
        self.theme = theme
    }
    
}

extension DailyScrum{
    struct Attendees: Identifiable, Codable {
        let id: UUID
        var name: String
        
        init(id: UUID = UUID(), name: String) {
            self.id = id
            self.name = name
        }
    }
    static var emptyScrum: DailyScrum {
        DailyScrum(
            title: "",
            attendees: [],
            lengthInMinutes: 0,
            theme: .sky
        )
    }

}

extension DailyScrum {
    static var sampleData: [DailyScrum] {
        [
            DailyScrum(
                title: "Design",
                attendees: ["Cathy", "Daisy", "Simon", "Jonathan"],
                lengthInMinutes: 10,
                theme: .yellow
            ),
            DailyScrum(
                title: "App Dev",
                attendees: ["Edwin Mbaabu", "John Mbaabu", "Gray", "Euna", "Luis"],
                lengthInMinutes: 8,
                theme: .yellow
            ),
            DailyScrum(
                title: "Web Dev",
                attendees: ["Chella", "Chris", "Christina", "Eden", "Mbaabu", "John"],
                lengthInMinutes: 5,
                theme: .yellow
            ),
            
        ]
    }
        
    
}
