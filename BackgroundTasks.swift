//
//  BackgroundTasks.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 8/1/24.
//

import Foundation
//import BackgroundTasks



func scheduleAppRefresh(){
    let today = Calendar.current.startOfDay(for: .now)
    let tomorrow = Calendar.current.date(byAdding: .day, value: 1, to: today)!
    let morningComponent = DateComponents(hour: 7)
    let eveningComponent = DateComponents(hour: 17)
    let morning = Calendar.current.date(byAdding: morningComponent, to: tomorrow)
    
//    let request = BGAppRefreshTaskRequest(identifier: "Grades")
//    request.earliestBeginDate = morning
//    try? BGTaskScheduler.shared.submit(request)
}
