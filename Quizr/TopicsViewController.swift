//
//  FirstViewController.swift
//  Quizr
//
//  Created by Petr Reshetin on 23/08/16.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit
import CoreData

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, NSFetchedResultsControllerDelegate  {
    
    // MARK: - Variables and constants
    
    let cds = CoreDataStack()
    var managedObjectContext: NSManagedObjectContext? = nil
    
    // MARK: - IBOutlets
        
    @IBOutlet weak var topicsTable: UITableView!
    @IBAction func unwindToTopics(segue: UIStoryboardSegue) {}
    
    // MARK: - Table view
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        let sectionInfo = self.fetchedResultsController.sections![section]
        return sectionInfo.numberOfObjects
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellaa", for: indexPath) as! TopicTableViewCell
        let topic = self.fetchedResultsController.object(at: indexPath)
        self.configureCell(cell, withTopic: topic)
//        cell.selectionStyle = .none
        return cell
    }
    
    func configureCell(_ cell: TopicTableViewCell, withTopic topic: Topic) {
        cell.nameLabel.text = topic.name
        cell.descriptionLabel.text = topic.summary
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if let indexPath = topicsTable.indexPathForSelectedRow {
            self.topicsTable.deselectRow(at: indexPath, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: "showTopicQuiz", sender: indexPath)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let index = sender as? IndexPath {
            if segue.identifier == "showTopicQuiz" {
                if let vc = segue.destination as? QuestionViewController {
                    vc.topicName = self.fetchedResultsController.object(at: index).name
                }
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicsTable.rowHeight = UITableViewAutomaticDimension
        topicsTable.estimatedRowHeight = 100
        let _ = cds.getTopics() // loads predifined topis
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Fetched results controller
    
    var fetchedResultsController: NSFetchedResultsController<Topic> {
        if _fetchedResultsController != nil {
            return _fetchedResultsController!
        }

        self.managedObjectContext = cds.getContext()
        
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        
        // Set the batch size to a suitable number.
        fetchRequest.fetchBatchSize = 20
        
        // Edit the sort key as appropriate.
        let sortDescriptor = NSSortDescriptor(key: "name", ascending: false)
        
        fetchRequest.sortDescriptors = [sortDescriptor]
        
        // Edit the section name key path and cache name if appropriate.
        // nil for section name key path means "no sections".
        let aFetchedResultsController = NSFetchedResultsController(fetchRequest: fetchRequest, managedObjectContext: self.managedObjectContext!, sectionNameKeyPath: nil, cacheName: "Master")
        aFetchedResultsController.delegate = self
        _fetchedResultsController = aFetchedResultsController
        
        do {
            try _fetchedResultsController!.performFetch()
        } catch {
            // Replace this implementation with code to handle the error appropriately.
            // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
            let nserror = error as NSError
            fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
        
        return _fetchedResultsController!
    }
    var _fetchedResultsController: NSFetchedResultsController<Topic>? = nil
    

}

