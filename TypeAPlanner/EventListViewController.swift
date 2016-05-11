//
//  EventListViewController.swift
//  TypeAPlanner
//
//  Created by Katie on 5/8/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit
import CoreData

class EventListViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate {

    @IBOutlet var eventTableView: UITableView!
    
    var fetchedResultsController : NSFetchedResultsController!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        self.eventTableView.dataSource = self
        self.eventTableView.delegate = self
        
        let notesFetch = NSFetchRequest(entityName: "Event")
        let titleSort = NSSortDescriptor(key: "title", ascending: true)
        notesFetch.sortDescriptors = [titleSort]
        
        self.fetchedResultsController = NSFetchedResultsController(fetchRequest: notesFetch, managedObjectContext: AppDelegate.GetInstance().managedObjectContext, sectionNameKeyPath: nil, cacheName: "eventsCache")
        
        try! self.fetchedResultsController.performFetch()
        
        self.fetchedResultsController.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.fetchedResultsController.fetchedObjects!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let event = self.fetchedResultsController.fetchedObjects![indexPath.row] as! Event
        
        let cell = UITableViewCell()
        cell.textLabel!.text = event.title!
        
        return cell
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        let selectedEvent = self.fetchedResultsController.fetchedObjects![indexPath.row] as! Event
        
        let navVC = storyboard!.instantiateViewControllerWithIdentifier("event_detail_view") as! UINavigationController
        let eventVC = navVC.viewControllers[0] as! EventDetailViewController
        eventVC.editingEvent = selectedEvent
        
        self.presentViewController(navVC, animated: true, completion: nil)
    }
    
    func controllerDidChangeContent(controller: NSFetchedResultsController) {
        self.eventTableView.reloadData()
    }
    

    @IBAction func backPressed(sender: AnyObject) {
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
