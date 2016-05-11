//
//  EventDetailViewController.swift
//  TypeAPlanner
//
//  Created by Katie on 5/8/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit
import CoreData

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
    @IBOutlet var deadlineDatePicker: UIDatePicker!
    
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
            
            deadlineDatePicker.date = event.deadline!
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
    }
    
    @IBAction func rigorSliderValueChanged(sender: AnyObject) {
        let currentSliderValue = String(roundf(rigorSlider.value * 1))
        rigorScoreLabel.text = currentSliderValue
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func composeEvent(sender: AnyObject) {
        // setting values
        let title = titleTextField.text
        let details = detailsTextField.text
        let location = locationTextField.text
        let duration = Double(durationTextField.text!)
        let curImportanceSlideValue = Double(importanceScoreLabel.text!)
        let curRigorSlideValue = Double(rigorScoreLabel.text!)
        let deadline = deadlineDatePicker.date
        
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
            currentEvent.deadline = deadline
            
            // if event is not nil ... then delete old event on calendar and then re make event
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
            event.deadline = deadline
        }
        
        appDelegate.saveContext()
        self.dismissViewControllerAnimated(true, completion: nil)
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
