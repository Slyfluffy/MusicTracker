//
//  MetronomeView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 4/25/22.
//

import SwiftUI


struct MetronomeView: View {
    //Utility
    @State private var showPopover = false
    
    // Metronome numbers
    let minimum:Double = 40.0
    let maximum:Double = 208.0

    @State private var bpm = 120.0
    
    // Metronome tools
    @State private var isPlaying = false
    @State private var timer = Timer.publish(every: 0.5,
                                             on: .main,
                                             in: .common).autoconnect()
   
    var body: some View {
       VStack {
           VStack {
               HStack {
                   Text("\(Int(bpm))")
                       .foregroundColor(.blue)
                   Image(systemName: "metronome")
                       .foregroundColor(.blue)
             }
               
               HStack {
                   Spacer()
                   Slider(
                    value: $bpm,
                    in: minimum...maximum,
                    step: 1
                  ) {
                       Text("BPM")
                   } minimumValueLabel: {
                       Text("\(Int(minimum))")
                   } maximumValueLabel: {
                       Text("\(Int(maximum))")
                   } onEditingChanged: { _ in
                       setTempo()
                   }
                   
                   Button(action: {
                       // Flip Boolean and cancel timer if playing
                       isPlaying = !isPlaying
                       if isPlaying == false {
                           timer.upstream.connect().cancel()
                       }
                   }) {
                       // Paused!
                       if !isPlaying {
                           Image(systemName: "play.fill")
                               .padding(.trailing, 0.5)
                       }
                       // Playing!
                       else {
                           Image(systemName: "pause.fill")
                               .onReceive(timer) { time in
                                   setTempo()
                                   SoundManager.instance.playBeat()
                               }
                               .padding(.trailing, 1)
                       }
                   }
               }
           }
           .padding()
       }
    }
    
    /**
     * METRONOMEVIEW :: SETTEMPO
     * INPUTS  :: NONE
     * OUTPUTS :: NONE
     * Sets the timer according to the tempo!
     **/
    func setTempo() {
        let tempo = 60 / bpm
        timer = Timer.publish(every: tempo,
                              on: .main,
                              in: .common).autoconnect()
    }
}

struct MetronomeView_Previews: PreviewProvider {
    static var previews: some View {
        MetronomeView()
            .previewDevice("iPad Air (5th generation)")
    }
}
