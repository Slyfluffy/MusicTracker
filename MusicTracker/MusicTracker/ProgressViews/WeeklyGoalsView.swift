//
//  WeeklyGoalsView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/21/22.
//

import SwiftUI

/*
 * WEEKLYGOALSVIEW :: MUSICTRACKER
 * UI for the weekly goals
 */
struct WeeklyGoalsView: View {
    @EnvironmentObject var data: DataManager
    
    @State private var checklistWidth = 0.2
    @State private var checklistHeight = 0.23
    
    @State private var circleWidth = 0.22
    @State private var circleHeight = 0.22
    
    @State private var completed = [false, false, false]
    @State private var goals = ["", "", ""]
    @State private var textSize = 24.0
    @State private var textScaleFactor = 0.75
    
    var body: some View {
        // Once again, dynamically adjust sizes for screen
        GeometryReader { geo in
            VStack {
                HStack {
                    Image(systemName: "checklist")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * checklistWidth,
                               height: geo.size.height * checklistHeight,
                               alignment: .leading)
                        .padding(.leading)
                    Spacer()
                }
                
                // Go through and create the UI for three goals
                ForEach(0..<3) { index in
                    HStack {
                        Button(action: {
                            completed[index] = !completed[index]
                            data.updateGoalsAchievedWeek(goals, completed)
                        }) {
                            // Not completed!
                            if !completed[index] {
                                Image(systemName: "circle")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * circleWidth,
                                           height: geo.size.height *
                                           circleHeight)
                            }
                            // Done!
                            else {
                                Image(systemName: "checkmark.circle.fill")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: geo.size.width * circleWidth,
                                           height: geo.size.height *
                                           circleHeight)
                            }
                        }
                        TextField("Enter Goal", text: $goals[index])
                            .font(.system(size: textSize))
                            .minimumScaleFactor(textScaleFactor)
                            .onSubmit() {
                                data.updateGoalsAchievedWeek(goals, completed)
                            }
                    }
                    .frame(width: geo.size.width,
                           height: geo.size.height * checklistHeight,
                           alignment: .leading)
                    .padding(.leading)
                }
            }
            .task() {
                await setData()
            }
            Spacer()
        }
    }
    
    // Set the data according to what is stored!
    func setData() async {
        completed = data.goalsCompleted
        goals = data.goals
    }
}

struct WeeklyGoalsView_Previews: PreviewProvider {
    static var previews: some View {
        WeeklyGoalsView()
            .previewDevice("iPad Air (5th generation)")
            .environmentObject(DataManager())
        
        WeeklyGoalsView()
            .previewDevice("iPod touch (7th generation)")
            .environmentObject(DataManager())
        
        WeeklyGoalsView()
            .previewDevice("iPod touch (7th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(DataManager())
    }
}
