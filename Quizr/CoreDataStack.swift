//
//  CoreDataStack.swift
//  Quizr
//
//  Created by Petr Reshetin on 03/11/2016.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit
import CoreData
import Foundation

class CoreDataStack {

    static func getReplies () {
        let fetchRequest: NSFetchRequest<Reply> = Reply.fetchRequest()
        
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            for reply in searchResults {
                print("\(reply.questionId), \(reply.isCorrect)")
            }
        } catch {
            print("Error with request: \(error)")
        }
    }
    
    static func storeReply(questionId: Int, isCorrect: Bool) {
        let context = getContext()
        
        if let existingReply = fetchReply(withId: questionId) {
            existingReply.isCorrect = isCorrect
            try! context.save()
        }
        else {
            let reply = Reply(context: context)
            reply.questionId = Int32(questionId)
            reply.isCorrect = isCorrect
            try! context.save()
        }
    }
    
    // MARK: - Private
    
    private static func fetchReply(withId id: Int) -> Reply? {
        let context = getContext()
        let predicate = NSPredicate(format: "questionId == %@", "\(id)")
        
        let fetchRequest: NSFetchRequest<Reply> = Reply.fetchRequest()
        fetchRequest.predicate = predicate
        
        let results = try! context.fetch(fetchRequest)
        
        if results.count == 0 {
            return nil
        }
        return results.first
    }
    
    private static func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
}
