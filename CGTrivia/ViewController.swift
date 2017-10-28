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
    
    // Feedback Screen
    @IBOutlet weak var dimView: UIView!
    @IBOutlet weak var resultLabel: UILabel!
    @IBOutlet weak var feedbackLabel: UILabel!
    @IBOutlet weak var resultButton: UIButton!
    
    var currentQuestion: Question?
    
    let model = QuizModel()
    var questions = [Question]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        // Hide feedback screen
        dimView.alpha = 0
        
        // Call get questions
        questions = model.getQuestions()
        
        // Check if there are questions
        if questions.count > 0 {
            
            currentQuestion = questions[1]
            
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
                answerButton.tag = index
                
                // Create a height constraint for it
                let heightConstraint = NSLayoutConstraint(item: answerButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 100)
                answerButton.addConstraint(heightConstraint)
                
                // Set the answer text
                answerButton.setAnswerText(answerText: actualCurrentQuestion.answers[index])
                
                // TODO: Create and attach a tapgestureRecognizer
                let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(answerTapped(gestureRecognizer:)))
                
                answerButton.addGestureRecognizer(gestureRecognizer)
                
                // Place the answer button into the stackview
                answerStackView.addArrangedSubview(answerButton)
                
            }
            
        }
        
    }
    
    @objc func answerTapped(gestureRecognizer: UITapGestureRecognizer) {
        
        // Detect which button was tapped
        if gestureRecognizer.view as? AnswerButton != nil {
            
            // We know that the UIView property is not nil and IS an answerButton object
            let answerButton = gestureRecognizer.view as! AnswerButton
            
            if answerButton.tag == currentQuestion?.correctAnswerIndex {
                // User got it correct
                resultLabel.text = "Correct!"
            }
            else {
                // User got it wrong
                resultLabel.text = "Wrong!"
            }
            
            // Set the feedback label
            feedbackLabel.text = currentQuestion?.category
            
            // TODO: Set the button text
            
            // Show the feedback screen
            dimView.alpha = 1
            
        }
    }
    @IBAction func resultButtonTapped(_ sender: Any) {
        
        // Remove the answer buttons
        for view in answerStackView.arrangedSubviews {
            view.removeFromSuperview()
        }
        
        // Determine what index the current question is within the questions array
        let indexOfCurrentQuestion = questions.index(of: currentQuestion!)
        
        if let actualIndex = indexOfCurrentQuestion {
            
            // Increment the index
            let nextIndex = actualIndex + 1
            
            
            // Check that it's within bounds of the question array
            if nextIndex < questions.count {
                
                // Set new current question
                currentQuestion = questions[nextIndex]
                
                // Display the next question
                displayCurrentQuestion()
                
                // Remove the dim view
                dimView.alpha = 0
                
            }
            
        }

    }
    
}


