//
//  SettingsViewController.swift
//  TypeAPlanner
//
//  Created by Katie on 5/13/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//

import UIKit

class SettingsViewController: UITableViewController {

    @IBOutlet var morningNightSegmentedControl: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        let userDefaults = NSUserDefaults.standardUserDefaults()
        let morningPerson = userDefaults.boolForKey("morning_person")
        
        if morningPerson
        {
            morningNightSegmentedControl.selectedSegmentIndex = 0
        }
        else
        {
            morningNightSegmentedControl.selectedSegmentIndex = 1
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backPressed(sender: AnyObject) {
        self.dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func donePressed(sender: AnyObject) {
        let userDefaults = NSUserDefaults.standardUserDefaults()
        
        if morningNightSegmentedControl.selectedSegmentIndex == 0
        {
            userDefaults.setBool(true, forKey: "morning_person")
        }
        else
        {
            userDefaults.setBool(false, forKey: "morning_person")
        }
        
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
