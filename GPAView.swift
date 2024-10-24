//
//  GPAView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/10/24.
//

import Foundation
import SwiftUI

struct GPAView: View {

    @State var unweightedGPA = ""
    @State var rank = ""
    @State var weightedGPA = ""
    
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        Spacer()
        VStack(alignment: .leading) {
            
            Text("Current GPA")
                .padding(.all, 15)
                .foregroundColor(.black)
                .font(.title)
                .multilineTextAlignment(.trailing)
            Divider()
                .foregroundColor(.black)
                .background(.black)
            
                .foregroundColor(.white)
                .font(.system(size: 15))
                
                    if(self.model.loading){
                        ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
                    }else{
                        if(weightedGPA == "" || weightedGPA == nil){
                            Text("GPA is not available for your grade level")
                            
                        }else{
                            Text("")
                            HStack{
                                Text("UnweightedGPA :")
                                    .padding(.leading, 10)
                                    .multilineTextAlignment(.leading)
                                Text("\(unweightedGPA)")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            HStack{
                                Text("WeightedGPA :")
                                    .padding(.leading, 10)
                                    .multilineTextAlignment(.leading)
                                Text("\(weightedGPA)")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            HStack{
                                Text("Rank :")
                                    .padding(.leading, 10)
                                    .multilineTextAlignment(.leading)
                                Text("\(rank)")
                                    .foregroundColor(.black)
                                    .fontWeight(.bold)
                            }
                            Text("")
                            Text("")
                          
                        }
                    }
        }
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
        .padding(.horizontal, 10)
        //.navigationBarTitle(Text("GPA").font(.subheadline), displayMode: .inline)
        .navigationViewStyle(StackNavigationViewStyle())
        .onAppear(){
            model.getGPA(){ gpa in
                if(gpa.unweightedGPA != nil){
                    self.weightedGPA = gpa.weightedGPA!
                    self.rank = gpa.rank!
                    self.unweightedGPA = gpa.unweightedGPA!
                }
                //self.credView = false
                
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
