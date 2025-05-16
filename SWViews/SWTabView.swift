//
//  SWTabView.swift
//  StarWars
//
//  Created by Simon Parraga on 2/05/25.
//

import SwiftUI

struct SWTabView: View {
    
    enum Tab {
        case home
        case people
        case films
        case starships
        case planet
    }
    
    @State private var selectedTab: Tab = .home
    
    var body: some View {
        
        TabView(selection: $selectedTab) {
            SWPeopleView()
                .tabItem {
                    Label("People", systemImage: "person.fill")
                }
                .tag(Tab.people)
            
            SWPeopleView()
                .tabItem {
                    Label("Films", systemImage: "film")
                }
                .tag(Tab.films)
            
            SWPeopleView()
                .tabItem {
                    Label("Home", systemImage: "house.fill")
                }
                .tag(Tab.home)
            
            SWPeopleView()
                .tabItem {
                    Label("Starships", systemImage: "paperplane")
                }
                .tag(Tab.starships)
            
            SWPeopleView()
                .tabItem {
                    Label("Planet", systemImage: "globe")
                }
                .tag(Tab.planet)
        }
        .tint(.green)
    }
}

// TODO: We need to add more childViews to start working on this
extension SWTabView {
    private func tabSelection() -> Binding<Tab> {
        Binding {
            self.selectedTab
        } set: { tappedTab in
            if tappedTab == self.selectedTab {
                
            }
            
            self.selectedTab = tappedTab
        }
    }
}
