//
//  User.swift
//  To Do This
//
//  Created by Devin Yancey on 11/26/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

/*
 required init(name: String, age: Int) {
 self.name = name
 self.age = age
 }
 required init(coder decoder: NSCoder) {
 self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
 self.age = decoder.decodeInteger(forKey: "age")
 }
 
 func encode(with coder: NSCoder) {
 coder.encode(name, forKey: "name")
 coder.encode(age, forKey: "age")
 }
 */

import UIKit
import KCFloatingActionButton
protocol UserDelegate{
    func didRetrieveDataFromDefaults(userFound:Bool)
    func savedDataToDefaults()
}

class User : NSObject, NSCoding{
    static let shared = User()
    var groups:[Group] = []
    var numTotalTasks:Int = 0
    var numCompletedTask:Int = 0
    var email:String = ""
    var colorPallete:[String:UIColor]!
    var currentGroupEditable:Group!
    var delegate: UserDelegate?
    var userToSave:User!
    var currentViewController:UIViewController!
    var allTask:[Tasks] = []
    
    override init() {
        
    }
    
    required init(group:[Group], currentGroup:Group, colorPal:[String:UIColor], numTotalTask:Int, numCompletedTask:Int, email:String) {
        self.groups = group
        self.currentGroupEditable = currentGroup
        self.colorPallete = colorPal
        self.numTotalTasks = numTotalTask
        self.numCompletedTask = numCompletedTask
        self.email = email
    }
    required init(coder decoder: NSCoder) {
        self.groups = decoder.decodeObject(forKey: "groups") as! [Group]
        self.currentGroupEditable = decoder.decodeObject(forKey: "editableGroup") as! Group
        self.colorPallete = (decoder.decodeObject(forKey: "colorPallete") as? [String:UIColor])!
        self.numTotalTasks = Int(decoder.decodeCInt(forKey: "numOfTotalTasks"))
        self.numCompletedTask = Int(decoder.decodeCInt(forKey: "numOfCompletedTasks")) 
        self.email = decoder.decodeObject(forKey: "email") as! String
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(groups, forKey: "groups")
        coder.encode(currentGroupEditable, forKey: "editableGroup")
        coder.encode(colorPallete, forKey: "colorPallete")
        coder.encode(numTotalTasks, forKey: "numOfTotalTasks")
        coder.encode(numCompletedTask, forKey: "numOfCompletedTasks")
        coder.encode(email, forKey: "email")
    }
    
    public func retrieveDataFromDefaults(){
        
        if let data = UserDefaults.standard.data(forKey: "user"){
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            User.shared.email = user.email
            User.shared.groups = user.groups
            User.shared.numCompletedTask = user.numCompletedTask
            User.shared.numTotalTasks = user.numTotalTasks
            User.shared.colorPallete = user.colorPallete
            User.shared.currentGroupEditable = user.currentGroupEditable
            delegate?.didRetrieveDataFromDefaults(userFound: true)
        }else{
            
            delegate?.didRetrieveDataFromDefaults(userFound: false)
        }

    }
    
    public func saveDataToDefaults(){
        
        let user = User.shared
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: user)
        UserDefaults.standard.set(encodedData, forKey: "user")
         
        delegate?.savedDataToDefaults()
    }
    
    public func addGroup(withGroup:Group){
        User.shared.groups.append(withGroup)
    }
    
    public func addTask(withGroup:Group, task:Tasks){
        task.parentGroup = withGroup
        withGroup.tasks.insert(task, at: 0)
        self.numTotalTasks += 1
    }

    
    /*
     let name: String
     let age: Int
     required init(name: String, age: Int) {
     self.name = name
     self.age = age
     }
     required init(coder decoder: NSCoder) {
     self.name = decoder.decodeObject(forKey: "name") as? String ?? ""
     self.age = decoder.decodeInteger(forKey: "age")
     }
     
     func encode(with coder: NSCoder) {
     coder.encode(name, forKey: "name")
     coder.encode(age, forKey: "age")
     }
 */
}
