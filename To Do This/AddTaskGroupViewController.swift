//
//  AddTaskGroupViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 11/26/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit

class AddTaskGroupViewController: UIViewController {

   
    @IBOutlet weak var addGroupTextView: IsaoTextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor =  User.shared.colorPallete?["nav"]
        self.navigationController?.navigationBar.isTranslucent = false
        /*
        let doneButton = UIButton()
        doneButton.setTitle("done", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.addTarget(self, action: #selector(addGroup), for: .touchUpInside)
        doneButton.sizeToFit()
        
        let rightItem = UIBarButtonItem(customView: doneButton)
        
        self.navigationItem.rightBarButtonItem = rightItem
 */
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        //User.shared.currentViewController = self
        (UIApplication.shared.keyWindow as! ToDoListWindow).addButton.isHidden = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addGroup(_ sender: Any) {
        User.shared.addGroup(withGroup: Group(name:addGroupTextView.text!, tasks: []))
    }

    @IBAction func popViewController(_ sender: Any) {
        self.dismiss(animated: true, completion: {
            (UIApplication.shared.keyWindow as! ToDoListWindow).addButton.isHidden = false
        })
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
