//
//  GradesView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/12/24.
//

import Foundation
import SwiftUI
import Charts

struct GradesView_O: View {
    @State var grades = [CourseGrades]()
    @State var name = ""
    @State var grade = ""
    @State var lastUpdated = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        
        NavigationView {
            if(self.model.loading){
                ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
            }
            VStack(alignment: .trailing){
                LazyVGrid(columns: columns, spacing: 30){
                    ForEach(grades, id: \.self){classGrade in
                        
                        NavigationLink (destination: AssignmentsView(assignment_id: classGrade.courseAssignmentId!)){
                            
                            ZStack(alignment: Alignment(horizontal: .trailing, vertical:.top)){
                                VStack(alignment: .leading, spacing: 0){
                                    
                                    Text(classGrade.name!)
                                        .foregroundColor(.white)
                                        .font(.system(size: 12))
                                    Text(classGrade.grade!)
                                        .foregroundColor(.black)
                                        .fontWeight(.bold)
                                    //                                        .font(.title)
                                        .padding(.top,5)
                                        .font(.system(size: 15))
                                    
                                    HStack{
                                        Spacer(minLength: 0)
                                        Text("Assignments")
                                            .foregroundColor(.white)
                                            .font(.system(size: 10))
                                        Text(classGrade.lastUpdated!)
                                            .foregroundColor(.white)
                                            .font(.system(size: 10))
                                    }
                                    
                                }
                                .padding()
                                //.background(Color.black.opacity(0.06))
                                .background(Color("tile_image_6"))
                                //.border(Color(.blue))
                                
                                .cornerRadius(20)
                                .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                                
                                
                            }
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Grades").font(.subheadline), displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(){
                var grd: [CourseGrades] = model.getCourseGrades()
                if(grd == [CourseGrades]()){
                    print("no local records")
                    model.getGrades(){grades in
                        //self.grades = grades.currentClasses!
                        model.insertGrades(grades: grades.currentClasses!)
                    }
                    self.grades = model.getCourseGrades()
                    print("now have records")
                }else{
                    print("have local records")
                    self.grades = grd
                }
                
            }
        }
    }
}




struct GradesView: View {
    @State var grades = [CourseGrades]()
    @State var name = ""
    @State var grade = ""
    @State var lastUpdated = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @ObservedObject var model = EducationViewModel()
    @State var chartView = false
    @State var data = [ChartData]()
    var body: some View {
        NavigationView {

            VStack(alignment: .trailing){
                Text("")
                Text("Semester Score Card")
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                
                Divider()
                    .foregroundColor(.black)
                    .background(.black)
                Text("")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
                            if(self.model.loading){
                                ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                            }
                
                ForEach(grades, id: \.self){classGrade in
                    
                    NavigationLink (destination: AssignmentsView(assignment_id: classGrade.courseAssignmentId!)){
                        
                        Text(classGrade.name!)
                            .foregroundColor(.black)
                            .font(.system(size: 13))
                            .padding(.leading, 10)
                            .multilineTextAlignment(.leading)
                        Text(classGrade.grade!)
                            .foregroundColor(.black)
                            .fontWeight(.bold)
                        
                            .padding(.all, 10)
                            .font(.system(size: 13))
                        
                        Text("Details")
                            .foregroundColor(.black)
                            .font(.system(size: 10))
                            .padding(.all, 10)
                    }
                }
                
                
                Text("")
                Text("")
                Button( action: {
                    chartView.toggle()
                    
                    
                } ) {
                    Text("View Chart" )
                        .padding()
                        .font(.custom("Arial", size: 14))
                        .foregroundColor(.red)
                    
                }
            }
            //.background(Color("tile_image_6"))
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(){
                let grd: [CourseGrades] = model.getCourseGrades()
                if(grd == [CourseGrades]()){
                    print("no local records")
                    model.getGrades(){grades in
                        model.insertGrades(grades: grades.currentClasses!)
                    }
                    self.grades = model.getCourseGrades()
                    print("now have records")
                }else{
                    print("have local records")
                    self.grades = grd
                }
                
                
            }
            .sheet(isPresented: $chartView) {
                GradeChartView(data: grades)
            }
        }
        
        
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
    }
}

struct GradeChartView_1: View {
    var data = [CourseGrades]()
//    var maxChartData: ChartData? {
//        data.max { $0.count < $1.count }
//    }
    var body: some View {
        VStack(alignment: .trailing){
            Text("")
            Text("Semester Score Chart")
                .padding(.all, 10)
                .foregroundColor(.black)
                .font(.title)
                .multilineTextAlignment(.leading)
            
            Divider()
                .foregroundColor(.black)
                .background(.black)
            Chart {
                ForEach(data, id: \.self) { dataPoint in
                    
                    BarMark(x: .value("Subject", dataPoint.name!),
                            y: .value("Score", (dataPoint.grade! as NSString).integerValue))
                    .foregroundStyle(Color.green.opacity(0.5))
                }
                
                RuleMark(y: .value("Grade", 90))
                    .annotation(position: .bottom,
                                alignment: .bottomLeading) {
                        Text("Grade A")
                            .foregroundColor(Color(.green))
                    }
                RuleMark(y: .value("Grade", 80))
                    .annotation(position: .bottom,
                                alignment: .bottomLeading) {
                        Text("Grade B")
                            .foregroundColor(Color(.blue))
                    }
                RuleMark(y: .value("Grade", 70))
                    .annotation(position: .bottom,
                                alignment: .bottomLeading) {
                        Text("Grade C")
                            .foregroundColor(Color(.red))
                    }
            }
            .aspectRatio(1, contentMode: .fit)
            .padding()
        
            }
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }

struct GradeChartView: View {
    var data = [CourseGrades]()
//    var maxChartData: ChartData? {
//        data.max { $0.count < $1.count }
//    }
    var body: some View {
        VStack(alignment: .trailing){
            Text("")
            Text("Semester Score Chart")
                .padding(.all, 10)
                .foregroundColor(.black)
                .font(.title)
                .multilineTextAlignment(.leading)
            
            Divider()
                .foregroundColor(.black)
                .background(.black)
            Chart(data, id: \.self) { dataPoint in
                BarMark(x: .value("Subject", (dataPoint.grade! as NSString).integerValue),
                        y: .value("Score", dataPoint.name!))
                        .foregroundStyle(by: .value("Type", dataPoint.name!))
                        .annotation(position: .trailing) {
                            Text(dataPoint.grade!)
                                .foregroundColor(.gray)
                        }
                    }
                    .chartLegend(.hidden)
                    .chartXAxis(.hidden)
                    .chartYAxis {
                        AxisMarks { _ in
                            AxisValueLabel()
                        }
                    }
                    .aspectRatio(1, contentMode: .fit)
                    .padding()
        
            }
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            )
            .padding(.horizontal, 10)
            
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .navigationViewStyle(StackNavigationViewStyle())
        }
    }


struct ChartData: Identifiable, Equatable {
    let subject: String
    let marks: String

    var id: String { return subject }
}
