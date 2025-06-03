//
//  DetailView.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/3/25.
//

import SwiftUI

struct DetailView: View {
    @Binding var scrum: DailyScrum
    
    @State private var editingScrum = DailyScrum.emptyScrum
    @State private var isPresentingEditView = false
    
    
    var body: some View {
        List{
            Section(header: Text("Meeting Details")){
                NavigationLink {
                    MeetingView(scrum: $scrum)
                } label: {
                    Label("Start Meeting", systemImage: "timer")
                        .accessibilityLabel("Start Meeting")
                        .font(.headline)
                        .foregroundColor(.accentColor)
                }

                HStack{
                    Label("Length", systemImage: "clock")
                    
                    Spacer()
                    
                    Text("\(scrum.lengthInMinutes) minutes")
                }
                .accessibilityElement(children: .combine)
                HStack{
                    Label("Theme", systemImage: "paintpalette")
                    
                    Spacer()
                    
                    Text(scrum.theme.name)
                        .padding(4)
                        .foregroundColor(scrum.theme.accentColor)
                        .background(scrum.theme.mainColor)
                        .cornerRadius(4)
                }
                .accessibilityElement(children: .combine)
            }
            Section(header: Text("Attendees")){
                ForEach(scrum.attendees){attendee in
                    Label(attendee.name, systemImage: "person")
                    
                }
            }
            Section(header: Text("History header")){
                if scrum.history.isEmpty{
                    Label("No meetings Yet", systemImage: "calendar.badge.exclamationmark")
                }
                ForEach(scrum.history){ history in
                    NavigationLink(destination: HistoryView(history: history)){
                        HStack{
                            Image(systemName: "calendar")
                            Text(history.date, style: .date)
                        }
                    }
                }
                
            }
        }
        .navigationTitle(scrum.title)
        .toolbar{
            Button("Edit"){
                isPresentingEditView = true
                editingScrum = scrum
            }
        }
        .sheet(isPresented: $isPresentingEditView){
            NavigationStack{
                DetailEditView(scrum: $editingScrum)
                    .navigationTitle(scrum.title)
                    .toolbar{
                        ToolbarItem(placement: .cancellationAction){
                            Button("Cancle"){
                                isPresentingEditView = false
                                
                            }
                            
                        }
                        ToolbarItem(placement: .confirmationAction){
                            Button("Done"){
                                isPresentingEditView = false
                                scrum = editingScrum
                            }
                        }
                    }
            }
            
        }
    }
        
}

#Preview {
    NavigationStack{
        DetailView(scrum: .constant(DailyScrum.sampleData[0]))
    }
}
