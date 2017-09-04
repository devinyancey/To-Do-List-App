//
//  Groups.swift
//  To Do This
//
//  Created by Devin Yancey on 12/1/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit

class Group : NSObject, NSCoding{
    var name:String = ""
    var tasks:[Tasks] = []
    
    required init(name:String, tasks:[Tasks]) {
        self.name = name
        self.tasks = tasks
    }
    required init(coder decoder: NSCoder) {
        self.name = decoder.decodeObject(forKey: "name") as! String
        self.tasks = decoder.decodeObject(forKey: "tasks") as! [Tasks]
    }
    
    func encode(with coder: NSCoder) {
        coder.encode(name, forKey: "name")
        coder.encode(tasks, forKey: "tasks")
    }
    //caliborators future implementation
}
