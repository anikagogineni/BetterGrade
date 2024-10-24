//
//  CourseScheduleView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/25/24.
//

import Foundation
import SwiftUI

struct CourseScheduleView: View {
    
    @State var tabIndex = 0
    
    var body: some View {
        //VStack{
            ScrollView{
                VStack{
                    Text("Class Schedule")
                        .padding(.all, 15)
                        .foregroundColor(.black)
                        .font(.title)
                        .multilineTextAlignment(.leading)
                    CustomTopTabBar(tabIndex: $tabIndex)
                    if tabIndex == 0 {
                        FirstView()
                    }
                    else {
                        SecondView()
                    }
                    Spacer()
                    Spacer()
                }
                .frame(width: UIScreen.main.bounds.width - 24, alignment: .center)
                //.padding(.horizontal, 12)
                .overlay( /// apply a rounded border
                    RoundedRectangle(cornerRadius: 20)
                        .stroke(.gray, lineWidth: 1)
                )
                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                .padding(.horizontal, 10)
                //.padding()
        
            }
        //}
        
    }
}
struct FirstView: View{
    @State var schedules = [Schedule]()
    @ObservedObject var model = EducationViewModel()
    var body: some View{
       
            VStack{
                
                        if (schedules != nil){
                            if(self.model.loading){
                                ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                            }
                            HStack{
                                Text("Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Code")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Room")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()

                                Text("Building")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Days")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Periods")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Teacher")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                        
                            }
                            .background(Color.gray)
                            ForEach(schedules, id: \.self ){schedule in
                                
                                    Divider()
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
            //.navigationBarTitle(Text("Schedule").font(.subheadline), displayMode: .inline)
            //.navigationViewStyle(StackNavigationViewStyle())
            .padding()
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

struct SecondView: View{
    @State var schedules = [Schedule]()
    @ObservedObject var model = EducationViewModel()
    var body: some View{
        VStack {
                        if (schedules != nil){
                            if(self.model.loading){
                                ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                            }
                            HStack{
                                Text("Name")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Code")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Room")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()

                                Text("Building")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Days")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                
                                Text("Periods")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                    Divider()
                                Text("Teacher")
                                    .foregroundColor(.white)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                        
                            }
                            .background(Color.gray)
                            ForEach(schedules, id: \.self ){schedule in
                                Divider()
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
            //.navigationBarTitle(Text("Schedule").font(.subheadline), displayMode: .inline)
            //.navigationViewStyle(StackNavigationViewStyle())
             .padding()
            .onAppear(){
                var sch: [Schedule] = model.getLocalSchedule(marking_periods: "Q3, Q4")
                if(sch == [Schedule]()){
                    print("no local records")
                    model.getSchedule(){schoolSchedule in
                        schedules = schoolSchedule.studentSchedule!
                        model.insertSch(schedule: schedules)
                    }
                }else{
                    print("have local records")
                    schedules = sch
                    //print(sch)
                }
                
                
            }
        
    }
}

struct CustomTopTabBar: View {
    @Binding var tabIndex: Int
    var body: some View {
        VStack{            
            HStack(spacing: 20) {
                Spacer()
                TabBarButton(text: "Q1/Q2", isSelected: .constant(tabIndex == 0))
                    .onTapGesture { onButtonTapped(index: 0) }
                TabBarButton(text: "Q3/Q4", isSelected: .constant(tabIndex == 1))
                    .onTapGesture { onButtonTapped(index: 1) }
                Spacer()
            }
            .border(width: 1, edges: [.bottom], color: .black)
        }
    }
    
    private func onButtonTapped(index: Int) {
        withAnimation { tabIndex = index }
    }
}

struct TabBarButton: View {
    let text: String
    @Binding var isSelected: Bool
    var body: some View {
        Text(text)
            .fontWeight(isSelected ? .heavy : .regular)
            .font(.custom("Avenir", size: 16))
            .padding(.bottom,10)
            .border(width: isSelected ? 2 : 1, edges: [.bottom], color: .black)
    }
}

struct EdgeBorder: Shape {

    var width: CGFloat
    var edges: [Edge]

    func path(in rect: CGRect) -> Path {
        var path = Path()
        for edge in edges {
            var x: CGFloat {
                switch edge {
                case .top, .bottom, .leading: return rect.minX
                case .trailing: return rect.maxX - width
                }
            }

            var y: CGFloat {
                switch edge {
                case .top, .leading, .trailing: return rect.minY
                case .bottom: return rect.maxY - width
                }
            }

            var w: CGFloat {
                switch edge {
                case .top, .bottom: return rect.width
                case .leading, .trailing: return self.width
                }
            }

            var h: CGFloat {
                switch edge {
                case .top, .bottom: return self.width
                case .leading, .trailing: return rect.height
                }
            }
            path.addPath(Path(CGRect(x: x, y: y, width: w, height: h)))
        }
        return path
    }
}
extension View {
    func border(width: CGFloat, edges: [Edge], color: SwiftUI.Color) -> some View {
        overlay(EdgeBorder(width: width, edges: edges).foregroundColor(color))
    }
}
