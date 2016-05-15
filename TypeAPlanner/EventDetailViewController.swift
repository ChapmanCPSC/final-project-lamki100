//
//  EventDetailViewController.swift
//  TypeAPlanner
//
//  Created by Katie on 5/8/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit
import CoreData
import EventKit

class EventDetailViewController: UITableViewController {
    
    var editingEvent : Event?

    @IBOutlet var titleTextField: UITextField!
    @IBOutlet var detailsTextField: UITextField!
    @IBOutlet var locationTextField: UITextField!
    @IBOutlet var durationTextField: UITextField!
    
    @IBOutlet var importanceScoreLabel: UILabel!
    @IBOutlet var rigorScoreLabel: UILabel!
    @IBOutlet var importanceSlider: UISlider!
    @IBOutlet var rigorSlider: UISlider!
    
    @IBOutlet var calendarSwitch: UISwitch!
    @IBOutlet var startTimeDatePicker: UIDatePicker!
    
    @IBOutlet var detailEventTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleTextField.placeholder = "Title"
        detailsTextField.placeholder = "Details"
        locationTextField.placeholder = "Location"
        durationTextField.placeholder = "Duration in hrs"
        
        let currentImportanceSliderValue = String(roundf(importanceSlider.value * 1))
        importanceScoreLabel.text = currentImportanceSliderValue
        
        let currentRigorSliderValue = String(roundf(rigorSlider.value * 1))
        rigorScoreLabel.text = currentRigorSliderValue
        
        // set the switch to off if it hasnt been set to on
        calendarSwitch.on = false

         //Do any additional setup after loading the view.
        
        if let event = editingEvent
        {
            
            titleTextField.text = event.title
            detailsTextField.text = event.details
            locationTextField.text = event.location
            durationTextField.text = event.duration!.stringValue
            
            importanceSlider.value = (event.importance as? Float)!
            rigorSlider.value = (event.rigor as? Float)!
            importanceScoreLabel.text = event.importance!.stringValue
            rigorScoreLabel.text = event.rigor!.stringValue
            
            startTimeDatePicker.date = event.deadline!
        }
        else
        {
            //self.deleteButton.hidden = true
        }
        
        //Looks for single or multiple taps.
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EventDetailViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    //Calls this function when the tap is recognized.
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func importanceSliderValueChanged(sender: AnyObject) {
        let currentSliderValue = String(roundf(importanceSlider.value * 1))
        importanceScoreLabel.text = currentSliderValue
        
        // set the levels
        let rigorLevel = Double(rigorScoreLabel.text!)
        let importanceLevel = Double(importanceScoreLabel.text!)
        
        // change start time
        let startTime = setStartTime(startingAt: startTimeDatePicker.date, withRigor: rigorLevel!, withImportance: importanceLevel!)
        
        startTimeDatePicker.date = startTime
    }
    
    @IBAction func rigorSliderValueChanged(sender: AnyObject) {
        let currentSliderValue = String(roundf(rigorSlider.value * 1))
        rigorScoreLabel.text = currentSliderValue
        
        // set the levels
        let rigorLevel = Double(rigorScoreLabel.text!)
        let importanceLevel = Double(importanceScoreLabel.text!)
        
        // change start time
        let startTime = setStartTime(startingAt: startTimeDatePicker.date, withRigor: rigorLevel!, withImportance: importanceLevel!)
        
        startTimeDatePicker.date = startTime
    }
    
    @IBAction func switchChanged(sender: AnyObject) {
        // request access to calendar
        let eventStore = EKEventStore();
        
        eventStore
        
        eventStore.requestAccessToEntityType(EKEntityType.Event, completion: {
            (accessGranted: Bool, error: NSError?) in
            
            if accessGranted == true {
                dispatch_async(dispatch_get_main_queue(), {
                    // good to go!
                    self.calendarSwitch.on = true
                })
            } else {
                dispatch_async(dispatch_get_main_queue(), {
                    // throw alert saying you must accept to have this feature
                    // create the alert
                    let alert = UIAlertController(title: "Error", message: "You must approve access to the Calendar to have this feature.", preferredStyle: UIAlertControllerStyle.Alert)
                    alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
                    self.presentViewController(alert, animated: true, completion: nil)
                    
                    // then turn switch off
                    self.calendarSwitch.on = false
                })
            }
        })
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func composeEvent(sender: AnyObject) {
        var edited = false
        
        // setting values
        let title = titleTextField.text
        let details = detailsTextField.text
        let location = locationTextField.text
        let duration = Double(durationTextField.text!)
        let curImportanceSlideValue = Double(importanceScoreLabel.text!)
        let curRigorSlideValue = Double(rigorScoreLabel.text!)
        let startTime = startTimeDatePicker.date
        
        // return if title, details, location, or duration are nil
        if title == nil || details == nil || location == nil || duration == nil
        {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "Please fill out all sections.", preferredStyle: UIAlertControllerStyle.Alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default, handler: nil))
            self.presentViewController(alert, animated: true, completion: nil)
            
            return
        }
        
        let appDelegate = AppDelegate.GetInstance()
        
        if let currentEvent = editingEvent
        {
            currentEvent.title = title!
            currentEvent.details = details!
            currentEvent.location = location!
            currentEvent.duration = duration!
            currentEvent.importance = curImportanceSlideValue
            currentEvent.rigor = curRigorSlideValue
            currentEvent.deadline = startTime
            
            edited = true
        }
        else
        {
            let event = NSEntityDescription.insertNewObjectForEntityForName("Event", inManagedObjectContext: appDelegate.managedObjectContext) as! Event
            event.title = title!
            event.details = details!
            event.location = location!
            event.duration = duration!
            event.importance = curImportanceSlideValue
            event.rigor = curRigorSlideValue
            event.deadline = startTime
        }
        
        // if they want it on the calendar and its not an edited event then add it
        if calendarSwitch.on && !edited
        {
            makeCalendarEvent(title, details, at: location, withLength: duration, withStartTime: startTime)
        }
        
        appDelegate.saveContext()
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func makeCalendarEvent(title: String?, _ details: String?, at location: String?, withLength duration: Double?, withStartTime startTime: NSDate)
    {
        // make sure calendar has been created
        let calendar = AppDelegate.GetInstance().typeACalendar
        
        if calendar != nil
        {
            let eventStore = EKEventStore()
            
            let event = EKEvent(eventStore: eventStore)
            event.calendar = calendar!
            
            event.title = title!
            event.notes = details
            event.location = location
            event.startDate = startTime
            // 2 hours
            event.endDate = startTime.dateByAddingTimeInterval(duration! * 60 * 60)
            
            // save event
            do {
                try eventStore.saveEvent(event, span: .ThisEvent)
            } catch let specError as NSError {
                print("A specific error occurred: \(specError)")
            }
        }
    }
    
    func setStartTime(startingAt startTime: NSDate, withRigor rigor: Double, withImportance importance: Double) -> NSDate
    {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let morning = userDefaults.boolForKey("morning_person")
        
        let calendar = NSCalendar.currentCalendar()
        let components = calendar.components([.Day , .Month , .Year], fromDate: startTime)
        
        if (morning)
        {
            if rigor >= 1.0 && rigor < 4.0
            {
                // 1pm
                components.hour = 13
                components.minute = 00
            }
            else if rigor >= 4.0 && rigor < 7.0
            {
                // 11pm
                components.hour = 11
                components.minute = 00
            }
            else if rigor >= 7.0 && rigor < 10.0
            {
                // 9am
                components.hour = 09
                components.minute = 00
            }
        }
        else
        {
            if rigor >= 1.0 && rigor < 4.0
            {
                // 1pm
                components.hour = 13
                components.minute = 00
            }
            else if rigor >= 4.0 && rigor < 7.0
            {
                // 5pm
                components.hour = 17
                components.minute = 00
            }
            else if rigor >= 7.0 && rigor < 10.0
            {
                // 8pm
                components.hour = 20
                components.minute = 00
            }
        
        }
        let newDate = calendar.dateFromComponents(components)
        return newDate!
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
