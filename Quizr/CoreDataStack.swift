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
    
    let topics = ["Рекламные кампании", "Код отслеживания", "Цели и конверсии", "Метрики и параметры"]
    let descriptions = [
        "Контекстная реклама, AdWords, пометка ссылок. Ответы на эти вопросы особенно важно знать специалистам по рекламе.",
        "Что такое trackPageview? Зачем нужны виртуальные страницы? Эти и другие вопросы про стандартный код отслеживания и код отслеживания электронной торговли.",
        "Что такое цель. Как назначать цель. Зачем назначать ценность цели. Отличия целей от транзакций. Зачем нужна визуализация последовательностей.",
        "Отличия метрик от параметров. Показатель отказов, длительность посещений, CTR . Зачем нужны эти метрики, и как ими пользоваться. Чем отличаются клики от посещений."
    ]
    
    func getTopics() -> [Topic]? {
        if let topics = fetchTopics() {
            if topics.count == 0 {
                insertInitialTopics()
                return topics
            } else {
                print("there are some topics")
            }
        }
        return nil
    }
    
    func fetchTopics() -> [Topic]? {
        let context = getContext()
        let fetchRequest: NSFetchRequest<Topic> = Topic.fetchRequest()
        do {
            let searchResults = try context.fetch(fetchRequest)
            return searchResults
        } catch {
            print("Error with request \(error)")
        }
        return nil
    }
    
    func getReplies() -> [Reply]? {
        let fetchRequest: NSFetchRequest<Reply> = Reply.fetchRequest()
        
        do {
            let searchResults = try getContext().fetch(fetchRequest)
            return searchResults
        } catch {
            print("Error with request: \(error)")
        }
        return nil
    }
    
    func storeReply(questionId: Int, isCorrect: Bool) {
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
    
    func getContext() -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
    // MARK: - Private
    
    private func insertInitialTopics() {
        let context = getContext()
        
        for i in 0...(topics.count - 1) {
            let topic = Topic(context: context)
            topic.name = topics[i]
            topic.summary = descriptions[i]
            try! context.save()
        }
    }
    
    private func fetchReply(withId id: Int) -> Reply? {
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
}
