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
