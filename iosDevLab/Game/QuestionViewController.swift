//
//  QuestionViewController.swift
//  iosDevLab
//
//  Created by Emil Karlsson on 2020-11-21.
//

import UIKit

class QuestionViewController: UIViewController {

    @IBOutlet weak var buttonAnswerA: UIButton!
    @IBOutlet weak var buttonAnswerB: UIButton!
    @IBOutlet weak var buttonAnswerC: UIButton!
    @IBOutlet weak var buttonAnswerD: UIButton!
    
    @IBOutlet weak var questionLabel: UILabel!
    
    var questions: [Question] = [] {
        didSet{
            question = questions.removeFirst()
        }
    }
    var question: Question?
    var numberOfQuestions = 0
    var rightAnswers = 0
    
    private let gameResultDatabaseManager = GameResultDatabaseManager()
    private var haveWon = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        navigationItem.hidesBackButton = true
        
        //Cofnigure of question label
        questionLabel.clipsToBounds = true
        questionLabel.layer.cornerRadius = 20
        
        var buttons = [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD]
       buttons.forEach { (button) in
            button?.layer.cornerRadius = 20
        }
        
        questionLabel.text = question?.question.htmlDecoded
        buttons.shuffle()
        let correctButton = buttons.removeFirst()
        correctButton?.setTitle(question?.correctAnswer.htmlDecoded, for: .normal)
        
        question?.incorrectAnswers.forEach({ (answer) in
            let button = buttons.removeFirst()
            button?.setTitle(answer.htmlDecoded, for: .normal)
        })
        
    }
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        correctClicked(button: buttonAnswerA)
    }
    
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        correctClicked(button: buttonAnswerB)
    }
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        correctClicked(button: buttonAnswerC)
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        correctClicked(button: buttonAnswerD)
    }
    
    
    private func correctClicked(button: UIButton){
        if button.title(for: .normal) == question?.correctAnswer {
            showRightAnswerAlert(button: button)
        }else{
            showWrongAnswerAlert(button: button)
        }
    }
    
    private func showRightAnswerAlert(button: UIButton){
        haveWon = true
        rightAnswers += 1
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "CORRECT", message: "Well played, sir! Well played", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "N I C E", style: UIAlertAction.Style.default, handler: { [weak self](_) in
            self?.goToNextScreen()
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showWrongAnswerAlert(button: UIButton){
        haveWon = false
        button.backgroundColor = .red
        let alertController = UIAlertController(title: "WRONG", message: "Maybe next time...", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Oh no...", style: UIAlertAction.Style.default, handler: { [weak self] (_) in
            self?.goToNextScreen()
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func goToNextScreen(){
        guard questions.isEmpty == false,
              let questionViewController = storyboard?.instantiateViewController(withIdentifier: "QuestionViewController") as? QuestionViewController
        else {
            saveGameResult()
            performSegue(withIdentifier: "ResultView", sender: nil)
            return
        }
        
        questionViewController.numberOfQuestions = numberOfQuestions
        questionViewController.rightAnswers = rightAnswers
        questionViewController.questions = questions
        navigationController?.pushViewController(questionViewController, animated: true)
    }
    
    // MARK: - Saving the result
    
    private func saveGameResult() {
        
        if gameResultDatabaseManager.create(withNumberOfQuestions: numberOfQuestions, andRightAnswers: rightAnswers) != nil{
            
            gameResultDatabaseManager.save()
        }
        
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let resultViewController = segue.destination as? ResultViewController {
            resultViewController.resultView.resultLabel.text = haveWon ? "🥳 You answered \(rightAnswers) questions correct out of \(numberOfQuestions) questions!" : "😭"
        }
    }

}
