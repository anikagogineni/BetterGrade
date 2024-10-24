//
//  MainView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/12/24.
//

import SwiftUI

struct MainView: View {
    
    var body: some View {
        ZStack (alignment: .topTrailing){
            TabView {
                HomeView()
                     .tabItem {
                         Image(systemName: "house")
                         Text("Home")
                     }.tag(1)

                SettingsView()
                    .tabItem {
                        Image(systemName: "gear")
                        Text("Settings")
                    }.tag(2)
                

            }
            .onAppear(){
                UITabBar.appearance().barTintColor = .white
                
                
            }
            .accentColor(.teal)
        
            Button(action: {
                //notification view TODO

            }) {
                Image( systemName: "bell")
                    .padding()
                    .foregroundColor(.teal)

            }
        }
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}

