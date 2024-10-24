//
//  DBHelper.swift
//  BetterGrade
//
//  Created by Anika Gogineni on 6/12/24.
//

import Foundation
import SQLite3

class DBHelper {
    var databasePointer: OpaquePointer?
    var databaseName: String = "dtStore.db"
    
    let profileTable = "CREATE TABLE IF NOT EXISTS PROFILE (UID integer PRIMARY KEY AUTOINCREMENT,ID TEXT,  Display_Name TEXT, First_Name TEXT, Last_Name TEXT, Middle_Name TEXT, Address1 TEXT, Address2 TEXT, City TEXT, State TEXT, Zipcode INT, Country TEXT, Email TEXT, Phone_Number TEXT, Phone_Country_Code TEXT); "
    
    let identityTable = "CREATE TABLE IF NOT EXISTS USER_IDENTITY (UID integer PRIMARY KEY AUTOINCREMENT, ID TEXT,Identification_Type TEXT, Identification_Number TEXT);"
    
    let UserEducationCredentialsTable = "CREATE TABLE IF NOT EXISTS USER_EDU_CREDENTIALS (UID integer PRIMARY KEY AUTOINCREMENT, SCHOOL_ID TEXT,SCHOOL_USER TEXT, SCHOOL_PWD TEXT, CANVAS_TOKEN TEXT);"
    
    let RegistrationTable = "CREATE TABLE IF NOT EXISTS REGISTRATION (UID integer PRIMARY KEY AUTOINCREMENT, PHONE_NUMBER TEXT, REGISTERED_DATE_TIME TEXT, DEVICE_INFO TEXT);"
    
    let CourseScheduleTable = "CREATE TABLE IF NOT EXISTS COURSE_SCHEDULE (UID integer PRIMARY KEY AUTOINCREMENT, BUILDING TEXT, COURSE_NAME TEXT, COURSE_CODE TEXT, DAYS TEXT, MARKING_PERIODS TEXT, PERIODS TEXT, ROOM TEXT, STATUS TEXT, TEACHER TEXT);"
    
    let CourseListTable = "CREATE TABLE IF NOT EXISTS COURSE_LIST (UID integer PRIMARY KEY AUTOINCREMENT, COURSE_ID integer, COURSE_NAME TEXT, ACCOUNT_ID TEXT, CREATED_AT TEXT, COURSE_CODE TEXT);"
    
    let CourseGradeTable = "CREATE TABLE IF NOT EXISTS COURSE_GRADES (UID integer PRIMARY KEY AUTOINCREMENT, NAME TEXT, GRADE TEXT, LAST_UPDATED TEXT, COURSE_ASSIGNMENT_ID TEXT);"
    
    
    let CourseAssignmentsTable = "CREATE TABLE IF NOT EXISTS COURSE_ASSIGNMENTS (UID integer PRIMARY KEY AUTOINCREMENT, NAME TEXT, CATEGORY TEXT, DATE_ASSIGNED TEXT, DATE_DUE TEXT, SCORE TEXT, TOTAL_POINTS TEXT, COURSE_ASSIGNMENT_ID TEXT);"
    
    init(){
        if (databasePointer == nil){
            databasePointer = createDB(databaseName: databaseName)
            createTable(tableName: profileTable)
            createTable(tableName: identityTable)
            createTable(tableName: UserEducationCredentialsTable)
            createTable(tableName: RegistrationTable)
            createTable(tableName: CourseScheduleTable)
            createTable(tableName: CourseGradeTable)
            createTable(tableName: CourseAssignmentsTable)
            createTable(tableName: CourseListTable)
        } else{
            print ("DB is open and table are created")
        }
        
    }
    
    func createDB(databaseName: String) -> OpaquePointer?{
        //print("db create triggered")
        let filePath = try! FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathComponent(databaseName).path
        
        print(filePath)
        
        if FileManager.default.fileExists(atPath: filePath){
            print("Database Exists(already)")
        }
        else{
            guard let bundleDatabasePath = Bundle.main.resourceURL?.appendingPathComponent(databaseName).path else{
                print("Unwrapping Error: Bundle Database Path doesn't exist")
                return nil
            }
            do{
                //try FileManager.default.copyItem(atPath: bundleDatabasePath, toPath: filePath)
                let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(databaseName)
                print("Database created ")
            }catch {
                print("Error: \(error.localizedDescription)")
                return nil
            }
        }
        
        if sqlite3_open(filePath, &databasePointer) == SQLITE_OK {
            print("Successfully open database")
            //print("Database path: \(filePath)")
        } else {
            print("Could not open database")
        }
            return databasePointer
//        let filePath = try! FileManager.default.url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: false).appendingPathExtension(path)
//
//        var db: OpaquePointer?
//        let result = sqlite3_open(filePath.path,&db)
//
//        defer { sqlite3_close(db) }
//
//
//        if  result != SQLITE_OK{
//            print("Error in creating db")
//            return nil
//        }else{
//            print("DB created")
//            return db
//        }
    }
    
    func createTable(tableName: String) {
        //print("table create triggered")
        //print(tableName)
        let query = tableName
        
        
        var statement : OpaquePointer?
        
        if sqlite3_prepare_v2(databasePointer, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("create table statement executed")
            }else{
                print("create table statement failed")
            }
        }else{
            print("create preparation statemet failed")
        }
        sqlite3_finalize(statement)
    }
    
    func dropTable(tableName: String) {
        //print("table create triggered")
        print(tableName)
        let query = tableName
        
        
        var statement : OpaquePointer?
        
        if sqlite3_prepare_v2(databasePointer, query, -1, &statement, nil) == SQLITE_OK {
            if sqlite3_step(statement) == SQLITE_DONE {
                print("drop table statement executed")
            }else{
                print("drop table statement failed")
            }
        }else{
            print("drop preparation statemet failed")
        }
        sqlite3_finalize(statement)
    }
    
    func insertProfile(id: String, dname: String, fname: String, lname: String, mname: String, address1: String, address2: String, city: String, state: String, zipcode: String, country: String, email: String, phone: String, phoneCountry: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString_tmp = "INSERT INTO PROFILE ( ID, Display_Name, First_Name, Last_Name, Middle_Name, Address1, Address2, City, State, Zipcode, Country, Email, Phone_Number, Phone_Country_Code  ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+id+"','"+dname+"','"+fname+"','"+lname+"','"+mname+"','"+address1+"','"+address2+"','"+city+"','"+state+"','"+zipcode+"','"+country+"','"+email+"','"+phone+"','"+phoneCountry+"');"
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func insertUsrEduCred(school_id: String, school_usr: String, school_pwd: String, ctoken: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString_tmp = "INSERT INTO USER_EDU_CREDENTIALS ( SCHOOL_ID ,SCHOOL_USER , SCHOOL_PWD , CANVAS_TOKEN ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+school_id+"','"+school_usr+"','"+school_pwd+"','"+ctoken+"');"
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted USER_EDU_CREDENTIALS row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func insertCourseSchedule(building: String, course_name: String, course_code: String, days: String, marking_periods: String, periods: String, room: String, status: String, teacher: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString_tmp = "INSERT INTO COURSE_SCHEDULE ( BUILDING , COURSE_NAME , COURSE_CODE , DAYS , MARKING_PERIODS , PERIODS , ROOM , STATUS , TEACHER   ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+building+"','"+course_name+"','"+course_code+"','"+days+"','"+marking_periods+"','"+periods+"','"+room+"','"+status+"','"+teacher+"');"
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted COURSE_SCHEDULE row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    //Insert COURSE_GRADES
    func insertCourseGrades(name: String, grade: String, last_updated: String, course_assignment_id: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString_tmp = "INSERT INTO COURSE_GRADES ( NAME , GRADE , LAST_UPDATED , COURSE_ASSIGNMENT_ID  ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+name+"','"+grade+"','"+last_updated+"','"+course_assignment_id+"');"
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted COURSE_GRADES row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    //Insert COURSE_ASSIGNMENTS
    func insertCourseAssignments(name: String, category: String, date_assigned: String, date_due: String, score: String, total_points: String, course_assignment_id: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString_tmp = "INSERT INTO COURSE_ASSIGNMENTS ( NAME , CATEGORY , DATE_ASSIGNED , DATE_DUE , SCORE , TOTAL_POINTS , COURSE_ASSIGNMENT_ID ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+name+"','"+category+"','"+date_assigned+"','"+date_due+"','"+score+"','"+total_points+"','"+course_assignment_id+"');"
          
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted COURSE_ASSIGNMENTS row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    
    func insertRegistration(phoneNumber: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        let date = Date()
        let df = DateFormatter()
        df.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let dateString = df.string(from: date)
          
        let insertStatementString_tmp = "INSERT INTO REGISTRATION ( PHONE_NUMBER ,REGISTERED_DATE_TIME , DEVICE_INFO  ) VALUES" ;
        let insertStatementString = insertStatementString_tmp+"('"+phoneNumber+"','"+dateString+"','IOS');"
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted REGISTRATION row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func updateProfile(uid: Int64, id:String, dname: String, fname: String, lname: String, mname: String, address1: String, address2: String, city: String, state: String, zipcode: String, country: String, email: String, phone: String, phoneCountry: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        
        let insertStatementString_tmp = "UPDATE PROFILE set Display_Name ='"+dname+"', First_Name = '"+fname+"', Last_Name = '"+lname+"', Middle_Name = '"+mname+"', Address1 = '"+address1+"', Address2 = '"+address2+"', City = '"+city+"', State = '"+state+"', "
        
        let insertStatementString =
        insertStatementString_tmp+"Zipcode = '"+zipcode+"', Country = '"+country+"', Email = '"+email+"', Phone_Number = '"+phone+"', Phone_Country_Code ='"+phoneCountry+"' where ID = \(uid) ;"
        
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully updated row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not update row.")
            }
        } else {
            print("\nUPDATE statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    
//    func queryProfile() -> [Profile] {
//        print("triggered")
//        var queryStatement: OpaquePointer?
//        let queryStatementString = "SELECT * FROM Profile;"
//
//        var psn : [Profile] = []
//
//        // 1
//        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
//            SQLITE_OK {
//            //print("query prep is ok \(queryStatement)")
//            // 2
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                //print("Result have some rows")
//                let uid = sqlite3_column_int64(queryStatement, 0)
//                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let displayname = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
//                let lastname = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
//                let firstname = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
//                let middlename = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
//                let address1 = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
//                let address2 = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
//                let city = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
//                let state = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
//                let country = String(describing: String(cString: sqlite3_column_text(queryStatement, 10)))
//                let zipcode = String(describing: String(cString: sqlite3_column_text(queryStatement, 11)))
//                let email = String(describing: String(cString: sqlite3_column_text(queryStatement, 12)))
//                let phone = String(describing: String(cString: sqlite3_column_text(queryStatement, 13)))
//                let phoneCountry = String(describing: String(cString: sqlite3_column_text(queryStatement, 14)))
//                //print("\(id) | \(displayname) | \(lastname)")
//                psn.append( Profile(id:UUID(uuidString: id) ?? UUID(), displayName: displayname, lastName:lastname, firstName:firstname, middleName:middlename, address1:address1, address2:address2, city:city, state:state, country:country, zipcode:zipcode, email:email, phoneNumber:phone, phoneCountryCode:phoneCountry))
//            }
//
//        } else {
//            // 6
//            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
//            print("\nQuery is not prepared \(errorMessage)")
//        }
//        // 7
//        sqlite3_finalize(queryStatement)
//        //print(psn)
//        return psn
//    }
    
    func queryUserEduCred() -> UserEducationCred {
        print("triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM USER_EDU_CREDENTIALS;"
        
        var psn : UserEducationCred?
        
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                let school_id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let school_usr = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let school_pwd = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let ctoken = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                
                //print("\(id) | \(displayname) | \(lastname)")
                psn = UserEducationCred(id:uid, schoolId:school_id, schoolUsername: school_usr, schoolPassword: school_pwd, cToken: ctoken)
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(psn)
        return psn ?? UserEducationCred()
    }
    
    func queryCourseList() -> [CourseList] {
        print("triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM COURSE_LIST;"
        
        
        var psn = [CourseList]()
        
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                let course_id =  sqlite3_column_int64(queryStatement, 1)
                let course_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let account_id = sqlite3_column_int64(queryStatement, 3)
                let create_at = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let course_code = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                
                //print("\(id) | \(displayname) | \(lastname)")
                var temp = CourseList(id:course_id, name: course_name, created_at: create_at,  account_id: account_id, course_code: course_code)
                psn.append(temp)
                
                
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(psn)
        return psn ?? [CourseList]()
    }
    
    func queryRegistration() -> String {
        print("triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM REGISTRATION;"
        var phoneNumber = ""
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                phoneNumber = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
               
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(psn)
        return phoneNumber
    }
    
    func queryCourseSchedule(marking_periods: String) -> [Schedule] {
        print("Schedule Query triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM COURSE_SCHEDULE where MARKING_PERIODS='"+marking_periods+"';"
        var schedule = [Schedule]()
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            var i: Int = 0
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                let building = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let course_name = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let course_code = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let days = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let marking_periods = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let periods = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                let room = String(describing: String(cString: sqlite3_column_text(queryStatement, 7)))
                let status = String(describing: String(cString: sqlite3_column_text(queryStatement, 8)))
                let teacher = String(describing: String(cString: sqlite3_column_text(queryStatement, 9)))
                
                //print("\(uid) | \(building) | \(course_name)")
                var temp = Schedule(building: building, courseCode: course_name, courseName: course_code, days: days, markingPeriods: marking_periods, periods: periods, room: room, status: status, teacher: teacher)
                schedule.append(temp)
                i = i + 1
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(schedule)
        return schedule ??  [Schedule]()
    }
    
    func queryCourseGrades() -> [CourseGrades] {
        print("Schedule Query triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM COURSE_GRADES ;"
        var courseGrades = [CourseGrades]()
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            var i: Int = 0
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let grade = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let lastUpdated = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let courseAssignmentId = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                
                
                //print("\(uid) | \(building) | \(course_name)")
                var temp = CourseGrades(name: name, grade: grade, lastUpdated: lastUpdated, courseAssignmentId: courseAssignmentId)
                courseGrades.append(temp)
                i = i + 1
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(schedule)
        return courseGrades ??  [CourseGrades]()
    }
    
    func queryCourseAssignments(assignment_id: String) -> [Assignments] {
        print("Schedule Query triggered")
        var queryStatement: OpaquePointer?
        let queryStatementString = "SELECT * FROM COURSE_ASSIGNMENTS where COURSE_ASSIGNMENT_ID ='"+assignment_id+"' ;"
        var assignments = [Assignments]()
        // 1
        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
            SQLITE_OK {
            //print("query prep is ok \(queryStatement)")
            // 2
            var i: Int = 0
            while sqlite3_step(queryStatement) == SQLITE_ROW {
                //print("Result have some rows")
                let uid = sqlite3_column_int64(queryStatement, 0)
                let name = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
                let category = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
                let dateAssigned = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
                let dateDue = String(describing: String(cString: sqlite3_column_text(queryStatement, 4)))
                let score = String(describing: String(cString: sqlite3_column_text(queryStatement, 5)))
                let totalPoints = String(describing: String(cString: sqlite3_column_text(queryStatement, 6)))
                
                
                //print("\(uid) | \(building) | \(course_name)")
                var temp = Assignments(name: name, category: category, dateAssigned: dateAssigned, dateDue: dateDue, score:  score, totalPoints: totalPoints)
                assignments.append(temp)
                i = i + 1
            }
            
        } else {
            // 6
            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
            print("\nQuery is not prepared \(errorMessage)")
        }
        // 7
        sqlite3_finalize(queryStatement)
        //print(schedule)
        return assignments ??  [Assignments]()
    }
    
    func insertIdentity(type: String, number: String){
        print("insert identity triggered")
        var insertStatement: OpaquePointer?
        let insertStatementString = "INSERT INTO USER_IDENTITY ( Identification_Type, Identification_Number ) VALUES ('"+type+"','"+number+"');"
       
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully inserted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not insert row.")
            }
        } else {
            print("\nINSERT statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
        
    }
    
    
    
//    func queryIdentity() -> [Identification] {
//        print("read identity triggered")
//        var queryStatement: OpaquePointer?
//        let queryStatementString = "SELECT * FROM USER_IDENTITY;"
//
//        var idn : [Identification] = []
//
//        // 1
//        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
//            SQLITE_OK {
//            //print("query prep is ok \(queryStatement)")
//            // 2
//            while sqlite3_step(queryStatement) == SQLITE_ROW {
//                //print("Result have some rows")
//                let uid = sqlite3_column_int64(queryStatement, 0)
//                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
//                let number = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
//                //let expiryDate = NSData(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
//
//                //print("\(id) | \(displayname) | \(lastname)")
//                idn.append( Identification(id:UUID(uuidString: id) ?? UUID() , identificationNumber: number))
//            }
//
//        } else {
//            // 6
//            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
//            print("\nQuery is not prepared \(errorMessage)")
//        }
//        // 7
//        sqlite3_finalize(queryStatement)
//        //print(psn)
//        return idn
//    }
    
//    func queryIdentity(id: Int64) -> Identification {
//        print("read identity triggered")
//        var queryStatement: OpaquePointer?
//        let queryStatementString = "SELECT * FROM USER_IDENTITY;"
//        
//        var idn : Identification = Identification()
//        
//        // 1
//        if sqlite3_prepare_v2(databasePointer, queryStatementString, -1, &queryStatement, nil) ==
//            SQLITE_OK {
//            //print("query prep is ok \(queryStatement)")
//            // 2
//            if sqlite3_step(queryStatement) == SQLITE_ROW {
//                //print("Result have some rows")
//                let uid = sqlite3_column_int64(queryStatement, 0)
//                let id = String(describing: String(cString: sqlite3_column_text(queryStatement, 1)))
//                let type = String(describing: String(cString: sqlite3_column_text(queryStatement, 2)))
//                let number = String(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
//                //let expiryDate = NSData(describing: String(cString: sqlite3_column_text(queryStatement, 3)))
//               
//                //print("\(id) | \(displayname) | \(lastname)")
//                idn.id = UUID(uuidString: id) ?? UUID()
//                idn.type = type
//                idn.identificationNumber = number
//            }
//            
//        } else {
//            // 6
//            let errorMessage = String(cString: sqlite3_errmsg(databasePointer))
//            print("\nQuery is not prepared \(errorMessage)")
//        }
//        // 7
//        sqlite3_finalize(queryStatement)
//        //print(psn)
//        return idn
//    }
    
    func updateUserIdentity(id: Int64, type: String, number: String) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        
        let insertStatementString = "UPDATE USER_IDENTITY set Identification_Type ='"+type+"', Identification_Number = '"+number+"' where ID = \(id) ;"
        
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully updated row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not update row.")
            }
        } else {
            print("\nUPDATE statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func deleteUserIdentity(id: Int64) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        
        let insertStatementString = "DELETE from USER_IDENTITY where ID = \(id) ;"
        
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully updated row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not update row.")
            }
        } else {
            print("\nUPDATE statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func deleteUserEduCred(id: Int64) {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        
        let insertStatementString = "DELETE from USER_EDU_CREDENTIALS  ;"
        //let insertStatementString = "DELETE from USER_EDU_CREDENTIALS where UID = \(id) ;"
        
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not delete row.")
            }
        } else {
            print("\nDelete statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }
    
    func deRegister() {
        //print("insert triggered")
        //var insertStatement: OpaquePointer?
        
        //let insertStatementString = "DELETE from sqlite_master where type is 'table' ;"
        let profileTable = "DROP TABLE PROFILE ; "
        
        let identityTable = "DROP TABLE USER_IDENTITY ;"
        
        let UserEducationCredentialsTable = "DROP TABLE USER_EDU_CREDENTIALS ;"
        
        let RegistrationTable = "DROP TABLE REGISTRATION ;"
        
        let CourseScheduleTable = "DROP TABLE COURSE_SCHEDULE ;"
        
        let CourseGradeTable = "DROP TABLE COURSE_GRADES ;"
                
        let CourseAssignmentsTable = "DROP TABLE COURSE_ASSIGNMENTS ;"
        let CourseListTable = "DROP TABLE COURSE_LIST ;"
        
        dropTable(tableName: profileTable)
        dropTable(tableName: identityTable)
        dropTable(tableName: UserEducationCredentialsTable)
        dropTable(tableName: RegistrationTable)
        dropTable(tableName: CourseScheduleTable)
        dropTable(tableName: CourseGradeTable)
        dropTable(tableName: CourseAssignmentsTable)
        dropTable(tableName: CourseListTable)
        
    }
    func deleteSchedule() {
        //print("insert triggered")
        var insertStatement: OpaquePointer?
        
        let insertStatementString = "DELETE from COURSE_SCHEDULE  ;"
        //let insertStatementString = "DELETE from USER_EDU_CREDENTIALS where UID = \(id) ;"
        
        
        print(insertStatementString)
        // 1
        if sqlite3_prepare_v2(databasePointer, insertStatementString, -1, &insertStatement, nil) ==
            SQLITE_OK {
            
            if sqlite3_step(insertStatement) == SQLITE_DONE {
                print("\nSuccessfully deleted row.")
            } else {
                let errmsg = String(cString: sqlite3_errmsg(databasePointer)!)
                print("failure binding name: \(errmsg)")
                print("\nCould not delete row.")
            }
        } else {
            print("\nDelete statement is not prepared.")
        }
        // 5
        sqlite3_finalize(insertStatement)
    }

}
