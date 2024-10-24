//
//  AppManager.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 5/25/24.
//

import Foundation
import Combine

struct AppManager {
    static let Authenticated = PassthroughSubject<Bool, Never>()
    static func IsAuthenticated() -> Bool {
        return UserDefaults.standard.string(forKey: "phonenumber") != nil
    }
    static let Credentials = PassthroughSubject<Bool, Never>()
    static func IsCredentialsAvailable() -> Bool {
        return UserDefaults.standard.string(forKey: "credentials") != nil
    }
}
