//
//  YearGradesView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/1/24.
//

import Foundation
import SwiftUI
import Charts

struct YearGradesView_O: View {
    @State var grades = [Grades]()
    @State var name = ""
    @State var grade = ""
    @State var lastUpdated = ""
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        if(self.model.loading){
            ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
        }
        NavigationView {
            VStack(alignment: .trailing){
                LazyVGrid(columns: columns, spacing: 30){
                    ForEach(grades, id: \.self){classGrade in
                        
                        NavigationLink (destination: AssignmentsView(assignment_id: "0")){
                            
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
                                
                                //top image
                                //                                Image(systemName: dashboard.icon!)
                                //                                    .renderingMode(.template)
                                //                                    .foregroundColor(.white)
                                //                                    .padding()
                                //                                    .background(Color.white.opacity(0.35))
                                //                                    .clipShape(Rectangle())
                            }
                            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                            
                        }
                    }
                }
            }
            .navigationBarTitle(Text("Year Grades").font(.subheadline), displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(){
                //                var grd: [CourseGrades] = EducationViewModel().getYearlyGrades()
                //                if(grd == [CourseGrades]()){
                //                    print("no local records")
                //                    EducationViewModel().getGrades(){grades in
                //                        //self.grades = grades.currentClasses!
                //                        EducationViewModel().insertGrades(grades: grades.currentClasses!)
                //                    }
                //                    self.grades = EducationViewModel().getCourseGrades()
                //                    print("now have records")
                //                }else{
                //                    print("have local records")
                //                    self.grades = grd
                //                }
                model.getYearlyGrades(qtr: 1){ grades in
                    self.grades = grades.pastClasses!
                }
            }
        }
    }
}


struct YearGradesView: View {
    @State var grades = [Grades]()
    @State var name = ""
    @State var grade = ""
    @State var lastUpdated = ""
    @State var chartView = false
    @State var data = [ChartData]()
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        
        //NavigationView {
            
            VStack(alignment: .trailing){
                Text("")
                Text("Year Score Card")
                    .padding(.all, 10)
                    .foregroundColor(.black)
                    .font(.title)
                    .multilineTextAlignment(.trailing)
                HStack{
                    Button( action: {
                        //
                        model.getYearlyGrades(qtr: 1){ grades in
                            self.grades = grades.pastClasses!
                        }
                        
                    } ){
                        Text("S1")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .padding(.all, 10)
                    }
                    Text("|")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.all, 10)
                    Button( action: {
                        //
                        model.getYearlyGrades(qtr: 2){ grades in
                            self.grades = grades.pastClasses!
                        }
                        
                    } ){
                        Text("S2")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .padding(.all, 10)
                    }
                    Text("|")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.all, 10)
                    Button( action: {
                        //
                        model.getYearlyGrades(qtr: 3){ grades in
                            self.grades = grades.pastClasses!
                        }
                        
                    } ){
                        Text("S3")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .padding(.all, 10)
                    }
                    Text("|")
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .padding(.all, 10)
                    Button( action: {
                        //
                        model.getYearlyGrades(qtr: 4){ grades in
                            self.grades = grades.pastClasses!
                        }
                        
                    } ){
                        Text("S4")
                            .foregroundColor(.black)
                            .font(.system(size: 15))
                            .padding(.all, 10)
                    }
                    
                }
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
                    
                    //NavigationLink (destination: AssignmentsView(assignment_id: "0")){
                    HStack{
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
                    }
                   // }
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
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 10)
            .navigationViewStyle(StackNavigationViewStyle())
            
            .onAppear(){
                model.getYearlyGrades(qtr: 1){ grades in
                    self.grades = grades.pastClasses!
                }
                
            }
            .sheet(isPresented: $chartView) {
                YearGradeChartView(data: grades)
            }
            
        //}
        

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

struct YearGradeChartView: View {
    var data = [Grades]()
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
