//
//  PreloadView.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/26/24.
//

import Foundation
import SwiftUI

struct PreloadView: View {
    @State var isCredentialsAvailable = AppManager.IsCredentialsAvailable()
    var body: some View {
        VStack{
            Group {
                isCredentialsAvailable ?
                AnyView(MainView()) :
                AnyView(SchoolCredentialView())
                
                
            }
            .onReceive(AppManager.Credentials, perform: {
                isCredentialsAvailable = $0
            })
        }
        .onAppear(){
            let pnumber = SetupViewModel().getRegistration()
            let credentials = (EducationViewModel().getSchoolCred()).schoolId
            if (pnumber == "" || pnumber == nil){
                AppManager.Authenticated.send(false)
                print("Need to register")
                //SetupView()
            }
            if (credentials == "" || credentials == nil){
                print("Need to setup credentials")
                //AnyView(SchoolCredentialView())
                AppManager.Credentials.send(false)
                
                //SetupView()
            }else{
                UserDefaults.standard.setValue(credentials, forKey: "credentials")
                AppManager.Credentials.send(true)
                print("setup credentials exists")
            }
        }

    }
}

struct PreloadView_Previews: PreviewProvider {
    static var previews: some View {
        PreloadView()
    }
}
