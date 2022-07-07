//
//  PracticeView.swift
//  MusicTracker
//
//  Created by Journey Curtis on 6/23/22.
//

import SwiftUI

struct PracticeView: View {
    @EnvironmentObject var data: DataManager
    
    @State private var circleWidth = 0.18
    @State private var circleHeight = 0.18
    @State private var spacing = 15.0
    
    @State private var textSize = 16.0
    @State private var textScaleFactor = 0.1
    
    @State private var formatter = DateFormatter()
    @State private var week: [Date]?
    @State private var completed = [false, false, false, false,
                                    false, false, false]
    
    var body: some View {
        GeometryReader { geo in
            ScrollView(.horizontal) {
                HStack(spacing: spacing) {
                    if let days = week {
                        ForEach(0..<7) { index in
                            VStack {
                                Spacer()
                                Button(action: {
                                    completed[index] = !completed[index]
                                    data.updateDaysPracticedWeek(completed)
                                }) {
                                    // Not completed!
                                    if !completed[index] {
                                        Image(systemName: "circle")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geo.size.width *
                                                   circleWidth,
                                                   height: geo.size.height *
                                                   circleHeight)
                                    }
                                    // Done!
                                    else {
                                        Image(systemName:
                                                "checkmark.circle.fill")
                                            .resizable()
                                            .scaledToFit()
                                            .frame(width: geo.size.width *
                                                   circleWidth,
                                                   height: geo.size.height *
                                                   circleHeight)
                                    }
                                }
                                Text(formatter.string(from: days[index]))
                                    .font(.system(size: textSize))
                                    .minimumScaleFactor(textScaleFactor)
                            }
                        }
                    }
                }
                .padding()
                .task {
                    formatter.dateFormat = "MM/dd"
                    week = await getWeek()
                    await setData()
                }
            }
        }
    }
    
    func setData() async {
        completed = data.daysPracticedWeek
    }
    
    func getWeek() async -> [Date]? {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        let dayOfWeek = calendar.component(.weekday, from: today)
        if let week = calendar.range(of: .weekday,
                                     in: .weekOfYear,
                                     for: today) {
            let days = week.compactMap { calendar.date(byAdding: .day,
                                            value: $0 - dayOfWeek,
                                            to: today) }
            return days
        }
        
        return nil
    }
}

struct PracticeView_Previews: PreviewProvider {
    static var previews: some View {
        PracticeView()
            .previewDevice("iPod touch (7th generation)")
    }
}
