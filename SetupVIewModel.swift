//
//  SetupVIewModel.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 7/18/24.
//

import Foundation

class SetupViewModel : ObservableObject{
    
    //var dataStore = DBHelper()
    
    func getRegistration() -> String {
        return DBManager.queryRegistration()
    }
    
    func saveRegistration(phoneNumber: String){
        DBManager.insertRegistration(phoneNumber: phoneNumber)
    }
    
    func deRegister(){
        DBManager.deRegister()
    }
}
