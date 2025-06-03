//
//  ScrumsView.swift
//  Scrumdinger
//
//  Created by Edwin Mbaabu on 2/3/25.
//

import SwiftUI

struct ScrumsView: View {
    @Binding var scrums: [DailyScrum]
    @State private var isPresentingAddScrumView = false
    @Environment(\.scenePhase) private var scenePhase
    let saveAction: () -> Void
    
    var body: some View {
        NavigationStack {
            List($scrums) { $scrum in
                NavigationLink(destination: DetailView(scrum: $scrum)){
                    CardView(scrum: scrum)
                        
                }
                .listRowBackground(scrum.theme.mainColor)
            }
            .navigationTitle("Daily Scrums")
            .toolbar{
                Button(action: {
                    isPresentingAddScrumView = true
                }){
                    Image(systemName: "plus")
                }
                .accessibilityLabel("Add New Scrum")
            }
            .sheet(isPresented: $isPresentingAddScrumView){
                NewScrumSheet(scrums: $scrums, isPresentingNewScrumSheet: $isPresentingAddScrumView)
                
            }
            .onChange(of: scenePhase) { phase in
                if phase == .inactive {
                    saveAction()
                }
            }
        }

    }
}

#Preview {
    ScrumsView(scrums: .constant(DailyScrum.sampleData), saveAction: {})
}
