//
//  Reply+CoreDataProperties.swift
//  Quizr
//
//  Created by Petr Reshetin on 01/11/2016.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import Foundation
import CoreData


extension Reply {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Reply> {
        return NSFetchRequest<Reply>(entityName: "Reply");
    }

    @NSManaged public var question_id: Int32
    @NSManaged public var is_correct: Bool

}
