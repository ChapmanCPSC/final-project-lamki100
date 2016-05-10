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
    
    @IBOutlet var importanceSlider: UISlider!
    @IBOutlet var rigorSlider: UISlider!
    @IBOutlet var deadlineDatePicker: UIDatePicker!
    
    @IBOutlet var detailEventTableView: UITableView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        //
        //    if let note = editingNote
        //    {
        //        self.titleTextField.text = note.title
        //        self.noteTextView.text = note.text
        //    }
        //    else
        //    {
        //        self.deleteButton.hidden = true
        //    }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func composeEvent(sender: AnyObject) {
        // if event is not nil ... then delete old event on calendar and then re make event
        
        //    let appDelegate = AppDelegate.GetInstance()
        //
        //    if let currentNote = editingNote
        //    {
        //        currentNote.title = self.titleTextField.text
        //        currentNote.text = self.noteTextView.text
        //    }
        //    else
        //    {
        //        let note = NSEntityDescription.insertNewObjectForEntityForName("Note", inManagedObjectContext: appDelegate.managedObjectContext) as! Note
        //        note.title = self.titleTextField.text!
        //        note.text = self.noteTextView.text!
        //    }
        //
        //    appDelegate.saveContext()
        //    self.navigationController!.popViewControllerAnimated(true)
    }

    
    //
    //@IBAction func deleteNote(sender: AnyObject) {
    //
    //    let appDelegate = AppDelegate.GetInstance()
    //    let dbContext = appDelegate.managedObjectContext
    //    dbContext.deleteObject(self.editingNote!)
    //
    //    appDelegate.saveContext()
    //    self.navigationController!.popViewControllerAnimated(true)
    //}
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

//@NSManaged var title: String?
//@NSManaged var details: String?
//@NSManaged var location: String?
//@NSManaged var duration: NSNumber?
//@NSManaged var importance: NSNumber?
//@NSManaged var rigor: NSNumber?
//@NSManaged var deadline: NSDate?


