//
//  ContentView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 5/6/22.
//

import SwiftUI

struct ContentView: View {
    @StateObject var data = DataManager()
    @State private var selection: Tab = .MusicHome
    
    enum Tab {
        case Metronome
        case Progress
        case MusicHome
    }
    
    var body: some View {
        TabView(selection: $selection) {
            MetroTunerView()
                .tabItem() {
                    Label("Metronome/Tuner", systemImage: "metronome")
                }
                .tag(Tab.Metronome)
            MusicHome()
                .tabItem() {
                    Label("Music", systemImage: "music.note.list")
                }
                .tag(Tab.MusicHome)
            ProgressHome()
                .tabItem() {
                    Label("Progress", systemImage: "chart.bar.xaxis")
                }
                .tag(Tab.Progress)
                .environmentObject(data)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {    
        ContentView()
            .previewDevice("iPad Air (5th generation)")
        
        ContentView()
            .previewDevice("iPod touch (7th generation)")
        
        ContentView()
            .previewDevice("iPod touch (7th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
