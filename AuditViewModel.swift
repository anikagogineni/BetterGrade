//
//  AuditViewModel.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/20/24.
//

import Foundation
struct Audit:  Codable, Identifiable {
    var id  = UUID()
    var entity: String = ""
    var action: String = ""
    var actionType: String = ""
    var actionTime: String = ""
    //var user: String = ""
    
}

class AuditViewModel : ObservableObject{
    
    @Published var audits = [Audit]()
    
    func getAllAudit(completion:@escaping ([Audit]) -> ()){
        let token = UserDefaults.standard.string(forKey: "token")
        let urlP = ""//\(Config.baseURL)/api/audit"
        print("url: \(urlP)")
        var request = URLRequest(url: URL(string: urlP)!)
        let authString = "Bearer \(token ?? "")"
        print("token: \(authString)")
        request.httpMethod = "GET"
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        URLSession.shared.dataTask(with: request) { data, response, error in
            let json = try! JSONSerialization.jsonObject(with: data! , options: [])
            print("DataReveived: \(json)")
            if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                print("Unable to post request \(String(describing: error))")
                UserDefaults.standard.string(forKey: "token")
               // LoginViewModel().signout()
            } else if let data = data {
                do {
                    let audits = try JSONDecoder().decode([Audit].self, from: data)
                    DispatchQueue.main.async {
                        completion(audits)
                    }
                    
                } catch {
                    print("Unable to Decode Response \(error)")
                    
                }
            }
        }.resume()
    }
}

