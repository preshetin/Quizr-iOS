//
//  ViewController.swift
//  TempTry_1
//
//  Created by Petr Reshetin on 20/10/2016.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit
import CoreData

class QuestionViewController: UIViewController {
    
    // MARK: Constants and variables
    
    var questionId = 1
    var selectedVariant: Variant? = nil
    var topicName: String?
    
    // MARK: Interface Builder Outlets
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var variantsStackView: UIStackView!
    @IBOutlet weak var resultImageView: UIImageView!
    
    @IBOutlet weak var answerButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    @IBOutlet weak var finishButton: UIButton!
    
    // MARK: Interface Builder actions
    
    @IBAction func answer(_ sender: UIButton) {
        switch selectedVariant {
        case .none:
            print("Please choose variant")
        case .some(let variant):
            variantsStackView.isUserInteractionEnabled = false
            switch variant.isCorrect {
            case true:
                resultImageView.image = UIImage(named: "ok")
            case false:
                resultImageView.image = UIImage(named: "not-ok")
            }
            UIView.animate(withDuration: 0.2, animations: {
                self.resultImageView.isHidden = false
                self.resultImageView.alpha = 1
                }, completion: { _ in
                    UIView.animate(withDuration: 0.2, delay: 0.8, options: UIViewAnimationOptions.allowAnimatedContent, animations: {
                        self.resultImageView.alpha = 0
                        }, completion: nil)
            })
        }
        selectedVariant = nil
    }
    
    @IBAction func next() {
        questionId += 1
        prepareQuestion(withId: questionId)
    }
    
    @IBAction func finish() {
        self.performSegue(withIdentifier: "unwindToTopics", sender: self)
    }
    
    func variantTapped(_ gestureRegognizer: UIGestureRecognizer) {
        let label = gestureRegognizer.view as! UILabel
        switch (label.backgroundColor?.htmlRGBColor)! {
        case "#ffff00":
            label.backgroundColor = UIColor(white: 0.9, alpha: 1)
            selectedVariant = nil
        case "#e5e5e5":
            label.backgroundColor = UIColor.yellow
            let question = Question.questionsFromBundle()[questionId - 1]
            selectedVariant = question.findVariantByText(text: label.text!)
        default:
            break
        }
        for variantView in variantsStackView.arrangedSubviews {
            if let variantLabel = variantView as? UILabel {
                if variantLabel.text != label.text {
                    variantLabel.backgroundColor = UIColor(white: 0.9, alpha: 1)
                }
            }
        }
    }
    
    // MARK: UIViewController
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareQuestion(withId: questionId)
        self.title = topicName
        resultImageView.alpha = 0
        
        storeReply(questionId: 555, isCorrect: false)
    }
    
    // MARK - Private
    
    private func prepareQuestion(withId id: Int) {
        let question = Question.questionsFromBundle()[id - 1]
        questionLabel.text = question.description
        createVariantLabels()
        variantsStackView.isUserInteractionEnabled = true
        prepareButtons()
    }
    
    private func prepareButtons() {
        answerButton.isHidden = false
        if questionId == Question.questionsFromBundle().count {
            nextButton.isHidden = true
            finishButton.isHidden = false
        } else {
            nextButton.isHidden = false
            finishButton.isHidden = true
        }
    }
    
    private func createVariantLabels() {
        let question = Question.questionsFromBundle()[questionId - 1]
        variantsStackView.removeAllSubviews()
        for variantAnswer in question.variants {
            let variantLabel = UILabel()
            let tapGesture = UITapGestureRecognizer(target: self, action: #selector(QuestionViewController.variantTapped(_:)))
            variantLabel.addGestureRecognizer(tapGesture)
            variantLabel.text = variantAnswer.description
            variantLabel.numberOfLines = 0
            variantLabel.isUserInteractionEnabled = true
            variantLabel.backgroundColor = UIColor(white: 0.9, alpha: 1)
            variantsStackView.addArrangedSubview(variantLabel)
        }
    }
    
    func storeReply(questionId: NSNumber, isCorrect: Bool) {
        let context = getContext()
        
        let reply = Reply(context: context)
        reply.questionId = Int32(questionId)
        reply.isCorrect = isCorrect
        
        do {
            try context.save()
            print("saved!")
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        } catch { }
    }
    
    func getContext () -> NSManagedObjectContext {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        return appDelegate.persistentContainer.viewContext
    }
    
}

extension UIStackView {
    func removeAllSubviews() {
        for subview in self.subviews {
            self.removeArrangedSubview(subview)
        }
    }
}

extension UIColor {
    var rgbComponents:(red: CGFloat, green: CGFloat, blue: CGFloat, alpha: CGFloat) {
        var r:CGFloat = 0
        var g:CGFloat = 0
        var b:CGFloat = 0
        var a:CGFloat = 0
        if getRed(&r, green: &g, blue: &b, alpha: &a) {
            return (r,g,b,a)
        }
        return (0,0,0,0)
    }
    
    var htmlRGBColor:String {
        return String(format: "#%02x%02x%02x", Int(rgbComponents.red * 255), Int(rgbComponents.green * 255),Int(rgbComponents.blue * 255))
    }
}

