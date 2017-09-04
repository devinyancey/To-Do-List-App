//
//  ListTableViewCell.swift
//  To Do This
//
//  Created by Devin Yancey on 11/25/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import MGSwipeTableCell
import RSKGrowingTextView
class ListTableViewCell: MGSwipeTableCell, MGSwipeTableCellDelegate {

    @IBOutlet weak var priorityColor: UIView!
    
    @IBOutlet weak var groupTitle: UILabel!
    
  
    
    @IBOutlet weak var listTitle: UILabel!
    
    func swipeTableCell(_ cell: MGSwipeTableCell, tappedButtonAt index: Int, direction: MGSwipeDirection, fromExpansion: Bool) -> Bool {
        return true
    }
}



class GroupCell: UICollectionViewCell {
    @IBOutlet weak var centerView: UIView!
    @IBOutlet weak var groupColor: UIView!
    @IBOutlet weak var groupName: UILabel!
    @IBOutlet weak var taskNumber: UILabel!
    @IBOutlet weak var groupColorCircle: UIImageView!
    
}

class AddGroupCell: UITableViewCell {
    
}
