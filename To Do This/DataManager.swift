//
//  DataManager.swift
//  To Do This
//
//  Created by Devin Yancey on 12/1/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation

protocol DataManagerDelegate{
    func didRetrieveDataFromDefaults(userFound: Bool)
    func savedDataToDefaults()
}

class DataManager{
    
    var delegate: DataManagerDelegate?
    
    public func retrieveDataFromDefaults(){
        if let data = UserDefaults.standard.data(forKey: "user"){
            let user = NSKeyedUnarchiver.unarchiveObject(with: data) as! User
            User.shared.email = user.email
            User.shared.groups = user.groups
            User.shared.numCompletedTask = user.numCompletedTask
            User.shared.numTotalTasks = user.numTotalTasks
            
            delegate?.didRetrieveDataFromDefaults(userFound: true)
        }else{
            delegate?.didRetrieveDataFromDefaults(userFound: false)
        }
    }
    
    public func saveDataToDefaults(){
        
        let encodedData = NSKeyedArchiver.archivedData(withRootObject: User.shared)
        UserDefaults.standard.set(encodedData, forKey: "user")
        
        delegate?.savedDataToDefaults()
    }
}
