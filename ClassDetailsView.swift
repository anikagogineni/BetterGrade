//
//  ClassDetailsView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/10/24.
//

import Foundation
import SwiftUI

struct ClassDetailsView: View {
    @State var schedule: Schedule
    @State var building = ""
    @State var courseCode = ""
    @State var courseName = ""
    @State var days = ""
    @State var markingPeriods = ""
    @State var periods = ""
    @State var room = ""
    @State var status = ""
    @State var teacher = ""
    var body: some View {
        List {
            Section(header: Text("Class Details").font(.custom("Arial", size: 12))) {
                VStack{
                    
                    TextInputField("CourseName", text: $courseName)
                    TextInputField("CourseCode", text: $courseCode)
                    TextInputField("Building", text: $building)
                    TextInputField("Days", text: $days)
                    TextInputField("MarkingPeriods", text: $markingPeriods)
                    TextInputField("Periods", text: $periods)
                    TextInputField("Room", text: $room)
                    TextInputField("Status", text: $status)
                    TextInputField("Teacher", text: $teacher)
                    
                }
            }
        }
        .navigationBarTitle(Text("Class Info").font(.subheadline), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            status = schedule.status!
            courseName = schedule.courseName!
            courseCode = schedule.courseCode!
            building = schedule.building!
            days = schedule.days!
            markingPeriods = schedule.markingPeriods!
            periods = schedule.periods!
            room = schedule.room!
            status = schedule.status!
            teacher = schedule.teacher!
            
        }
    }
}

struct ClassDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        var schedule = Schedule()
        ClassDetailsView(schedule: schedule)
    }
}
