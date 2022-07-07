//
//  TunerView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/2/22.
//

import SwiftUI

enum Colors {
    case red
    case yellow
    case green
    case clear
}

struct TunerView: View {
    @State private var note = "A"
    @State private var frequency = 0.0
    @State private var isTunerOn = false
    @State private var screenColor = Color.clear
    
    var body: some View {
//        setColor(c: Colors.green)
        screenColor
            .ignoresSafeArea()
            .overlay() {
                VStack {
                    if !(isTunerOn) {
                        Text(note)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.clear)
                        
                        Text(String(format: "+%.1f", frequency))
                            .font(.system(size: 50))
                            .minimumScaleFactor(0.01)
                            .foregroundColor(.clear)
                    } else {
                        Text(note)
                            .font(.system(size: 200))
                            .minimumScaleFactor(0.01)
                        
                        if frequency > 0 {
                            Text(String(format: "+%.1f", frequency))
                                .font(.system(size: 50))
                                .minimumScaleFactor(0.01)
                        } else {
                            Text(String(format: "%.1f", frequency))
                                .font(.system(size: 50))
                                .minimumScaleFactor(0.01)
                        }
                    }
                    
                    Button(action: {
                        isTunerOn = !isTunerOn
                    }) {
                        if !isTunerOn {
                            Image(systemName: "mic.slash.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.black)
                        } else {
                            Image(systemName: "mic.fill")
                                .resizable()
                                .scaledToFit()
                                .frame(width: 75, height: 75)
                                .foregroundColor(.black)
                        }
                    }
                }
            }
    }
    
    func setColor(c: Colors) {
        if c == Colors.red {
            screenColor = Color.red
        }
        else if c == Colors.yellow {
            screenColor = Color.yellow
        }
        else if c == Colors.green {
            screenColor = Color(red: 0.0, green: 0.7, blue: 0.0)
        }
    }
}

struct TunerView_Previews: PreviewProvider {
    static var previews: some View {
        TunerView()
            .previewDevice("iPad Air (5th generation)")
    }
}
