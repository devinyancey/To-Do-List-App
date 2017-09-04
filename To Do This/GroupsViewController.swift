//
//  GroupsViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 12/7/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import MGSwipeTableCell
class GroupsViewController: ToDoListViewController {

    
    @IBOutlet weak var groupsCollectionView: GroupsCollectionView!
    
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        //self.topView.backgroundColor = User.shared.colorPallete["nav"]
        //self.navigationController?.navigationBar.barTintColor = User.shared.colorPallete["nav"]
        //self.navigationController?.navigationBar.isTranslucent = false
        
        let leftLabel = UILabel()
        leftLabel.text = "Groups"
        leftLabel.textColor = UIColor.white
        leftLabel.font = UIFont(name: "Arial", size: 27)
        leftLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: leftLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        self.topView.backgroundColor = User.shared.colorPallete?["nav"]
        
        groupsCollectionView.dataSourceReady()
        
        
        
        //[self.tableView registerNib:[UINib nibWithNibName:@"CustomTableViewCell" bundle:nil] forCellReuseIdentifier:@"ItemCell"];
    }
    
    override func viewDidAppear(_ animated: Bool) {
       User.shared.currentViewController = self
    }
    
    override func viewDidLayoutSubviews() {
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
