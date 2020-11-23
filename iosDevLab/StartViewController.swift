//
//  StartViewController.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-23.
//

import UIKit

class StartViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController{
            let question1 = Question(category: "Food", type: .multiple, difficulty: .easy, question: "What is my favorite food?", correctAnswer: "Tacos", incorrectAnswers: ["Rice", "Rock", "Chair"])
            let question2 = Question(category: "Animals", type: .multiple, difficulty: .easy, question: "Which is a mammal?", correctAnswer: "Human", incorrectAnswers: ["Cucumber", "iPhone", "Birdy bird"])
            let questions = [question1, question2]
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
        }
        
    }   

}
