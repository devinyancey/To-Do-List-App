//
//  Tasks.swift
//  To Do This
//
//  Created by Devin Yancey on 12/1/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit

class Tasks :NSObject, NSCoding{
    var name: String = ""
    enum priority {
        case urgent
        case high
        case low
    }
    //comment location
    //var locationManager = CLLocationManager
    var dueDate:Date?
    var createdDate:Date?
    var note: String = ""
    var subTasks:[Tasks]?
    var parentGroup:Group!
    var completed:Bool?

    required init(name:String, group:Group) {
        self.name = name
       self.parentGroup = group
    }
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.parentGroup = decoder.decodeObject(forKey: "parentGroup") as! Group
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(parentGroup, forKey: "parentGroup")
    }
}
