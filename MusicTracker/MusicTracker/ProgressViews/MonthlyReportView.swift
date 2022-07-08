//
//  MonthlyReportView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/21/22.
//

import SwiftUI

/*
 * MONTHLYREPORTVIEW :: MUSICTRACKER
 * Displays the monthly progress of the user
 */
struct MonthlyReportView: View {
    @EnvironmentObject var data: DataManager
    
    @State private var progressBarWidth = 0.2
    @State private var progressBarHeight = 0.23
    @State private var progressFontSize = 20.0
    @State private var textScaleFactor = 0.5
    
    @State private var iconHeaderWidth = 0.2
    @State private var iconHeaderHeight = 0.2
    
    @State private var daysPracticedMonth = [0, 0, 0, 0]
    @State private var goalsAchievedMonth = [0, 0, 0, 0]
    
    var body: some View {
        // Dynamically adjust all pictures and text
        GeometryReader { geo in
            VStack {
                HStack {
                    // Section icon
                    Image(systemName: "chart.bar.fill")
                        .resizable()
                        .scaledToFit()
                        .frame(width: geo.size.width * progressBarWidth,
                               height: geo.size.height * progressBarHeight,
                               alignment: .leading)
                        .padding(.leading)
                        .padding(.top, 5)
                        Spacer()
                }
                
                HStack {
                    Spacer()
                    VStack {
                        // Week icon
                        Image(systemName: "calendar")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * iconHeaderWidth,
                                   height: geo.size.height * iconHeaderHeight)
                        ForEach((0...3).reversed(), id: \.self) {
                            Text("\($0 + 1) weeks")
                                .font(.system(size: progressFontSize))
                                .minimumScaleFactor(textScaleFactor)
                        }
                    }
                    Spacer()
                    VStack {
                        // Goals icon
                        Image(systemName: "checklist")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * iconHeaderWidth,
                                   height:geo.size.height * iconHeaderHeight)
                        ForEach((0...3), id: \.self) {
                            Text("\(goalsAchievedMonth[$0])/3")
                                .font(.system(size: progressFontSize))
                                .minimumScaleFactor(textScaleFactor)
                        }
                    }
                    Spacer()
                    VStack {
                        // Days Practiced Icon
                        Image(systemName: "checkmark.circle")
                            .resizable()
                            .scaledToFit()
                            .frame(width: geo.size.width * iconHeaderWidth,
                                   height: geo.size.height * iconHeaderHeight)
                        ForEach((0...3), id: \.self) {
                            Text("\(daysPracticedMonth[$0])/7")
                                .font(.system(size: progressFontSize))
                                .minimumScaleFactor(textScaleFactor)
                        }
                    }
                    Spacer()
                }
            }
            .task() {
                await data.checkForWeeklyUpdate()
                await setData()
            }
        }
    }
    
    // Set the goals and practice days according to the saved data
    func setData() async {
        daysPracticedMonth = data.daysPracticedMonth
        goalsAchievedMonth = data.goalsAchievedMonth
    }
}

struct MonthlyReportView_Previews: PreviewProvider {
    static var previews: some View {
        MonthlyReportView()
          .previewDevice("iPad Air (5th generation)")
          .environmentObject(DataManager())
       
        MonthlyReportView()
            .previewDevice("iPod touch (7th generation)")
            .environmentObject(DataManager())
    }
}
