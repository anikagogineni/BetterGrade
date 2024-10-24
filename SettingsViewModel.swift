//
//  SettingsViewModel.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/12/24.
//

import Foundation

struct Barcode:  Codable, Identifiable {
    var id  = UUID()
    var data: String = ""
    //var user: String = ""
    
}
class SettingsViewModel : ObservableObject{
    
    @Published var audits = [Audit]()
   
    
    func getBarcode(completion:@escaping (Barcode) -> ()){
        var iddata: String = ""
        let token = UserDefaults.standard.string(forKey: "token")
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.value(forKey: "id") as? Data {
            let taskData = try? decoder.decode(String.self, from: data)
            iddata = taskData ?? ""
        }
        print("id retrive: \(iddata)")
        
        let urlP = ""//"\(Config.baseURL)/api/profiles/barcodedata/\(iddata)"
        print("url: \(urlP)")
        var request = URLRequest(url: URL(string: urlP)!)
        let authString = "Bearer \(token ?? "")"
        print("token: \(authString)")
        request.httpMethod = "GET"
        request.addValue(authString, forHTTPHeaderField: "Authorization")
        request.addValue("application/json", forHTTPHeaderField: "Content-type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            print("DataReveived: \(String(describing: data))")
            if error != nil || (response as! HTTPURLResponse).statusCode != 200 {
                print("Unable to post request \(String(describing: error))")
                //LoginViewModel().signout()
            } else if let data = data {
                do {
                    
                    let barcode = try JSONDecoder().decode(Barcode.self, from: data)
                    print("Response \(barcode)")
                    print("barcode: \(barcode.data)")
                    
                    
                    DispatchQueue.main.sync {
                        completion(barcode)
                    }
                    
                } catch {
                    print("Unable to Decode Response \(error)")
                    
                }
            }
        }.resume()
    }
}
