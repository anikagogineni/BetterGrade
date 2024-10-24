//
//  ToDosByNotificationsTableViewController.swift
//  dTwin
//
//  Created by Srujan Gogineni on 1/7/24.
//

import Foundation

class Notify: NSObject {
    var id: String = ""
    var dateString: String = ""
    var title: String = ""
    var date: Date!
    
    init(date: Date) {
        self.date = date
    }
   
}

class ToDosByNotificationsTableViewController: UITableViewController {
   
    var notifications: [Notify] = []
    var queryNotes: [Note] = []
    var triggerDateString: String = ""
    var triggerDate: Date!
    let dateFormatter = DateFormatter()
    let queryContext = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    let queryFetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"Note")

    override func viewDidLoad() {
        super.viewDidLoad()

        title = "Active Notifications"
        
    }  // end func
    
    override func viewWillAppear(_ animated: Bool) {
        
        notifications.removeAll(keepingCapacity: true)
        
        UNUserNotificationCenter.current().getPendingNotificationRequests(completionHandler: { requests -> () in
            
            for request in requests {
                
                if let calendarNotificationTrigger = request.trigger as? UNCalendarNotificationTrigger,
                    let nextTriggerDate = calendarNotificationTrigger.nextTriggerDate()  {
                    
                    let dayOfWeekString = self.configureDayOfWeekString(nextTriggerDate)
                    self.dateFormatter.dateStyle = .medium
                    self.dateFormatter.timeStyle = .short
                    self.triggerDateString = dayOfWeekString + " " + self.dateFormatter.string(from: nextTriggerDate)
                    self.triggerDate = nextTriggerDate
                    
                    let notification = Notify(date: self.triggerDate)
                    notification.id = request.identifier
                    notification.dateString = self.triggerDateString
                    notification.title = request.content.title
                    notification.date = self.triggerDate
                    self.notifications.append(notification)
                    
                    } // end if let

            } // end for
            
            self.notifications.sort { $0.date < $1.date }
            // Add below code line so viewWillAppear will auto reload table view data
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }) // end getPending
        
    } // end viewWillAppear


    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {

        let headerBackgroundColor = UIColor.red

        let view = UIView()
        view.backgroundColor = headerBackgroundColor
        let imageView = UIImageView(image: #imageLiteral(resourceName: "QueriesNotify"))   // IconNotify
        imageView.frame = CGRect(x: 5, y: 5, width: 40, height: 40)
        view.addSubview(imageView)
        
        let label = UILabel()
        label.text = "Currently Active"
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.frame = CGRect(x: 65, y: 5, width: 250, height: 40)
        view.addSubview(label)
        
        return view
        
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notifications.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NotifyCell", for: indexPath)
        
        let notification = notifications[indexPath.row]
        
        cell.textLabel?.text = notification.title
        cell.detailTextLabel?.text = notification.dateString
        
        return cell
    }
    
   func configureDayOfWeekString (_ date: Date) -> String {
            
           //..
            
            return dayOfWeek
            
        } // end func
        
        
} // end class
