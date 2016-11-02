//
//  SecondViewController.swift
//  Quizr
//
//  Created by Petr Reshetin on 23/08/16.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit
import CoreData

class ResultsViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReplies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getReplies () {
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
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }

}

