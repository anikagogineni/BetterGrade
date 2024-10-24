//
//  AIPlannerView.swift
//  BetterGrade
//
//  Created by Srujan Gogineni on 10/6/24.
//

import Foundation

import SwiftUI

struct AIPlannerView: View {
   
    @State var str = ""
    @State var plans = [StudyPlans]()
    @State var schedule = [Schedule]()
    
    @State private var showingAlert = false
    @ObservedObject var model = AIPlannerModel()
    @ObservedObject var model1 = EducationViewModel()
    
    var body: some View {
        NavigationView {
            VStack (alignment: .leading, spacing: 0){
               // Section(header: Text("Person").font(.custom("Arial", size: 12))) {
                    //VStack{
                Text("")
                Text("Study Planner[AI]")
                    .padding(.all, 15)
                    .foregroundColor(.black)
                    .font(.title)
                    .multilineTextAlignment(.leading)
                
                Divider()
                    .foregroundColor(.black)
                    .background(.black)
                Text("")
                    .foregroundColor(.white)
                    .font(.system(size: 15))
            //loading image start
                        if(self.model.loading){
                            ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                        }
            //loading image end
            
                //Planner date model goes here
            HStack{
                Text("Course Name")
                    .foregroundColor(.white)
                    .font(.system(size: 20))
                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                
            }.background(Color.blue)
            
            ForEach(schedule, id: \.self ){course in
                NavigationLink (destination:  StudyPlanView(subject: course.courseCode!)){
                Divider()
                HStack() {
                    Text(course.courseCode!)
                        .foregroundColor(.black)
                        .font(.system(size: 15))
                        .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                    
                    Menu {
                        //create study plan
                        Button(action: {
                            Task{
                                
                                var le =  await model.createUserPlanner(course: course.courseCode! , message: "create study plan by topics for 11th grade " + course.courseCode! + " with active links in a json format only using json structure as root" +
                                                                        " struct AIStudyModelPlan: Codable { " +
                                                                        " let title, description: String " +
                                                                        " let resourceLinks: [ResourceLink] struct ResourceLink: Codable {    let topic: String    let links: [String]} " )
                                
                            }
                        }, label: {
                            Text("Create Plan")
                                .foregroundColor(Color.blue)
                                .font(.custom("Arial", size: 14))
                        })
                        
                        //view study plan
                        Button(action: {
                            model.deleteStudyPlan(subject: course.courseCode!)
                            
                        }, label: {
                            Text("Delete Plan")
                                .foregroundColor(Color.red)
                                .font(.custom("Arial", size: 14))
                        })
                        .buttonStyle(PlainButtonStyle())
                        
                    }label: {
                        Label( "", systemImage: "ellipsis")
                    }
                    
                }
                }
                
            }
                //end of planner
                        
                   // }
                    
               // } //section self
                               
            }
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 10)
            //.navigationBarTitle(Text("Profile").font(.subheadline), displayMode: .inline)
            .navigationViewStyle(StackNavigationViewStyle())
            //.navigationTitle(Text("Profile").font(.subheadline))
            .onAppear {
                        let cList: [Schedule] = model1.getLocalSchedule(marking_periods: "Q1, Q2")
                            if(cList == [Schedule]()){
                                print("no local course records")
                            
                            }else{
                                print("have local course records")
                                self.schedule = cList
                            }
                
                    }
                }
    
            }
        }
    


struct AIPlannerView_Previews: PreviewProvider {
    static var previews: some View {
       // print("profileview called")
        AIPlannerView()
    }
}


