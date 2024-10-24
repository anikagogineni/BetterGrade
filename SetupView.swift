//
//  SetupView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/18/24.
//

import Foundation
import SwiftUI

struct SetupView: View {
    @State var phonenumber = ""
    
    @State private var wrongUsername = 0
    @State private var wrongPassword = 0
    @State var showAlert = false
    //@ObservedObject var viewModel = LoginViewModel()
    @State var isAuthenticated:Bool = false
    
    let defaults = UserDefaults.standard
    var body: some View {
        
        ZStack{
            VStack() {
                Spacer()
                Text("BetterGrade")
                    .font(.title)
                    .foregroundColor(Color.black)
                    //.padding([.top, .bottom], 50)
                    .shadow(radius: 6.0, x: 10, y: 10)
                Spacer()
                Text("BetterGrade helps student to manage & view classroom taks, schedules, garades with reminder and notifications.")
                    .font(.body)
                    .foregroundColor(Color.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                Spacer()
                Image("curious_vue")
                    .resizable()
                    .frame(width: 150, height: 150)
                    .clipShape(Circle())
                    .overlay(Circle()
                        .stroke(Color.white, lineWidth: 1))
                    .shadow(radius: 9.0, x: 10, y: 11)
                    //.padding(.bottom, 30)
                Spacer()
                Text("To start using enter you phone number and click next")
                    .font(.body)
                    .foregroundColor(Color.black)
                    .lineLimit(nil)
                    .fixedSize(horizontal: false, vertical: true)
                    .padding(10)
                HStack() {
//                    TextField("Phone Number", text: $phonenumber)
//                        .autocapitalization(.none)
//                        .disableAutocorrection(true)
//                        .font(.custom("Arial", size: 15))
//                        .padding()
//                        .frame(width: 200, height: 50)
//                        .background(Color(.white))
//                        .cornerRadius(10.0)
//                        .shadow(radius: 5.0, x: 5, y: 10)
                    TextInputField("Phone Number", text: $phonenumber)
                        .font(.custom("Arial", size: 12))
                        .padding(10)
                        .background(Color(.white))
                        .shadow(radius: 5.0, x: 5, y: 10)
                        //.cornerRadius(9)
                        .keyboardType(.phonePad)
                        .autocapitalization(.none)
                        //.border(Color.gray)
                        .frame(width: 200, height: 50)
                        .disableAutocorrection(true)
                    //.border(.red, width: <#T##CGFloat#>)
                    
                    Button(action: {
                        let pnumber = self.phonenumber
                        
                        //print("token: \(String(describing: token))")
                        if pnumber != nil {
                            print("save the registration")
                            defaults.setValue(pnumber, forKey: "phonenumber")
                            //SetupViewModel().deRegister()
                            SetupViewModel().saveRegistration(phoneNumber: pnumber)
                            AppManager.Authenticated.send(true)
                        }else{
                            print("force user to key in phonenumber")
                            AppManager.Authenticated.send(false)
                        }
                    }) {
                        Text("Next")
                            .foregroundColor(.white)
                            .padding()
                            .font(.custom("Arial", size: 15))
                            .frame(width: 80, height: 50)
                            .background(Color.orange)
                            .cornerRadius(10.0)
                            .shadow(radius: 5.0, x: 5, y: 10)
                    }//.padding(.top, 10)
                }
                //.padding([.leading, .trailing], 200)
                
                Spacer()
                Spacer()
                Text("2024, BetterGrade")
                    .font(.system(size: 8))
                    //.padding(.center)
                Text("v202410")
                    .font(.system(size: 8))
                
            }
            
            //        .background(
            //            LinearGradient(gradient: Gradient(colors: [Color.blue, Color.gray]), startPoint: .top, endPoint: .bottom)
            //                .ignoresSafeArea()
            //                .edgesIgnoringSafeArea(.all))
        }
//        .background(AngularGradient(gradient: Gradient(colors: [.green, .blue, .black, .green, .blue, .black, .green]), center: .center)
//            .ignoresSafeArea()
//            .edgesIgnoringSafeArea(.all))
        
    }
}

struct SetupView_Previews: PreviewProvider {
    static var previews: some View {
        SetupView()
    }
}
