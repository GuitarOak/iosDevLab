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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        [buttonAnswerA, buttonAnswerB, buttonAnswerC, buttonAnswerD].forEach { (button) in
            button?.layer.cornerRadius = 20
        }

        questionLabel.layer.cornerRadius = 20
        // Do any additional setup after loading the view.
    }
    
    @IBAction func buttonAnswerAHandler(_ sender: Any) {
        print("Fish")
        showWrongAnswerAlert(button: buttonAnswerA)
    }
    
    @IBAction func buttonAnswerBHandler(_ sender: Any) {
        print("Steak")
        showWrongAnswerAlert(button: buttonAnswerB)
    }
    
    @IBAction func buttonAnswerCHandler(_ sender: Any) {
        print("Tacos")
        showRightAnswerAlert(button: buttonAnswerC)
    }
    
    @IBAction func buttonAnswerDHandler(_ sender: Any) {
        print("Pizza")
        showWrongAnswerAlert(button: buttonAnswerD)
    }
    
    private func showRightAnswerAlert(button: UIButton){
        button.backgroundColor = .green
        let alertController = UIAlertController(title: "CORRECT", message: "Well played, sir! Well played", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "N I C E", style: UIAlertAction.Style.default, handler: { (_) in
            alertController.dismiss(animated: true, completion: nil)
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    private func showWrongAnswerAlert(button: UIButton){
        button.backgroundColor = .red
        buttonAnswerC.backgroundColor = .green
        let alertController = UIAlertController(title: "WRONG", message: "Maybe next time...", preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Oh no...", style: UIAlertAction.Style.default, handler: { (_) in
            self.navigationController?.popViewController(animated: true)
            alertController.dismiss(animated: true, completion: nil)
            
        }))
        present(alertController, animated: true, completion: nil)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
