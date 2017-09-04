//
//  AddView.swift
//  To Do This
//
//  Created by Devin Yancey on 11/26/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import KeyboardWrapper
import RSKGrowingTextView

protocol AddViewDelegate{
    func didRetrieveDataFromDefaults(userFound: Bool)
    func savedDataToDefaults()
}

class AddView: UIView {
    var view:UIView!
    
    var delegate: AddViewDelegate?
    
    fileprivate var keyboardWrapper: KeyboardWrapper?
    
    @IBOutlet weak var bottomConstraint: NSLayoutConstraint!
    @IBOutlet weak var textView: RSKGrowingTextView!
    @IBOutlet weak var bottomView: UIView!
    @IBOutlet weak var textField: UITextField!
    var numLines = 0
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */
    
    
     override init (frame: CGRect){
     super.init(frame: frame)
     xibSetup()
     }
     
     required init?(coder aDecoder: NSCoder) {
     super.init(coder: aDecoder)
     //fatalError("init(coder:) has not been implemented")
     xibSetup()
     }
     
     func xibSetup(){
     view = loadViewFromNib()
     
     view.frame = bounds
     
     view.autoresizingMask = [UIViewAutoresizing.flexibleWidth, UIViewAutoresizing.flexibleHeight]
     
     addSubview(view)
        
        
        //textView.textColor = UIColor.lightGray
        //textView.text = "place holder text"
        //textView.delegate = self
        //numLines = Int(textView.contentSize.height) / Int((textView.font?.lineHeight)!)
        
       
     }
     
     func loadViewFromNib() -> UIView{
     let bundle = Bundle(for: type(of: self))
     let nib = UINib(nibName: "AddView", bundle: bundle)
     let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
     
     return view
     
     }
 
    @IBAction func removeKeyboard(_ sender: Any) {
        self.endEditing(true)
        
    }
}

extension AddView: KeyboardWrapperDelegate {
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

extension AddView: RSKGrowingTextViewDelegate{
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


