//
//  Question.swift
//  TempTry_1
//
//  Created by Petr Reshetin on 21/10/2016.
//  Copyright © 2016 Petr Reshetin. All rights reserved.
//

import Foundation

struct Question {
    var description: String
    var variants: [Variant]
    
    func findVariantByText(text: String) -> Variant? {
        for variant in variants {
            if variant.description == text {
                return variant
            }
        }
        return nil
    }
    
    static func questionsFromBundle() -> [Question] {
        
        var questions = [Question]()
        
        guard let url = Bundle.main.url(forResource: "questions", withExtension: "json") else {
            return questions
        }
        
        do {
            let data = try Data(contentsOf: url)
            guard let rootObject = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String : Any]  else {
                return questions
            }
            
            guard let questionObjects = rootObject["questions"] as? [[String: AnyObject]] else {
                return questions
            }
            
            for questionObject in questionObjects {
                if let description = questionObject["description"] as? String,
                    let variantsObject = questionObject["variants"] as? [[String : Any]]{
                    var variants = [Variant]()
                    for variantObject in variantsObject {
                        if let variantTitle = variantObject["description"] as? String,
                            let isCorrect = variantObject["is_correct"] as? Bool {
                            variants.append(Variant(description: variantTitle, isCorrect: isCorrect))
                        }
                    }
                    
                    let question = Question(description: description, variants: variants)
                    questions.append(question)
                }
            }
        } catch {
            return questions
        }
        
        return questions
    }
    
}

