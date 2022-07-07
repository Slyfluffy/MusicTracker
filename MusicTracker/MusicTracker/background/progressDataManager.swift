//
//  progressDataManager.swift
//  MusicTracker
//
//  Created by Journey Curtis on 7/1/22.
//

import Foundation

/**
 * EXTENSION :: CALENDAR
 * Extends calendar to verify if date is in current week
 **/
extension Calendar {
    // Today's date
    private var today: Date { return Date() }
    
    //compare and verify if date is in the week
    func isDateinThisWeek(_ date: Date) -> Bool {
        return isDate(date,
                      equalTo: today,
                      toGranularity: .weekOfYear)
    }
}

/**
 * DATAMANAGER :: MUSICTRACKER
 * Records and saves all progress data.
 */
class DataManager: Codable, ObservableObject {
    var fileName = "savedData"
    var weeklyUpdateDay: Date? = nil
    
    var daysPracticedMonth = [0,0,0,0]
    var goalsAchievedMonth = [0,0,0,0]
   
    var goals = ["", "", ""]
    var goalsCompleted = [false, false, false]
   
    var daysPracticedWeek = [false, false, false, false,
                             false, false, false]
   
    // Initializer
    init() {
        if let data = UserDefaults.standard.data(forKey: fileName) {
            if let decoded = try? JSONDecoder().decode(DataManager.self,
                                                       from: data) {
                print(decoded)
                // Last weekly updated day
                self.weeklyUpdateDay = decoded.weeklyUpdateDay
                
                // Current Month Statistics
                self.daysPracticedMonth = decoded.daysPracticedMonth
                self.goalsAchievedMonth = decoded.goalsAchievedMonth
                
                // Current Week Statistics
                self.goals = decoded.goals
                self.goalsCompleted = decoded.goalsCompleted
                self.daysPracticedWeek = decoded.daysPracticedWeek
                print(self.goals)
                print(decoded.goals)
            }
        }
    }
   
    // Save data in UserDefaults
    private func save() {
        if let encoded = try? JSONEncoder().encode(self) {
            UserDefaults.standard.set(encoded, forKey: fileName)
        }
        print("Saved!")
    }
    
    // Check last updated Today and verify if it is in current week
    func checkForWeeklyUpdate() async {
        if let then = weeklyUpdateDay {
            if !Calendar.current.isDateinThisWeek(then) {
                weeklyUpdateDay = Date.now
            }
        } else {
            weeklyUpdateDay = Date.now
        }
        save()
    }
    
    // update the monthly report for days practiced.
    func updateDaysPracticedMonth(_ daysPracticed: [Bool]) {
        if daysPracticed.count < 7 || daysPracticed.count > 7 {
            print("ERROR: invalid daysPracticed entered.")
            return
        }
        
        var total = 0
        for day in daysPracticed {
            if day == true {
                total += 1
            }
        }
        
        daysPracticedMonth.append(total)
        if daysPracticedMonth.count > 4 {
            daysPracticedMonth.remove(at: 0)
        }
        save()
    }
    
    // update the goals achieved in the monthly report
    func updateGoalsAchievedMonth(_ goalsAchieved: [Bool]) {
        if goalsAchieved.count < 3 || goalsAchieved.count > 3 {
            print("ERROR: invalid goalsAchieved entered.")
            return
        }
        
        var total = 0
        for goal in goalsAchieved {
            if goal == true {
                total += 1
            }
        }
        
        goalsAchievedMonth.append(total)
        if goalsAchievedMonth.count > 4 {
            goalsAchievedMonth.remove(at: 0)
        }
        save()
    }
    
    // update the current week's saved goals
    func updateGoalsAchievedWeek(_ goals: [String],
                                          _ goalsCompleted: [Bool]) {
        if goals.count < 3 || goals.count > 3 ||
           goalsCompleted.count < 3 || goalsCompleted.count > 3 {
            print("ERROR: invalid parameters entered. Ensure size is only 3")
            return
        }
        
        self.goals = goals
        self.goalsCompleted = goalsCompleted
        save()
    }
    
    // update the saved days practiced
    func updateDaysPracticedWeek(_ daysPracticed: [Bool]) {
        if daysPracticed.count < 7 || daysPracticed.count > 7 {
            print("ERROR: invalid daysPracticed entered. Ensure size is seven")
            return
        }
        
        self.daysPracticedWeek = daysPracticed
        save()
    }
}
