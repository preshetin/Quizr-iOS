//
//  ViewController.swift
//  TempTry_1
//
//  Created by Petr Reshetin on 20/10/2016.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import UIKit

class QuestionViewController: UIViewController {
    
    let question = Question.questionsFromBundle()[1]
    var selectedVariant: Variant? = nil
    var topicName: String?
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var variantsStackView: UIStackView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        questionLabel.text = question.description
        createVariantLabels()
        self.title = topicName
    }
    
    @IBAction func applyQuestion() {
        switch selectedVariant {
        case .none:
            print("Please choose variant")
        case .some(let variant):
            print("\(variant.isCorrect)")
        }
    }
    
    func variantTapped(_ gestureRegognizer: UIGestureRecognizer) {
        let label = gestureRegognizer.view as! UILabel
        switch (label.backgroundColor?.htmlRGBColor)! {
        case "#ffff00":
            label.backgroundColor = UIColor(white: 0.9, alpha: 1)
            selectedVariant = nil
        case "#e5e5e5":
            label.backgroundColor = UIColor.yellow
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
    
    private func createVariantLabels() {
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

