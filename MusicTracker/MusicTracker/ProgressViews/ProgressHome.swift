//
//  ProgressHome.swift
//  test1
//
//  Created by Journey Curtis on 5/6/22.
//

import SwiftUI

/*
 * PROGRESSHOME :: MUSICTRACKER
 * View that handles all progression for music students
 */
struct ProgressHome: View {
    @EnvironmentObject var data: DataManager
    
    @State private var size = 0.33
     
    @State private var completed = [false, false, false]
    @State private var goals = ["task1", "task2", "task3"]
    @State private var daysPracticedMonth = [0, 1, 2, 3]
    @State private var goalsAchievedMonth = [0, 1, 2, 3]
    
    var body: some View {
        // Dynamically Adjust according to screen size
        GeometryReader { geo in
            VStack {
                // Display Progress Report
                MonthlyReportView()
                    .frame(width: geo.size.width,
                           height: geo.size.height * size)
                // Display Weekly Goals
                WeeklyGoalsView()
                    .frame(width: geo.size.width,
                           height: geo.size.height * size)
                // Display Practice days
                PracticeView()
                    .frame(width: geo.size.width,
                           height: geo.size.height * size)
            }
            .environmentObject(data)
        }
    }
}

struct ProgressHome_Previews: PreviewProvider {
    static var previews: some View {
        ProgressHome()
            .previewDevice("iPad Air (5th generation)")
            .environmentObject(DataManager())
        
        ProgressHome()
            .previewDevice("iPod touch (7th generation)")
            .environmentObject(DataManager())
        
        ProgressHome()
            .previewDevice("iPod touch (7th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
            .environmentObject(DataManager())
    }
}
