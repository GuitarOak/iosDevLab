//
//  StartViewController.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-23.
//

import UIKit

class StartViewController: UIViewController {

    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var numberOfQuestionsTextField: UITextField!
    
    var questions: [Question] = []
    var difficulty = "medium"
    var numberOfQuestionsFromUser = ""
    override func viewDidLoad() {
        super.viewDidLoad()

        startButton.isEnabled = false
        
        //downloadQuestions()
    }
    
    @IBAction func easyButtonHandler(_ sender: Any) {
        difficulty = "easy"
        print(difficulty)
    }
    
    @IBAction func mediumButtonHandler(_ sender: Any) {
        difficulty = "medium"
        print(difficulty)
    }
    
    @IBAction func hardButtonHandler(_ sender: Any) {
        difficulty = "hard"
        print(difficulty)
    }
    
    @IBAction func numberOfQuestionsTextFieldDidChange(_ sender: Any) {
        numberOfQuestionsFromUser = numberOfQuestionsTextField.text!
        if numberOfQuestionsFromUser != "" {
            downloadQuestions()
        }else{
            let alertController = UIAlertController(title: "Incorrect input", message: "Enter a number", preferredStyle: UIAlertController.Style.alert)
            alertController.addAction(UIAlertAction(title: "Will do!", style: UIAlertAction.Style.default, handler: { _ in
                
                
            }))
            present(alertController, animated: true, completion: nil)
        }
    }
    @IBAction func highscoreButtonHandler(_ sender: Any) {
        let highscoreTableViewController = HighscoreTableViewController()
        navigationController?.pushViewController(highscoreTableViewController, animated: true)
    }
    private func downloadQuestions(){
        
        guard let url = URL(string: "https://opentdb.com/api.php?amount=\(numberOfQuestionsFromUser )&category=12&difficulty=\(difficulty)&type=multiple")
        else {
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { [weak self] (data, _, error) in
            guard let data = data else {
                print(error)
                return
            }
            
            //print(String(data: data, encoding: .utf8))
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            let questionsResult = try? decoder.decode(QuestionsResult.self, from: data)
            self?.questions = questionsResult?.results ?? []
            
            DispatchQueue.main.async {
                self?.startButton.isEnabled = true
            }
        }
        task.resume()
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let questionViewController = segue.destination as? QuestionViewController{
            /*let question1 = Question(category: "Food", type: .multiple, difficulty: .easy, question: "What is my favorite food?", correctAnswer: "Tacos", incorrectAnswers: ["Rice", "Rock", "Chair"])
            let question2 = Question(category: "Animals", type: .multiple, difficulty: .easy, question: "Which is a mammal?", correctAnswer: "Human", incorrectAnswers: ["Cucumber", "iPhone", "Birdy bird"])
            let questions = [question1, question2]*/
            questionViewController.numberOfQuestions = questions.count
            questionViewController.questions = questions
        }
        
    }   

}
