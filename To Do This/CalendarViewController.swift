//
//  CalendarViewController.swift
//  To Do This
//
//  Created by Devin Yancey on 12/8/16.
//  Copyright © 2016 Devin Yancey. All rights reserved.
//

import UIKit
import CVCalendar
class CalendarViewController: ToDoListViewController {
    
    struct Color {
        static let selectedText = UIColor.white
        static let text = UIColor.black
        static let textDisabled = UIColor.gray
        static let selectionBackground = UIColor(red: 0.2, green: 0.2, blue: 1.0, alpha: 1.0)
        static let sundayText = UIColor(red: 1.0, green: 0.2, blue: 0.2, alpha: 1.0)
        static let sundayTextDisabled = UIColor(red: 1.0, green: 0.6, blue: 0.6, alpha: 1.0)
        static let sundaySelectionBackground = sundayText
    }
    
    fileprivate var randomNumberOfDotMarkersForDay = [Int]()
    
    var shouldShowDaysOut = true
    var animationFinished = true
    
    var selectedDay:DayView!
    
    //var currentCalendar: Calendar?
    
    let rightLabel = UILabel()

    @IBOutlet weak var timeLineTable: ListTableView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var menuView: CVCalendarMenuView!
    @IBOutlet weak var topView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        /*
        self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        self.navigationController?.navigationBar.shadowImage = UIImage()
        self.navigationController?.navigationBar.isTranslucent = true
        self.navigationController?.view.backgroundColor = UIColor.clear
        */
        self.topView.backgroundColor = User.shared.colorPallete["nav"]
        //self.navigationController?.navigationBar.barTintColor = User.shared.colorPallete["nav"]
        //self.navigationController?.navigationBar.isTranslucent = false
        
        timeLineTable.dataSourceReady()
        timeLineTable.rowHeight = UITableViewAutomaticDimension
        timeLineTable.estimatedRowHeight = 70
        /*
        self.navigationController?.navigationBar.flat = true
        self.navigationController?.navigationBar.barTintColor = User.shared.colorPallete["nav"]
        self.navigationController?.view.backgroundColor =  User.shared.colorPallete["nav"]
 
        
        let timeZoneBias = 480 // (UTC+08:00)
        currentCalendar = Calendar.init(identifier: .gregorian)
        if let timeZone = TimeZone.init(secondsFromGMT: -timeZoneBias * 60) {
            currentCalendar?.timeZone = timeZone
        }
        
       */
        
        //randomizeDotMarkers()
        
        calendarView.delegate = self
        menuView.delegate = self
        
        
        let leftLabel = UILabel()
        leftLabel.text = "Calendar"
        leftLabel.textColor = UIColor.white
        leftLabel.font = UIFont(name: "Arial", size: 27)
        leftLabel.sizeToFit()
        
        let leftItem = UIBarButtonItem(customView: leftLabel)
        self.navigationItem.leftBarButtonItem = leftItem
        
        
        rightLabel.text = CVDate(date: Date(), calendar: currentCalendar!).commonDescription
        rightLabel.textColor = UIColor.white
        rightLabel.font = UIFont(name: "Arial", size: 20)
        rightLabel.sizeToFit()
        
        let rightItem = UIBarButtonItem(customView: rightLabel)
        self.navigationItem.rightBarButtonItem = rightItem
        
        
        
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        menuView.commitMenuViewUpdate()
        calendarView.commitCalendarViewUpdate()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    private func randomizeDotMarkers() {
        randomNumberOfDotMarkersForDay = [Int]()
        for _ in 0...31 {
            randomNumberOfDotMarkersForDay.append(Int(arc4random_uniform(3) + 1))
        }
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

extension CalendarViewController:CVCalendarViewDelegate, CVCalendarMenuViewDelegate{
    
    /// Required method to implement!
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    /// Required method to implement!
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    
    // MARK: Optional methods
    /*
    func calendar() -> Calendar? {
        return currentCalendar
    }
    */
    func dayOfWeekTextColor(by weekday: Weekday) -> UIColor {
        return weekday == .sunday ? UIColor(red: 1.0, green: 0, blue: 0, alpha: 1.0) : UIColor.white
    }
    
    func shouldShowWeekdaysOut() -> Bool {
        return shouldShowDaysOut
    }
    
    func shouldAnimateResizing() -> Bool {
        return true // Default value is true
    }
    
    private func shouldSelectDayView(dayView: DayView) -> Bool {
        return arc4random_uniform(3) == 0 ? true : false
    }
    /*
    func shouldAutoSelectDayOnMonthChange() -> Bool {
        return false
    }
    */
    func didSelectDayView(_ dayView: CVCalendarDayView, animationDidFinish: Bool) {
        selectedDay = dayView
    }
    /*
    func shouldSelectRange() -> Bool {
        return true
    }
 
    func didSelectRange(from startDayView: DayView, to endDayView: DayView) {
        print("RANGE SELECTED: \(startDayView.date.commonDescription) to \(endDayView.date.commonDescription)")
    }
    */
    func presentedDateUpdated(_ date: CVDate) {
        if rightLabel.text != date.commonDescription && self.animationFinished {
            let updatedrightLabel = UILabel()
            updatedrightLabel.textColor = rightLabel.textColor
            updatedrightLabel.font = rightLabel.font
            updatedrightLabel.textAlignment = .center
            updatedrightLabel.text = date.commonDescription
            updatedrightLabel.sizeToFit()
            updatedrightLabel.alpha = 0
            updatedrightLabel.center = self.rightLabel.center
            
            let offset = CGFloat(48)
            updatedrightLabel.transform = CGAffineTransform(translationX: 0, y: offset)
            updatedrightLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
            
            UIView.animate(withDuration: 0.35, delay: 0, options: UIViewAnimationOptions.curveEaseIn, animations: {
                self.animationFinished = false
                self.rightLabel.transform = CGAffineTransform(translationX: 0, y: -offset)
                self.rightLabel.transform = CGAffineTransform(scaleX: 1, y: 0.1)
                self.rightLabel.alpha = 0
                
                updatedrightLabel.alpha = 1
                updatedrightLabel.transform = CGAffineTransform.identity
                
            }) { _ in
                
                self.animationFinished = true
                self.rightLabel.frame = updatedrightLabel.frame
                self.rightLabel.text = updatedrightLabel.text
                self.rightLabel.transform = CGAffineTransform.identity
                self.rightLabel.alpha = 1
                updatedrightLabel.removeFromSuperview()
            }
            
            self.view.insertSubview(updatedrightLabel, aboveSubview: self.rightLabel)
        }
    }
    
    func topMarker(shouldDisplayOnDayView dayView: CVCalendarDayView) -> Bool {
        return true
    }
    
    
    func weekdaySymbolType() -> WeekdaySymbolType {
        return .short
    }
    
    func selectionViewPath() -> ((CGRect) -> (UIBezierPath)) {
        return { UIBezierPath(rect: CGRect(x: 0, y: 0, width: $0.width, height: $0.height)) }
    }
    
    func shouldShowCustomSingleSelection() -> Bool {
        return false
    }
    
    func preliminaryView(viewOnDayView dayView: DayView) -> UIView {
        let circleView = CVAuxiliaryView(dayView: dayView, rect: dayView.frame, shape: CVShape.circle)
        circleView.fillColor = .colorFromCode(0xCCCCCC)
        return circleView
    }
    
    func preliminaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (dayView.isCurrentDay) {
            return true
        }
        return false
    }
    /*
     
     EVENTUALLY ON DAYS WHERE THERE ARE TASKS?
     
    func supplementaryView(viewOnDayView dayView: DayView) -> UIView {
        
        dayView.setNeedsLayout()
        dayView.layoutIfNeeded()
        
        let π = M_PI
        
        let ringSpacing: CGFloat = 3.0
        let ringInsetWidth: CGFloat = 1.0
        let ringVerticalOffset: CGFloat = 1.0
        var ringLayer: CAShapeLayer!
        let ringLineWidth: CGFloat = 4.0
        let ringLineColour: UIColor = .blue
        
        let newView = UIView(frame: dayView.frame)
        
        let diameter: CGFloat = (min(newView.bounds.width, newView.bounds.height)) - ringSpacing
        let radius: CGFloat = diameter / 2.0
        
        let rect = CGRect(x: newView.frame.midX-radius, y: newView.frame.midY-radius-ringVerticalOffset, width: diameter, height: diameter)
        
        ringLayer = CAShapeLayer()
        newView.layer.addSublayer(ringLayer)
        
        ringLayer.fillColor = nil
        ringLayer.lineWidth = ringLineWidth
        ringLayer.strokeColor = ringLineColour.cgColor
        
        let ringLineWidthInset: CGFloat = CGFloat(ringLineWidth/2.0) + ringInsetWidth
        let ringRect: CGRect = rect.insetBy(dx: ringLineWidthInset, dy: ringLineWidthInset)
        let centrePoint: CGPoint = CGPoint(x: ringRect.midX, y: ringRect.midY)
        let startAngle: CGFloat = CGFloat(-π/2.0)
        let endAngle: CGFloat = CGFloat(π * 2.0) + startAngle
        let ringPath: UIBezierPath = UIBezierPath(arcCenter: centrePoint, radius: ringRect.width/2.0, startAngle: startAngle, endAngle: endAngle, clockwise: true)
        
        ringLayer.path = ringPath.cgPath
        ringLayer.frame = newView.layer.bounds
        
        return newView
    }
    
    func supplementaryView(shouldDisplayOnDayView dayView: DayView) -> Bool {
        if (Int(arc4random_uniform(3)) == 1) {
            return true
        }
        
        return false
    }
    */
    func dayOfWeekTextColor() -> UIColor {
        return UIColor.white
    }
    
    func dayOfWeekBackGroundColor() -> UIColor {
        return UIColor.clear
    }
    
    /*
    func disableScrollingBeforeDate() -> Date {
        return Date()
    }
    
    func maxSelectableRange() -> Int {
        return 14
    }
    
    func earliestSelectableDate() -> Date {
        return Date()
    }
    
    func latestSelectableDate() -> Date {
        var dayComponents = DateComponents()
        dayComponents.day = 70
        let calendar = Calendar(identifier: .gregorian)
        if let lastDate = calendar.date(byAdding: dayComponents, to: Date()) {
            return lastDate
        } else {
            return Date()
        }
    }
    */
}

extension CalendarViewController: CVCalendarViewAppearanceDelegate {
    
    func dayLabelWeekdayDisabledColor() -> UIColor {
        return UIColor.lightGray
    }
    
    func dayLabelPresentWeekdayInitallyBold() -> Bool {
        return false
    }
    
    func spaceBetweenDayViews() -> CGFloat {
        return 0
    }
    
    func dayLabelFont(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIFont { return UIFont.systemFont(ofSize: 14) }
    
    func dayLabelColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (_, .selected, _), (_, .highlighted, _): return Color.selectedText
        case (.sunday, .in, _): return Color.sundayText
        case (.sunday, _, _): return Color.sundayTextDisabled
        case (_, .in, _): return Color.text
        default: return Color.textDisabled
        }
    }
    
    func dayLabelBackgroundColor(by weekDay: Weekday, status: CVStatus, present: CVPresent) -> UIColor? {
        switch (weekDay, status, present) {
        case (.sunday, .selected, _), (.sunday, .highlighted, _): return Color.sundaySelectionBackground
        case (_, .selected, _), (_, .highlighted, _): return Color.selectionBackground
        default: return nil
        }
    }
}
