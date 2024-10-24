//
//  HomeworkPlannerView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/25/24.
//


import Foundation
import SwiftUI
struct HomeworkPlannerView: View {
    @State var planner = [HomeworkPlanner]()
    @State var id : Int64 = 1234
    @State var courseName  = ""
    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        
        List {
            Section(header: Text("\(courseName)").font(.custom("Arial", size: 12))) {
                VStack(alignment: .leading, spacing: 0){
                    if (planner.count > 0){
                        if(self.model.loading){
                            ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                        }
                        ForEach(planner, id: \.self ){planner in
                            if(planner.context_name != nil){
                                Text("\((planner.plannable?.title!)!)")
                                    .foregroundColor(.black)
                                    .font(.system(size: 15))
                                    .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                
                                if((planner.submissions?.submitted!) != true){
                                    Text("Submitted: [Pending]")
                                        .foregroundColor(.red)
                                        .font(.system(size: 10))
                                        .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                }else{
                                    Text("Submitted: [Yes]")
                                        .foregroundColor(.green)
                                        .font(.system(size: 10))
                                        .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                }
                                
                                //                                    switch planner.submissions{
                                //                                    case Bool:
                                //                                        break
                                //                                    case Submissions:
                                //                                        if((.submitted!) != true){
                                //                                            Text("Submitted: [Pending]")
                                //                                                .foregroundColor(.red)
                                //                                                .font(.system(size: 10))
                                //                                                .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                //                                        }else{
                                //                                            Text("Submitted: [Yes]")
                                //                                                .foregroundColor(.green)
                                //                                                .font(.system(size: 10))
                                //                                                .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                //                                        }
                                //                                        break
                                //
                                //                                    }
                                
                                if(planner.plannable?.points_possible != nil){
                                    Text("Points: [\((planner.plannable?.points_possible!)!)]")
                                        .foregroundColor(.red)
                                        .font(.system(size: 10))
                                        .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                }
                                if(planner.plannable?.due_at != nil){
                                    // Create Date Formatter
                                    //                                    let dateFormatter = DateFormatter()
                                    //                                    let currentDateTime = Date()
                                    //                                    // Set Date Format
                                    //                                    dateFormatter.dateFormat = "yyyy-MM-ddTHH:mm:ssZ"
                                    //                                    // Convert String to Date
                                    //                                    let dueDate = dateFormatter.date(from: planner.plannable?.due_at)
                                    //                                    let nowDate = dateFormatter.date(from: currentDateTime)
                                    //let color = "green"
                                    //                                    if(nowDate < dueDate){
                                    //                                        color = "red"
                                    //                                    }
                                    Text("Due: [\((planner.plannable?.due_at!)!)]")
                                        .foregroundColor(.blue)
                                        .font(.system(size: 10))
                                        .foregroundStyle(Color(.blue))
                                        .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                                }
                            }
                            Divider()
                        }
                    }else{
                        Text("No pending work")
                            .foregroundColor(.black)
                            .font(.system(size: 12))
                            .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)

            }
        }
        .navigationBarTitle(Text("Homework Planner").font(.subheadline), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            model.getPlanner(id: id){hplanner in
                planner = hplanner
                print("count: \(hplanner.count)")
            }
            // self.courseName = (planner.first?.context_name)!
        }
        
        
        
    }
}


struct ActivityIndicator: UIViewRepresentable {
    
    @Binding var isAnimating: Bool
    let style: UIActivityIndicatorView.Style
    
    func makeUIView(context: UIViewRepresentableContext<ActivityIndicator>) -> UIActivityIndicatorView {
        return UIActivityIndicatorView(style: style)
    }
    
    func updateUIView(_ uiView: UIActivityIndicatorView, context: UIViewRepresentableContext<ActivityIndicator>) {
        isAnimating ? uiView.startAnimating() : uiView.stopAnimating()
    }
}


struct HomeworkPlannerListView: View {
    @State var plannerList = [CourseList]()
    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
    @ObservedObject var model = EducationViewModel()
    var columns = Array(repeating: GridItem(.flexible(), spacing: 20), count: 2)
    var body: some View {
        NavigationView{
            VStack(alignment: .trailing){
                Text("")
                Text("Homework Planner")
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
                ForEach(plannerList, id: \.self){classGrade in
                    if(classGrade.term?.name != "Default Term"){
                        NavigationLink (destination: HomeworkPlannerView(id: classGrade.id!, courseName: classGrade.name!)){
                            Text(classGrade.name!)
                                .foregroundColor(.black)
                                .font(.system(size: 12))
                                .padding(.all, 10)
                            Text("")
                            Text("ToDos")
                                .foregroundColor(.black)
                                .font(.system(size: 10))
                                .fontWeight(.bold)
                                .padding(.all, 10)
                        }
                    }
                    
                }
                
                Text("")
                Text("")
                
            }
            //.background(Color("tile_image_4"))
            .cornerRadius(20)
            .overlay( /// apply a rounded border
                RoundedRectangle(cornerRadius: 20)
                    .stroke(.gray, lineWidth: 1)
            )
            .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
            .padding(.horizontal, 10)
            .navigationViewStyle(StackNavigationViewStyle())
            .onAppear(){
                model.getCoursePlannerList(){ plist in
                    self.plannerList = plist
                }
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


struct PlannerAssignmentsView: View {
    @State var id : Int64 = 1234
    var body: some View {
        Text("Assignment: \(id)")
    }
}
