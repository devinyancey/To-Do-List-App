//
//  ListTableView.swift
//  To Do This
//
//  Created by Devin Yancey on 11/25/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import KCFloatingActionButton

class ListTableView: UITableView {
    
    var view:UIView!
    var addButton:KCFloatingActionButton?
    var group:Group?
    var todaysTasks:[Tasks]!
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    public func dataSourceReady() {
        todaysTasks = []
        for groups in User.shared.groups{
            for task in groups.tasks{
                self.todaysTasks.append(task)
            }
        }
        
        dataSource = self
        delegate = self
        //consDataSource = User.shared.mapsd
        self.register(UINib(nibName: "ListTableViewCell", bundle: nil), forCellReuseIdentifier: "listCell")
        self.separatorStyle = .none
        self.bounces = true
        
    }
    public func taskCompleted(task:Tasks){
        var i = 0
        for theTask in task.parentGroup.tasks{
            if task == theTask{
                //task.parentGroup.tasks.remove(at: i)
                theTask.completed = true
            }
            i += 1
        }
        User.shared.saveDataToDefaults()
        dataSourceReady()
        reloadData()
    }
    
    public func removeTask(task: Tasks){
        var i = 0
        for theTask in task.parentGroup.tasks{
            if task == theTask{
                task.parentGroup.tasks.remove(at: i)
            }
            i += 1
        }
        User.shared.saveDataToDefaults()
        dataSourceReady()
        reloadData()
    }

}

extension ListTableView: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "listCell", for: indexPath) as! ListTableViewCell
        
        cell.listTitle.text = self.todaysTasks[indexPath.row].name
        
        cell.priorityColor.layer.cornerRadius = cell.priorityColor.frame.size.width/2
        cell.priorityColor.layer.masksToBounds = true
        cell.groupTitle.text = self.todaysTasks[indexPath.row].parentGroup.name
      
        cell.rightButtons = [MGSwipeButton(title: "Remove", backgroundColor: UIColor.red),MGSwipeButton(title: "Edit", backgroundColor: UIColor.orange) ]
        cell.leftSwipeSettings.transition = .drag
        cell.rightSwipeSettings.transition = .drag

        cell.leftButtons = [MGSwipeButton(title: "Done", backgroundColor: UIColor.green, callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Done")
            self.taskCompleted(task: self.todaysTasks[indexPath.row])
            return true
        })]
        
        cell.rightButtons = [MGSwipeButton(title: "Remove", backgroundColor: UIColor.red, callback: {
            (sender: MGSwipeTableCell!) -> Bool in
            print("Remove")
            self.removeTask(task: self.todaysTasks[indexPath.row])
            return true
        }),MGSwipeButton(title: "Edit", backgroundColor: UIColor.orange, callback: {
                                (sender: MGSwipeTableCell!) -> Bool in
            //
                                print("Edit")
                                
                                return true
                             })
        ]
        
        cell.selectionStyle = .none
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.todaysTasks.count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    
    
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        //hide the add button from the user
        UIView.animate(withDuration: 0.5, animations: {
            self.addButton?.alpha = 0.0
        }, completion: {(poo) in
            //self.addButton?.isHidden = true
        })
        
    }
    
    
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        //make the button reappear
        
        //self.addButton?.isHidden = false
        UIView.animate(withDuration: 0.5, animations: {
            self.addButton?.alpha = 1.0
        }, completion: {(poo) in
            
        })
 
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        //make the button reappear
        
         //self.addButton?.isHidden = false
         UIView.animate(withDuration: 0.5, animations: {
         self.addButton?.alpha = 1.0
         }, completion: {(poo) in
         
         })
        
    }
    
    
}

class ListCell: MGSwipeTableCell {
    
}


