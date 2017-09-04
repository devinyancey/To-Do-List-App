//
//  GroupsCollectionView.swift
//  To Do This
//
//  Created by Devin Yancey on 12/8/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit

class GroupsCollectionView: UICollectionView {
    
    public func dataSourceReady() {
        dataSource = self
        delegate = self
        self.register(UINib(nibName: "GroupCell", bundle:nil), forCellWithReuseIdentifier: "groupCell")
        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        //layout.sectionInset = UIEdgeInsets(top: self.frame.size.height*0.02, left: 0.05, bottom: self.frame.size.height*0.02, right: 0.05)
        layout.itemSize = CGSize(width: self.frame.size.width/2.001 , height: self.frame.size.width/2.5)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 0
        self.setCollectionViewLayout(layout, animated: false, completion: nil)
        
        
    }

}

extension GroupsCollectionView : UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return (section * 2) - User.shared.groups.count > -2 ? abs((section * 2) - User.shared.groups.count) : 2
        //return 2
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        /*
         print(consDataSource[indexPath.row])
         selectedContent = consDataSource[(indexPath.section*2)+indexPath.row]
         selectedContentPos = (indexPath.section*2)+indexPath.row
         if notAlmostReady{
         UIApplication.shared.keyWindow?.rootViewController?.performSegue(withIdentifier: "showDetail", sender: self)
         }
         */
    }
    
}

extension GroupsCollectionView : UICollectionViewDataSource{
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Int(ceil(Double(Float(User.shared.groups.count)/Float(2))))
        //return 3
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! GroupCell
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = User.shared.colorPallete["selectionColor"]?.cgColor
        cell.groupColorCircle.image = cell.groupColorCircle.image?.set(color: UIColor.orange)
        cell.groupName.text = User.shared.groups[indexPath.section * 2 + indexPath.item].name
        cell.taskNumber.text = "\(User.shared.groups[indexPath.section * 2 + indexPath.item].tasks.count) tasks"
        //cell.frame.size = CGSize(width: collectionView.frame.size.width/2, height: collectionView.frame.size.width/3)
        //cell.centerView.layer.borderWidth = 1
        //let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "groupCell", for: indexPath) as! GroupCell
        /*
         //blackLayer.backgroundColor = UIColor
         var contains = false
         let cons = consDataSource[indexPath.section * 2 + indexPath.item]
         let cell = dequeueReusableCell(withReuseIdentifier: "PreCell", for: indexPath) as! installCell
         //cell.installCellImageView.contentMode = .scaleAspectFit
         cell.installCellImageView.imageFromServerURL(url: cons.images[0])
         //cell.installCellImageView.imageFromServerURL(url: cons.thumbnails[0])
         //cell.frame.size = CGSize(width: collectionView.frame.size.width/3, height: 90)
         if notAlmostReady {
         if User.shared.preSelectedIds.count > 0{
         for i in 0...User.shared.preSelectedIds.count-1{
         if User.shared.preSelectedIds[i].name == cons.name {
         contains = true
         }
         }
         }else{
         contains = false
         }
         }
         
         cell.checkmarkImage.isHidden = !contains
         cell.backgroundLayerView.isHidden = !contains
         
         */
        
        return cell
    }
    
    
    
}
