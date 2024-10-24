//
//  StudyPlanView.swift
//  BetterGrade
//
//  Created by Srujan Gogineni on 10/7/24.
//

import Foundation
import SwiftUI

struct StudyPlanView: View {
  
    @State var subject : String
    @State var plans = [StudyPlans]()
    @State private var isShowingSecondView : Bool = false
        
    
    @State private var showingAlert = false
    @ObservedObject var model = AIPlannerModel()
    
    
    var body: some View {
        NavigationView {
                    VStack (alignment: .leading, spacing: 0){
                        // Section(header: Text("Person").font(.custom("Arial", size: 12))) {
                        //VStack{
                        Text("")
                        Text("Study Plan[AI]")
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
                            Text("Topic Name [\(self.subject) ]" )
                                .foregroundColor(.white)
                                .font(.system(size: 20))
                                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                            
                        }.background(Color.blue)
                        
                        ForEach(plans, id: \.self ){plan in
                            
                            Divider()
                            HStack() {
                                Text(plan.title!)
                                    .foregroundColor(.black)
                                    .font(.system(size: 10))
                                    .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                
                                //                        Text(plan.description!)
                                //                            .foregroundColor(.black)
                                //                            .font(.system(size: 10))
                                //                            .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                                let links = plan.resourceLinks?.components(separatedBy: ",")
                                VStack{
                                    ForEach(links!, id:\.self) { link in
                                        Link( "\(link)", destination: URL(string: link)!)
                                            .font(.system(size: 10))
                                        
                                    }
                                }
                                
                                
                                
                                
                            }
                            
                            
                        }
                        //end of planner
                        
                        // }
                        
                        // } //section self
                        
                        
                        
//                        NavigationLink(destination: AIPlannerView()) {
//                           
//                            Button(action: {  model.deleteStudyPlan(subject: self.subject)}) {
//                                Text("Delete Study Plan")
//                                }
//                        }
                        
                        
                        
                    }
                    .overlay( /// apply a rounded border
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(.gray, lineWidth: 1)
                    )
                    .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
                    .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
                    .padding(.horizontal, 10)
                    //.navigationBarTitle(Text("Profile").font(.subheadline), displayMode: .inline)
                    .navigationViewStyle(StackNavigationViewStyle())
                    //.navigationTitle(Text("Profile").font(.subheadline))
                    .onAppear {
                        
                        let pln: [StudyPlans] = model.getStudyPlans(subject: self.subject)
                        if(pln == [StudyPlans]()){
                            print("no local records")
                            
                        }else{
                            print("have local records")
                            self.plans = pln
                        }
                        
                    }
        
                }
        
                }
    
            
        }
    


//struct StudyPlanView_Previews: PreviewProvider {
//    static var previews: some View {
//       // print("profileview called")
//        StudyPlanView()
//    }
//}
