//
//  Event+CoreDataProperties.swift
//  TypeAPlanner
//
//  Created by Katie on 5/15/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var deadline: NSDate?
    @NSManaged var details: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var importance: NSNumber?
    @NSManaged var location: String?
    @NSManaged var rigor: NSNumber?
    @NSManaged var title: String?

}
