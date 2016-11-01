//
//  FirstViewController.swift
//  Quizr
//
//  Created by Petr Reshetin on 23/08/16.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit

class TopicsViewController: UIViewController, UITableViewDataSource, UITableViewDelegate  {
    
    let topics = ["Рекламные кампании", "Код отслеживания", "Цели и конверсии", "Метрики и параметры"]
    let descriptions = [
        "Контекстная реклама, AdWords, пометка ссылок. Ответы на эти вопросы особенно важно знать специалистам по рекламе.",
        "Что такое trackPageview? Зачем нужны виртуальные страницы? Эти и другие вопросы про стандартный код отслеживания и код отслеживания электронной торговли.",
        "Что такое цель. Как назначать цель. Зачем назначать ценность цели. Отличия целей от транзакций. Зачем нужна визуализация последовательностей.",
       "Отличия метрик от параметров. Показатель отказов, длительность посещений, CTR . Зачем нужны эти метрики, и как ими пользоваться. Чем отличаются клики от посещений."
        
    ]
    
    @IBOutlet weak var topicsTable: UITableView!
    
    @IBAction func unwindToTopics(segue: UIStoryboardSegue) {}
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return topics.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cellaa", for: indexPath) as! TopicTableViewCell
        cell.nameLabel.text = topics[(indexPath as NSIndexPath).row]
        cell.descriptionLabel.text = descriptions[(indexPath as NSIndexPath).row]
//        cell.selectionStyle = .none
        return cell
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
                    vc.topicName = topics[(index as NSIndexPath).row]
                }
            }
        }
    }

    
    override func viewDidLoad() {
        super.viewDidLoad()
        topicsTable.rowHeight = UITableViewAutomaticDimension
        topicsTable.estimatedRowHeight = 100
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


}

