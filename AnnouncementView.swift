//
//  AnnouncementView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 8/1/24.
//

import Foundation
import SwiftUI

struct AnnouncementView: View {
    @State var announcements = [Announcements]()
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        
        NavigationView{
            VStack(alignment: .leading, spacing: 0){
                Text("")
                Text("Announcements")
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
//                ForEach($announcements, id: \.self){announcement in
//                    if((announcement.name) != nil){
//                    NavigationLink (destination: AnnouncementDetailView()){
//                        Text("\(announcement.name)")
//                                .foregroundColor(.black)
//                                .font(.system(size: 12))
//                                .padding(.all, 10)
//                            Text("")
//                            Text("[\(announcement.count!)]")
//                            Text("View")
//                                .foregroundColor(.black)"
//                                .font(.system(size: 10))
//                                .fontWeight(.bold)
//                                .padding(.all, 10)
//                        }
//                    }
//                    
//                }
                
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
            .frame(minWidth: 0, maxWidth: .infinity, minHeight: 0, maxHeight: .infinity, alignment: .topLeading)
            .onAppear(){
                model.getAnnoucements(){ plist in
                    print("Announcements: \(plist)")
                    self.announcements = plist
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


struct AnnouncementDetailView: View {
    @State var announcements = Announcements()
    @State var id : Int64 = 1234
    @State var courseName  = ""
    //var columns = Array(repeating: GridItem(.flexible(), spacing: 10), count: 4)
    @ObservedObject var model = EducationViewModel()
    var body: some View {
        Text("coming soon")
//        List {
//            Section(header: Text("\(courseName)").font(.custom("Arial", size: 12))) {
//                VStack{
//                    //if (announcements.count > 0){
//                        if(self.model.loading){
//                            ActivityIndicator(isAnimating: .constant(self.model.loading), style: .large)
//                        }
//                    ForEach(announcements, id: \.self ){announce in
//                            if(announce.name != nil){
////                                Text(announce.id!)
////                                    .foregroundColor(.black)
////                                    .font(.system(size: 15))
////                                    .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
//                                
//                                
//                                Text(announce.name!)
//                                        .foregroundColor(.green)
//                                        .font(.system(size: 10))
//                                        .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
//                                
//                                                                                            
//                            }
//                            Divider()
//                        }
////                    }else{
////                        Text("No pending work")
////                            .foregroundColor(.black)
////                            .font(.system(size: 12))
////                            .frame(minWidth: 10, maxWidth: .infinity, alignment: .leading)
////                    }
//                    
//                }
//            }
//        }
//        .navigationBarTitle(Text("Announcement Details").font(.subheadline), displayMode: .inline)
//        .navigationViewStyle(StackNavigationViewStyle())
//        .onAppear(){
//            print(id)
//        }
        
        
        
    }
}
