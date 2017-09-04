//
//  AddViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 12/11/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import KeyboardWrapper
import RSKGrowingTextView
class AddViewController: UIViewController {
    
    @IBOutlet weak var groupScrollView: UIScrollView!
    @IBOutlet weak var addTextView: RSKGrowingTextView!
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    fileprivate var keyboardWrapper: KeyboardWrapper?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.navigationController?.navigationBar.barTintColor = User.shared.colorPallete["nav"]
        //self.navigationController?.navigationBar.isTranslucent = false
        
        let leftLabel = UILabel()
        leftLabel.text = "Exit"
        leftLabel.textColor = UIColor.white
        leftLabel.font = UIFont(name: "Arial", size: 27)
        leftLabel.sizeToFit()
        
        let exitButton = UIButton()
        
        exitButton.setTitle("exit", for: .normal)
        exitButton.setTitleColor(UIColor.white, for: .normal)
        exitButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        exitButton.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: exitButton)
        
        self.navigationItem.leftBarButtonItem = leftItem
        
        let doneButton = UIButton()
        doneButton.setTitle("detailed", for: .normal)
        doneButton.setTitleColor(UIColor.white, for: .normal)
        doneButton.addTarget(self, action: #selector(dismissViewController), for: .touchUpInside)
        doneButton.sizeToFit()
        
        let rightItem = UIBarButtonItem(customView: doneButton)
        
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        keyboardWrapper = KeyboardWrapper(delegate: self)
        
        addTextView.delegate = self
        
        addTextView.becomeFirstResponder()
        
        addGroups()
    }
    
    private func addGroups(){
        var xOrigin = 0
        _ = groupScrollView.frame.size.width
       
        for i in 0...User.shared.groups.count-1{
            let groupLabel = UILabel(frame: CGRect(x: CGFloat(xOrigin), y: 0, width: self.groupScrollView.frame.width*0.2, height: self.groupScrollView.frame.height*0.9))
            groupLabel.text = User.shared.groups[i].name
            
            groupLabel.textColor = UIColor.red
            
            xOrigin += Int(groupLabel.frame.width+5)
            
            
            let bttn = UIButton(frame: groupLabel.frame)
            bttn.tag = i
            bttn.addTarget(self, action: #selector(setGroup), for: .touchUpInside)
            
            self.groupScrollView.addSubview(groupLabel)
            self.groupScrollView.addSubview(bttn)
        }
        
        self.groupScrollView.contentSize = CGSize(width: Int(self.groupScrollView.frame.width*0.2)*User.shared.groups.count + (5*User.shared.groups.count), height: Int(self.groupScrollView.frame.height))
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    /*
    @objc private func dismissViewController(){
        self.dismiss(animated: true, completion: {
        })
    }
    */
    
    @IBAction func dismissViewController(_ sender: Any) {
        addTextView.resignFirstResponder()
        self.dismiss(animated: true, completion: {
        })
    }
    
    
    
    @objc private func setGroup(_ sender:UIButton){
        print("sent from \(User.shared.groups[sender.tag].name)")
        let string = self.addTextView.text + "@\(User.shared.groups[sender.tag].name)"
        self.addTextView.text = string
        User.shared.currentGroupEditable = User.shared.groups[sender.tag]
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

extension AddViewController: KeyboardWrapperDelegate {
    func keyboardWrapper(_ wrapper: KeyboardWrapper, didChangeKeyboardInfo info: KeyboardInfo) {
        
        if info.state == .willShow || info.state == .visible {
            //self.addViewBottomCons.constant = info.endFrame.size.height
            self.bottomConstraint.constant = info.endFrame.size.height
        } else {
            self.bottomConstraint.constant = 0.0
            /*
             self.addViewBottomCons.constant = 0.0
             self.addView.isHidden = true
             self.addTextView.isHidden = true
             self.topBorderTextView.isHidden = true
             self.removeKeyboard.removeFromSuperview()
             */
        }
        
        UIView.animate(withDuration: info.animationDuration, delay: 0.0, options: info.animationOptions, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}

extension AddViewController: RSKGrowingTextViewDelegate{
    func textViewDidBeginEditing(_ textView: UITextView) {
        
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        User.shared.saveDataToDefaults()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n"{
            //textView.resignFirstResponder()
            if textView.text != ""{
                
                User.shared.addTask(withGroup: User.shared.currentGroupEditable, task: Tasks(name: textView.text.replacingOccurrences(of: "@\(User.shared.currentGroupEditable.name)", with: ""), group: User.shared.currentGroupEditable))
                if User.shared.currentViewController is ViewController {
                    (User.shared.currentViewController as! ViewController).timeLineTable.dataSourceReady()
                    (User.shared.currentViewController as! ViewController).timeLineTable.reloadData()
                }
                //tableViews[groupsSegment.selectedSegmentioIndex].reloadData()
                textView.text = ""
                return false
            }else{
                textView.resignFirstResponder()
            }
        }
        return true
    }
    
    func growingTextView(_ textView: RSKGrowingTextView, didChangeHeightFrom growingTextViewHeightBegin: CGFloat, to growingTextViewHeightEnd: CGFloat){
        
    }
    
    func growingTextView(_ textView: RSKGrowingTextView, willChangeHeightFrom growingTextViewHeightBegin: CGFloat, to growingTextViewHeightEnd: CGFloat){
        
    }
}
