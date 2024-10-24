//
//  AIPlannerModel.swift
//  BetterGrade
//
//  Created by Srujan Gogineni on 10/7/24.
//

import Foundation
import UIKit
import GoogleGenerativeAI


struct AIStudyModelPlanRoot: Codable {
    let aiStudyModelPlan: AIStudyModelPlan

    enum CodingKeys: String, CodingKey {
        case aiStudyModelPlan = "AIStudyModelPlan"
    }
}

// MARK: - AIStudyModelPlan
struct AIStudyModelPlan: Codable {
    let title, description: String
    let resourceLinks: [ResourceLink]
}

// MARK: - ResourceLink
struct ResourceLink: Codable {
    let topic: String
    let links: [String]
}


struct StudyPlans: Codable, Hashable {
    var subject: String?
    var title: String?
    var description: String?
    let resourceLinks: String?
}

final class AIPlannerModel: ObservableObject {

    let apiKey = "AIzaSyAfUiTk770E08nFKRNLXDXQflUC5M4dKmY"
    @Published var loading = false
   
    
    func createUserPlanner(course: String, message: String) async -> String  {
        self.loading = true
        var dictonary:NSDictionary?
        let model = GenerativeModel(name: "gemini-pro", apiKey: apiKey)
        print("Request :\(message)")
        print("Subject :\(course)")
               do {
                   let response = try await model.generateContent(message)
                   if let data = response.text {
                       let d = data.replacingOccurrences(of: "```", with: "")
                       let d1 = d.replacingOccurrences(of: "json", with: "")
                       var jsonData = Data(d1.utf8)
                       
                       let jsonDecoder = JSONDecoder()
                       jsonDecoder.keyDecodingStrategy = .useDefaultKeys
                       print("Response: \(d1)")
                       if let rootElement = jsonData.first{
                           var str: String = rootElement.description
                           if (str == "AIStudyModelPlan"){
                               let aIPlannerModel = try jsonDecoder.decode(AIStudyModelPlanRoot.self , from: jsonData)
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].title)")
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].description)")
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].resourceLinks)")
                               insertStudyPlan(subject: course, studyPlan:  aIPlannerModel.aiStudyModelPlan)
                           }else{
                               let aIPlannerModelsub = try jsonDecoder.decode( AIStudyModelPlan.self, from: jsonData)
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].title)")
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].description)")
                               //                       print("jSonObject \(aIPlannerModel.aiStudyModelPlan[0].resourceLinks)")
                               insertStudyPlan(subject: course, studyPlan:  aIPlannerModelsub)
                           }
                       }
                       
                       self.loading = false
                       return d1
                       
                   } else {
                       return "Empty"
                   }
               } catch {
                   print("Error generating content: \(error)")
                   
                   return "Error"
                   self.loading = false
               }
        
    }
    
    func getStudyPlans(subject: String)-> [StudyPlans] {
        print("Query schedule....")
        let grd: [StudyPlans] = DBManager.queryStudyPlans(subject: subject)
        self.loading = false
        return grd
    }
    
    func insertStudyPlan(subject: String, studyPlan: AIStudyModelPlan){
        //DBManager.deleteCourseList()
        var i = 0, n = studyPlan.resourceLinks.count
        //print("Data Size: \(n)")
        while (i < n){
            DBManager.insertStudyPlan(subject: subject, title: studyPlan.resourceLinks[i].topic ?? "", description: studyPlan.description ?? "", links: studyPlan.resourceLinks[i].links.joined(separator: ",") ?? "")
            i = i + 1
            print("Inserting record")
        }
        
        
    }
    
    func deleteStudyPlan(subject: String){
        DBManager.deleteAIStudyPlan(subject: subject)
    }
}
