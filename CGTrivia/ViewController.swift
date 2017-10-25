//
//  ViewController.swift
//  CGTrivia
//
//  Created by Sain-R Edwards Jr. on 10/22/17.
//  Copyright © 2017 Appybuildmore Apps. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var answerStackView: UIStackView!
    
    var currentQuestion: Question?
    
    let model = QuizModel()
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Call get questions
        questions = model.getQuestions()
        
        // Check if there are questions
        if questions.count > 0 {
            
            currentQuestion = questions[0]
            
            // Display current question
            displayCurrentQuestion()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func displayCurrentQuestion() {
        
        if let actualCurrentQuestion = currentQuestion {
            
            // Set the question label
            questionLabel.text = actualCurrentQuestion.questionText
            
            // Create the answer buttons and place into scrollview
            createAnswerButtons()
            
        }
        
    }
    
    func createAnswerButtons() {
        
        if let actualCurrentQuestion = currentQuestion {
            
            for index in 0...actualCurrentQuestion.answers.count - 1 {
                
                // Create answer button
                let answerButton = AnswerButton()
                
                // Create a height constraint for it
                let heightConstraint = NSLayoutConstraint(item: answerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
                answerButton.addConstraint(heightConstraint)
                
                // Set the answer text
                answerButton.setAnswerText(answerText: actualCurrentQuestion.answers[index])
                
                // TODO: Create and attach a tapgestureRecognizer
                
                // Place the answer button into the stackview
                answerStackView.addArrangedSubview(answerButton)
                
            }
            
        }
        
    }

}

