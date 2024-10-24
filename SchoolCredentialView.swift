//
//  SchoolCredentialView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 5/21/24.
//

import Foundation
import SwiftUI

struct SchoolCredentialView: View {
    @State var username = ""
    @State var password = ""
    @State var ctoken = ""
    @State var rowid : Int64 = 0
    var dropDownList = ["Select School", "Frisco ISD"]
    @State private var selection = ""
    @ObservedObject var viewModel = EducationViewModel()
    @State var credView: Bool = true
    @State var showingSchoolDetails = false
    @State var showingSheet = false
    @State var showingDetail = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack(alignment: .leading) {
            //Section(header: Text("School Credentials").font(.custom("Arial", size: 12))) {
                //VStack{
            Text("")
            Text("Student School Credentials")
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
                    
                Picker("School Name", selection: $selection) {
                        ForEach(dropDownList, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    TextInputField("HAC Username", text: $username)
                        .padding(.leading, 10)
                    SecureInputField("HAC Password", text: $password)
                        .padding(.leading, 10)
                    
//                    ZStack(alignment: .leading){
//                        Text("HAC Password")
//                            .foregroundStyle(password.isEmpty ? Color(.placeholderText) : .accentColor)
//                            .offset(y: password.isEmpty ? 0 : -25)
//                            .scaleEffect(password.isEmpty ? 1: 0.8, anchor: .leading)
//                        SecureField("", text: $password)
//                            .id("pwd")
//                            .textContentType(.password)
//                            .padding()
//                            .font(.custom("Arial", size: 18))
//                            .frame(width: 300, height: 30)
//                            .background(Color(.white))
//                            .cornerRadius(10.0)
//                    }
//                    .padding(.top, 15)
//                    .animation(.default)
                    TextInputField("Canvas API Token", text: $ctoken)
                        .padding(.leading, 10)
                    HStack{
                        if (credView){
                            Button( action: {
                                viewModel.saveSchoolCred(school: selection, username: username, password: password, ctoken: ctoken)
                                showingSchoolDetails = true
                                let userEducationCred :UserEducationCred = viewModel.getSchoolCred()
                                
                                if(userEducationCred.schoolId != nil ){
                                    print("credView \(self.credView)")
                                    
                                    self.username = userEducationCred.schoolUsername ?? ""
                                    self.selection = userEducationCred.schoolId ?? ""
                                    self.password = userEducationCred.schoolPassword ?? ""
                                    self.ctoken = userEducationCred.cToken ?? ""
                                    self.rowid = userEducationCred.id ?? 0
                                    self.credView = false
                                    print("credView \(self.credView)")
                                    //EducationView(credView: false)
                                    viewModel.getSchoolProf(){schoolpro in
                                        UserDefaults.standard.setValue(schoolpro.name, forKey: "studentName")
                                        UserDefaults.standard.setValue(schoolpro.grade, forKey: "studentGrade")
                                        UserDefaults.standard.setValue(schoolpro.campus, forKey: "studentCampus")
                                    }
                                    dismiss()
                                }
                                
                               // showingDetail.toggle()
                            } ) {
                                Text("Save")
                                    .padding()
                                    .font(.custom("Arial", size: 14))
                                    .foregroundColor(.blue)
                                
                            }
//                            .sheet(isPresented: $showingDetail) {
//                                //SchoolCredentialView()
//                            }
                        }
                        if(!credView){
                            
                            Button( action: {
                                showingSheet.toggle()
                                viewModel.deleteSchoolCred(id: rowid)
                                self.username =  ""
                                self.selection =  ""
                                self.password = ""
                                self.ctoken = ""
                                self.rowid =  0
                                showingSchoolDetails = false
                                credView = true
                                
                            } ) {
                                Text("Reset" )
                                    .padding()
                                    .font(.custom("Arial", size: 14))
                                    .foregroundColor(.red)
                                
                            }
                        }
                    }
            
                //}
            //}
            
        }
        .overlay( /// apply a rounded border
            RoundedRectangle(cornerRadius: 20)
                .stroke(.gray, lineWidth: 1)
        )
        .shadow(color: Color.black.opacity(0.2), radius: 5, x: 0, y: 5)
        .padding(.horizontal, 10)
        .onAppear(){
            let userEducationCred :UserEducationCred = EducationViewModel().getSchoolCred()
            //print("credView \(userEducationCred)")
            //print("credView \(userEducationCred.schoolId)")
            if(userEducationCred.schoolId != nil ){
                print("credView \(self.credView)")
                
                self.username = userEducationCred.schoolUsername ?? ""
                self.selection = userEducationCred.schoolId ?? ""
                self.password = userEducationCred.schoolPassword ?? ""
                self.ctoken = userEducationCred.cToken ?? ""
                self.rowid = userEducationCred.id ?? 0
                self.credView = false
                showingSchoolDetails = true
                viewModel.getSchoolProf(){schoolpro in
                    print(schoolpro)
                    UserDefaults.standard.setValue(schoolpro.name, forKey: "studentName")
                    UserDefaults.standard.setValue(schoolpro.grade, forKey: "studentGrade")
                    UserDefaults.standard.setValue(schoolpro.campus, forKey: "studentCampus")
                    
                }
                print("credView \(self.credView)")
            }else{
                self.username = ""
                self.selection = ""
                self.password = ""
                self.ctoken = ""
                self.rowid = 0
                self.credView = true
            }
        }
        Spacer()
        VStack(alignment: .leading){
            Text("How to Get Canvas API Token?")
            Text("1.Log into Canvas and, on the left, click Account, then click the Settings link.")
                .font(.system(size: 10))
            Text("")
            Text("2.Scroll down to Approved Integrations section and you will see New Access Token button.")
                .font(.system(size: 10))
            Text("")
            Text("3.Click New Access Token.")
                .font(.system(size: 10))
            Text("")
            Text("4.Enter a description(ex: sVue)  in the Purpose fieldType, and you cab set expire to end of school year or leave empty, then click generate token.")
                .font(.system(size: 10))
            Text("")
            Text("5.Copy the token value, which is alphanumberic string and use it in sVue School Credentials section .")
                .font(.system(size: 10))
            Text("")
            
        }
    }
}
    
