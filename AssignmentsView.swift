//
//  Assignments.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/25/24.
//

import Foundation
import SwiftUI

struct AssignmentsView: View {
    @State var assignments = [Assignments]()
    @State var assignment_id: String
    @State var name = ""
    @State var category = ""
    @State var dateAssigned = ""
    @State var dateDue = ""
    @State var score = ""
    @State var totalPoints = ""

    var body: some View {
        List {
            Section(header: Text("Assignment Details").font(.custom("Arial", size: 12))) {
                VStack{
                    
//                    TextInputField("Name", text: $name)
//                    TextInputField("Category", text: $category)
//                    TextInputField("DateAssigned", text: $dateAssigned)
//                    TextInputField("DateDue", text: $dateDue)
//                    TextInputField("Score", text: $score)
//                    TextInputField("TotalPoints", text: $totalPoints)
                    HStack{
                        Text("  Name")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Category")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Assigned")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Due")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Score")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Total")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            Divider()
                        Text("Action")
                            .foregroundColor(.white)
                            .font(.system(size: 10))
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                                
                    }
                    .background(Color.blue)
                    ForEach(assignments , id:\.self) { assignment in
                        Divider()
                        HStack{
                            Group{
                                Text(assignment.name!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text(assignment.category!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text(assignment.dateAssigned!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text(assignment.dateDue!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text(assignment.score!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Text(assignment.totalPoints!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10 ))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                Menu {
                                    //view identity
                                    Button(action: {
                                        //self.selectedIdentityId = model.id
                                        //self.ViewIdentitySelected = true
                                    }, label: {
                                        Text("ToDo")
                                            .foregroundColor(Color.blue)
                                            .font(.custom("Arial", size: 14))
                                    })
                                                                                            
                                    //delete identity
                                    Button(action: {
                                        //delete action
        //                                self.showAlert = true
        //                                self.selectedIdentityId = model.id
                                        
                                    }, label: {
                                        Text("Follow")
                                            .foregroundColor(Color.red)
                                            .font(.custom("Arial", size: 14))
                                    })
                                    .buttonStyle(PlainButtonStyle())
                                }label: {
                                    Label( "", systemImage: "ellipsis")
                                }
                            }
                            .lineLimit(3)
                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            .padding(1)
                            
                        }
                        
                    }
                }
            }
        }
        //.navigationBarTitle(Text("Class Info").font(.subheadline), displayMode: .inline)
        //.navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
//            name = assignments[0].name!
//            category = assignments[0].category!
//            dateAssigned = assignments[0].dateAssigned!
//            dateDue = assignments[0].dateDue!
//            score = assignments[0].score!
//            totalPoints = assignments[0].totalPoints!
//            
            //self.assignments_id = assignments_id
            self.assignments =  EducationViewModel().getCourseAssignments(course_assignment_id: assignment_id)
            
        }
    }
}

