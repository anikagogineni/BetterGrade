//
//  dTwinApp.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 5/2/24.
//

import SwiftUI

@main
struct dTwinApp: App {
    //let db = DBHelper()
    let db = DBManager.initDB()
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
