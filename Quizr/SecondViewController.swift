//
//  SecondViewController.swift
//  Quizr
//
//  Created by Petr Reshetin on 23/08/16.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit
import CoreData

class SecondViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        getReplies()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func getReplies () {
        //create a fetch request, telling it about the entity
        let fetchRequest: NSFetchRequest<Reply> = Reply.fetchRequest()
        
        do {
            //go get the results
            let searchResults = try getContext().fetch(fetchRequest)
            
            //I like to check the size of the returned results!
            print ("num of results = \(searchResults.count)")
            
            //You need to convert to NSManagedObject to use 'for' loops
            for reply in searchResults as [NSManagedObject] {
                //get the Key Value pairs (although there may be a better way to do that...
                print("\(reply.value(forKey: "isCorrect"))")
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

