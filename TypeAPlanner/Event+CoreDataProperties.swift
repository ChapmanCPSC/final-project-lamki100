//
//  Event+CoreDataProperties.swift
//  TypeAPlanner
//
//  Created by Katie on 5/8/16.
//  Copyright © 2016 Chapman University. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Event {

    @NSManaged var title: String?
    @NSManaged var details: String?
    @NSManaged var location: String?
    @NSManaged var duration: NSNumber?
    @NSManaged var importance: NSNumber?
    @NSManaged var rigor: NSNumber?
    @NSManaged var deadline: NSDate?

}
