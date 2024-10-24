//
//  ContentView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 5/2/24.
//

import SwiftUI

struct ContentView: View {
    @State var isAuthenticated = AppManager.IsAuthenticated()
    var body: some View {
        VStack{
            Group {
                isAuthenticated ?
                AnyView(MainView()) :
                AnyView(SetupView())
                
                
            }
            .onReceive(AppManager.Authenticated, perform: {
                isAuthenticated = $0
            })
        }
//        MainView()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


struct TextInputField: View {
    var title: String
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>){
        self._text = text
        self.title = title
    }
    
    var body: some View{
        ZStack(alignment: .leading){
            Text(title)
                .foregroundColor(text.isEmpty ? Color(.placeholderText): .accentColor)
                .font(.custom("Arial", size: 12))
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
            TextField("", text: $text)
                .font(.custom("Arial", size: 14))
        }
        .padding(.top, 15)
        .animation(.default)
    }
}

struct SecureInputField: View {
    var title: String
    @Binding var text: String
    
    init(_ title: String, text: Binding<String>) {
        self.title = title
        self._text = text
    }
    
    var body: some View{
        ZStack(alignment: .leading){
            Text(title)
                .foregroundStyle(text.isEmpty ? Color(.placeholderText) : .accentColor)
                .font(.custom("Arial", size: 12))
                .offset(y: text.isEmpty ? 0 : -25)
                .scaleEffect(text.isEmpty ? 1: 0.8, anchor: .leading)
            SecureField("", text: $text)
                .textContentType(.password)
                .padding()
                .font(.custom("Arial", size: 14))
        }
        .padding(.top, 15)
        .animation(.default)
    }
}
