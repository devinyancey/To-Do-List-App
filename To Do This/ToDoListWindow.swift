//
//  ToDoListWindow.swift
//  To Do This
//
//  Created by Devin Yancey on 12/8/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import KCFloatingActionButton



class ToDoListWindow: UIWindow {
    
    var addButton: KCFloatingActionButton!
    var notAdded = true
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public func addFloatingButton(){
        if notAdded{
            addButton = KCFloatingActionButton(frame: CGRect(x: self.frame.width-self.frame.width*0.2, y: self.frame.height-self.frame.width*0.3, width: self.frame.width*0.13, height: self.frame.width*0.13))
            
            addButton.buttonColor = (User.shared.colorPallete?["addButton"])!
            addButton.plusColor = UIColor.white
            
            addButton.openAnimationType = .fade
            addButton.sticky = true
            //addButton.overlayColor = UIColor.clear
            
            
            addButton.addItem(title: "Create new task", handler: {_ in
                
                //present view over the window with blur create task view
                /*
                if let addVC = storyboard!.instantiateViewControllerWithIdentifier("SomeID") as? ResultViewController {
                    presentViewController(resultController, animated: true, completion: nil)
                }
 */
                /*
                let storyboard = UIStoryboard(name: "AddViewStoryBoard", bundle: nil)
                let controller = storyboard.instantiateViewController(withIdentifier: "AddVC") as! AddViewController
                User.shared.currentViewController.present(controller, animated: true, completion: nil)
 */
                //let addVc = AddViewController()
                User.shared.currentViewController.performSegue(withIdentifier: "presentAdd", sender: nil)
                
            })
            
            addButton.addItem(title: "Create new group", handler: {_ in
                //self.performSegue(withIdentifier: "presentAdd", sender: nil)
                //present view over the window with blur create new group view
                User.shared.currentViewController.performSegue(withIdentifier: "presentGroup", sender: nil)
            })
            //KCFABManager.defaultInstance().getButton().bounds = addButton.bounds
            
            //self.addSubview(KCFABManager.defaultInstance().getButton())
            self.addSubview(addButton)
            
            
            notAdded = false
        }
        
        
    }

}

