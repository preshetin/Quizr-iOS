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

    @IBOutlet weak var replies: UILabel!
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        replies.text = ""
        if let replies = CoreDataStack.getReplies() {
            for reply in replies {
                self.replies.text! += "\(reply.questionId), \(reply.isCorrect)|"
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

