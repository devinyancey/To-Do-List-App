//
//  ViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 11/25/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit
import KCFloatingActionButton
import BubbleTransition
import KeyboardWrapper
import RSKGrowingTextView
import Segmentio
import RAMAnimatedTabBarController
import CVCalendar
protocol ViewControllerDelegate{
    func didFinishSetup()
}

class ViewController: ToDoListViewController {
    var delegate: ViewControllerDelegate?

    @IBOutlet weak var quickInfoLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var settingsSection: UIView!
    @IBOutlet weak var tableSection: UIView!
    
    @IBOutlet weak var timeLineTable: ListTableView!
    @IBOutlet weak var overViewSection: UIView!

    var menuOpened = false
    var tableViews:[ListTableView] = []
    let transition = BubbleTransition()
    //var currentCalendar: Calendar?
    
    fileprivate var keyboardWrapper: KeyboardWrapper?
    let removeKeyboard = UIButton()
    
    var timer = Timer()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //(self.tabBarItem as! RAMAnimatedTabBarItem).animation = RAMBounceAnimation.init()
        
        User.shared.delegate = self
        User.shared.retrieveDataFromDefaults()

        //groupsSegment.selectedSegmentioIndex = 0
        
        removeKeyboard.frame = tableSection.bounds
        removeKeyboard.addTarget(self, action: #selector(handleTap(_sender:)), for: .touchUpInside)

        self.dateLabel.text = CVDate(date: Date(), calendar: currentCalendar!).commonDescription

        self.navigationController?.navigationBar.isTranslucent = false
        let menuBttn:DynamicButton = DynamicButton(style: .hamburger)
        menuBttn.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        menuBttn.imageEdgeInsets = UIEdgeInsets(top: 5, left: 5, bottom: 5, right: 5)
        menuBttn.strokeColor = UIColor.white
        let leftMenuBttn = UIBarButtonItem(customView: menuBttn)
        self.navigationItem.leftBarButtonItem = leftMenuBttn
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.white
        self.navigationController?.navigationBar.flat = true

        keyboardWrapper = KeyboardWrapper(delegate: self)
        
        Timer.scheduledTimer(timeInterval: 4,
                             target: self,
                             selector: #selector(updateTimer),
                             userInfo: nil,
                             repeats: true)

    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        (UIApplication.shared.keyWindow as! ToDoListWindow).addFloatingButton()
        User.shared.currentViewController = self
        self.timeLineTable.reloadData()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //timer.invalidate()
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func menuButtonPressed(_ sender: Any) {
        if menuOpened{
            
            
            menuOpened = false
        }else{
            
            menuOpened = true
        }
    }


    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        //let controller = segue.destination
        //controller.transitioningDelegate = self
        //controller.modalPresentationStyle = .custom
    }
    
    @IBAction func handleTapRecognizer(_ sender: UITapGestureRecognizer) {
        
    }
    
    func handleTap(_sender: UITapGestureRecognizer){
        
    }
    
    func setUpLists(){
 
        timeLineTable.rowHeight = UITableViewAutomaticDimension
        timeLineTable.estimatedRowHeight = 70
        timeLineTable.dataSourceReady()
        
        overViewSection.backgroundColor = User.shared.colorPallete?["nav"]
        
        self.navigationController?.navigationBar.barTintColor =  User.shared.colorPallete?["nav"]
        

        
        
    }
    
    @objc private func updateTimer(){
        
        UIView.animate(withDuration: 0.3, animations: {
            self.quickInfoLabel.alpha = 0.0
        }, completion:  {finished in
            if (self.quickInfoLabel.text?.contains("Tasks Today"))!{
                self.quickInfoLabel.text = "3 Tasks Completed this Month"
            }else if (self.quickInfoLabel.text?.contains("Tasks Completed this Month"))!{
                self.quickInfoLabel.text = "100 Tasks this Month"
            }else if (self.quickInfoLabel.text?.contains("Tasks this Month"))!{
                self.quickInfoLabel.text = "29 Tasks Completed this Month"
            }else if (self.quickInfoLabel.text?.contains("Tasks Completed This Month"))!{
                self.quickInfoLabel.text = "5 Tasks Today"
            }
            
            UIView.animate(withDuration: 0.3, animations: {
                self.quickInfoLabel.alpha = 1.0
            })
        })
        
        
    }
        

}


extension ViewController:KCFloatingActionButtonDelegate{
    func KCFABOpened(_ fab: KCFloatingActionButton) {
        
    }
    
    func KCFABClosed(_ fab: KCFloatingActionButton) {
        
    }
}

extension ViewController:UIViewControllerTransitioningDelegate{
    public func animationController(forPresented presented: UIViewController, presenting: UIViewController, source: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.duration = 5
        transition.transitionMode = .present

        
        transition.bubbleColor = UIColor.red
        return transition
    }
    
    public func animationController(forDismissed dismissed: UIViewController) -> UIViewControllerAnimatedTransitioning? {
        transition.transitionMode = .dismiss
        //transition.startingPoint = someButton.center
        //transition.bubbleColor = someButton.backgroundColor!
        return transition
    }
}





extension ViewController: UserDelegate{
    func didRetrieveDataFromDefaults(userFound: Bool) {
        if userFound{
            print("retrived user from data")
            User.shared.colorPallete = ColorPalette.werkPress
            
        }else{
            print("did not retrieve user from data")
            //do the inital setup for the user here giving them a default list and a task that says welcome to blank
            
            
            //let task = Tasks(name: "Welcome to (app name)")
            
            
            let group = Group(name: "Default", tasks: [])
            let task = Tasks(name: "Welcome to (app name)", group: group)
            //let tasks:[Tasks] = [task]
            User.shared.addTask(withGroup: group, task: task)
            User.shared.addGroup(withGroup: group)
            User.shared.currentGroupEditable = group
            User.shared.colorPallete = ColorPalette.werkPress
            
        }

        self.setUpLists()
 
    }
    
    func savedDataToDefaults() {
        
    }
}

