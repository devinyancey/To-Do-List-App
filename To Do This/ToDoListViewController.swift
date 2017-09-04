//
//  ToDoListViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 12/8/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import Foundation
import UIKit
import KCFloatingActionButton
import RSKGrowingTextView
import KeyboardWrapper

class ToDoListViewController: UIViewController {
    
    var floatingButton: KCFloatingActionButton! = KCFloatingActionButton()
    
    var currentCalendar: Calendar?
    
    override func viewDidLoad() {
        
        let timeZoneBias = 480 // (UTC+08:00)
        currentCalendar = Calendar.init(identifier: .gregorian)
        if let timeZone = TimeZone.init(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
        
        //self.topView.backgroundColor = User.shared.colorPallete["nav"]
        self.navigationController?.navigationBar.barTintColor = User.shared.colorPallete["nav"]
        self.navigationController?.navigationBar.isTranslucent = false
        
    }
    
    override func viewDidLayoutSubviews() {
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        /*
        floatingButton.frame = CGRect(x: self.view.frame.width-self.view.frame.width*0.2, y: self.view.frame.height-self.view.frame.width*0.3, width: self.view.frame.width*0.13, height: self.view.frame.width*0.13)
        //floatingButton.buttonColor = UIColor.purple
        //
        floatingButton.buttonColor = (User.shared.colorPallete?["addButton"])!
        floatingButton.plusColor = UIColor.white
        self.view.addSubview(floatingButton)
 */
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        //floatingButton.removeFromSuperview()
    }
    
}

extension ToDoListViewController: RSKGrowingTextViewDelegate{
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
                //User.shared.addTask(withGroup: User.shared.currentGroupEditable, task: Tasks(name: textView.text))
                
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

extension ToDoListViewController: KeyboardWrapperDelegate {
    func keyboardWrapper(_ wrapper: KeyboardWrapper, didChangeKeyboardInfo info: KeyboardInfo) {
        
        if info.state == .willShow || info.state == .visible {
            
        } else {
            
            
        }
        
        UIView.animate(withDuration: info.animationDuration, delay: 0.0, options: info.animationOptions, animations: { () -> Void in
            self.view.layoutIfNeeded()
        }, completion: nil)
    }
}
