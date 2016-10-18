//
//  QuestionViewController.swift
//  Quizr
//
//  Created by Petr Reshetin on 05/09/16.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController, UITableViewDelegate {

    
    @IBOutlet weak var variantsTable: UITableView!
    @IBOutlet weak var questionTextLabel: UILabel!
    
    let questionDescription = "Какая переменная для отслеживания кампаний не является стандартной?"
    
    let variantAnswers = [
        "Создать дублирующее представление и добавить фильтр, выбрав “Включить только трафик в подкаталоги” и указав раздел.",
        "Добавить фильтр к представлению и удалить код отслеживания с других страниц вашего сайта.",
        "Создать новое представление применить фильтр, который удаляет данные о страницах, находящихся вне раздела.",
        "Создать второй аккаунт Google Analytics и установить отдельный код отслеживания на страницы раздела",
        "2Создать второй аккаунт Google Analytics и установить отдельный код отслеживания на страницы раздела",
        "3Создать второй аккаунт Google Analytics и установить отдельный код отслеживания на страницы раздела",
        "4Создать второй аккаунт Google Analytics и установить отдельный код отслеживания на страницы раздела"
    ]
    
    var topicName: String?
    
    internal func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return variantAnswers.count
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        variantsTable.tableFooterView = UIView()
        questionTextLabel.text = questionDescription
        print(topicName!)
    }

    
    
    internal func tableView(_ tableView: UITableView, cellForRowAtIndexPath indexPath: IndexPath) -> UITableViewCell {
        
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "ddd")
        cell.textLabel?.text = variantAnswers[(indexPath as NSIndexPath).row]
        
        return cell
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
