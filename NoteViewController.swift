//
//  NoteViewController.swift
//  dTwin
//
//  Created by Srujan Gogineni on 1/7/24.
//

import Foundation
import UserNotifications

class NoteViewController: UITableViewController{
    
    //...
    var note: Note!
    var newObject:Note!
    var editObject:Note!
    var updateMode: String! = ""    // "Add" or "Edit"
    var isReminderOn = false
    var reminderDate: Date?
    //
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkUserNotification()
        //..
    } // end viewDidLoad
    
}


func checkUserNotification() {
        
        print("Note VC", #function)

        if #available(iOS 10.0, *) {
            UNUserNotificationCenter.current().getNotificationSettings(){ (setttings) in
                
                switch setttings.authorizationStatus {
                case .authorized:
                    print(#function, "User Notifications Authorised")
                case .denied:
                    let alertVC = PMAlertController(title: "User Notifications Error!", description: "8ToDo is Not Authorized to Send User Notifications!", image: UIImage(named: "CancelNotify"), style: .alert)
                    
                    // Right hand option (default color in PMAlertAction.swift)
                    alertVC.addAction(PMAlertAction(title: "Settings", style: .default, action: { () in
                        DispatchQueue.main.async {
                            if let settingsURL = URL(string: UIApplication.openSettingsURLString) {
                                UIApplication.shared.open(settingsURL, options: convertToUIApplicationOpenExternalURLOptionsKeyDictionary([:]), completionHandler: nil)
                            }
                        } // end dispatchQueue
                    })) // end addAction
                    // Left hand option (default color grey)
                    alertVC.addAction(PMAlertAction(title: "Cancel", style: .cancel))
                    self.present(alertVC, animated: true, completion: nil)
                    return
                case .notDetermined:
                    print(#function, " NOT_DETERMEND Something FATAL went wrong here")
                case .provisional:
                    print(#function, " PROVISIONAL Something FATAL went wrong here")
                case .ephemeral:
                    print(#function, " EPHEMERAL Something FATAL went wrong here")
                @unknown default:
                  print(#function, " UNKNOWN Something FATAL went wrong here")
                }
            }
        }

    } // end func checkUserNotification()

func scheduleUserNotification() {
        
        print("Note VC ", #function)

        var toDoID: String!
        if (updateMode! == "Add" {
            toDoID = noteID
        } else {
            toDoID = editObject.id
        }
        
        // Schedule a new notification if reminderDate is set, with should remind true and reminderDate > current date
        if reminderDate != nil && isReminderOn && reminderDate! > Date() {
            // 1
            let content = UNMutableNotificationContent()
            content.title = titleTextField.text!
            
            let formatter = DateFormatter()     // to convert Date value to text
            formatter.dateStyle = .full     // or use .medium with dayOfWeek logic
            formatter.timeStyle = .short
            content.body = formatter.string(from: dueDate!)
            // content.body = String(describing: dueDate)
            if isReminderSoundOn {
                content.sound = UNNotificationSound.default
            }
            // 2
            let calendar = Calendar(identifier: .gregorian)
            // let components = calendar.dateComponents([.month, .day, .hour, .minute], from: dueDate)
            // reminderDate! force unwrap is safe as there is no notification if reminderDate is nil
            let components = calendar.dateComponents([.month, .day, .hour, .minute], from: reminderDate!)
            // 3
            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: false)
            // 4
            let request = UNNotificationRequest(identifier: "\(toDoID!)", content: content, trigger: trigger)
            // 5
            let center = UNUserNotificationCenter.current()
            center.add(request)
            
            // print trigger date
            var triggerDateString: String = ""
            if let calendarNotificationTrigger = request.trigger as? UNCalendarNotificationTrigger,
                let nextTriggerDate = calendarNotificationTrigger.nextTriggerDate()  {
                let dayOfWeekString = self.configureDayOfWeekString(nextTriggerDate)
                triggerDateString = dayOfWeekString + " " + formatter.string(from: nextTriggerDate)
            } // end print trigger date
            
            print("Note VC",#function, content.title, triggerDateString)

        } // end if
        
        
    } // end func scheduleUserNotification()
            
            // Helper function inserted by Swift migrator.
            fileprivate func convertToUIApplicationOpenExternalURLOptionsKeyDictionary(_ input: [String: Any]) -> [UIApplication.OpenExternalURLOptionsKey: Any] {
                return Dictionary(uniqueKeysWithValues: input.map { key, value in (UIApplication.OpenExternalURLOptionsKey(rawValue: key), value)})
            }
            
