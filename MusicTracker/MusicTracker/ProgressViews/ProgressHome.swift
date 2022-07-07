//
//  ProgressHome.swift
//  test1
//
//  Created by Journey Curtis on 5/6/22.
//

import SwiftUI

struct ProgressHome: View {
    @EnvironmentObject var data: DataManager
    
    @State private var size = 0.32
     
    @State private var completed = [false, false, false]
    @State private var goals = ["task1", "task2", "task3"]
    @State private var daysPracticedMonth = [0, 1, 2, 3]
    @State private var goalsAchievedMonth = [0, 1, 2, 3]
    
    var body: some View {
        GeometryReader { geo in
            VStack {
                MonthlyReportView()
                    .frame(width: geo.size.width,
                           height: geo.size.height * size)
                WeeklyGoalsView()
                    .frame(width: geo.size.width,
                           height: geo.size.height * size)
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
        
        ProgressHome()
            .previewDevice("iPod touch (7th generation)")
        
        ProgressHome()
            .previewDevice("iPod touch (7th generation)")
            .previewInterfaceOrientation(.landscapeLeft)
    }
}
