//
//  ScheduleView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/1/24.
//

import Foundation
import SwiftUI

//struct ScheduleView: View {
//    @State var schedules = [Schedule]()
//    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
//    
//    var body: some View {
//        NavigationView {
//            List{
//                Section("Courses"){
//                        if (schedules != nil){
//                            ForEach(schedules, id: \.self ){schedule in
//                                    VStack(alignment: .trailing) {
//                                        NavigationLink (destination: ClassDetailsView(schedule: schedule)){
//                                            Text(schedule.courseName!)
//                                                .font(.system(size: 10))
//                                        }
//                                    }
//                            }
//                        }
//                }
//            }
//            .navigationBarTitle(Text("Schedule").font(.subheadline), displayMode: .inline)
//            .navigationViewStyle(StackNavigationViewStyle())
//            .onAppear(){
//                EducationViewModel().getSchedule(){schoolSchedule in
//                    schedules = schoolSchedule.studentSchedule!
//                }
//            }
//        }
//        
//        
//    }
//}

struct ScheduleView: View {
    @State var schedules = [Schedule]()
    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        NavigationView {
            List{
                Section("Courses"){
                        if (schedules != nil){
                            if(self.model.loading){
                                ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                            }
                            HStack{
                                Text("Name")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Code")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Room")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()

                                Text("Building")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Days")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Periods")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Teacher")
                                    .foregroundColor(.blue)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                        
                            }
                            ForEach(schedules, id: \.self ){schedule in
                                if(schedule.markingPeriods == "Q1, Q2"){
                                    HStack() {
                                        Text(schedule.courseName!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(schedule.courseCode!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(schedule.room!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        

                                        Text(schedule.building!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                        Text(schedule.days!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        Text(schedule.periods!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        Text(schedule.teacher!)
                                            .foregroundColor(.black)
                                            .font(.system(size: 10))
                                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                        
                                    }
                                }
                            }
                        }
                }
            }
            .navigationBarTitle(Text("Schedule").font(.subheadline), displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(){
                var sch: [Schedule] = model.getLocalSchedule(marking_periods: "Q1, Q2")
                if(sch == [Schedule]()){
                    print("no local records")
                    model.getSchedule(){schoolSchedule in
                        schedules = schoolSchedule.studentSchedule!
                        model.insertSch(schedule: schedules)
                    }
                }else{
                    print("have local records")
                    schedules = sch
                }
                
                
            }
        }
        
        
    }
}
