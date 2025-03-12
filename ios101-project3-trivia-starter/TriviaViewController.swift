//
//  TriviaViewController.swift
//  Trivia
//
//  Created by Ya-chen Hsieh on 3/11/25.
//

import UIKit

class TriviaViewController: UIViewController {

    @IBOutlet weak var QNumberLabel: UILabel!
    @IBOutlet weak var contentLabel: UITextView!
    @IBOutlet weak var catagoryLabel: UILabel!
    
    @IBOutlet weak var ALabel: UIButton!
    @IBOutlet weak var BLabel: UIButton!
    @IBOutlet weak var CLabel: UIButton!
    @IBOutlet weak var DLabel: UIButton!
    
    
    // Add fucntion for button Tap
    @IBAction func didTapButton(_ sender: UIButton) {
        print("Tapped：\(sender.currentTitle ?? "unknow")")
        
        guard let selectedAnswer = sender.currentTitle else {
            return // if currentTitle is nil -> stop the function
        }
        
        let isCorrect = selectedAnswer == trevias[currentQuestionIndex].correctanswer
        if isCorrect {
            correctanswers += 1
        }
        
        // If is the last question
        if currentQuestionIndex == trevias.count - 1 {
            let alert = UIAlertController(
                            title: "Quiz Complete!",
                            message: "Your final score: \(correctanswers)/\(trevias.count)",
                            preferredStyle: .alert
                        )
            
            // Add actions to the alert
            // Create Play Again button in alart
            let restartAction = UIAlertAction(title: "Play Again", style: .default) { [weak self] _ in
                self?.resetQuiz() // use weak self to avoid retain cycel : TriviaViewController ➝ UIAlertController ➝ Closure (self) ➝ TriviaViewController
            }
            
            // Create close button in alart
            let dismissAction = UIAlertAction(title: "Close", style: .cancel)
            
            // Add 2 bottons in alart
            alert.addAction(restartAction)
            alert.addAction(dismissAction)
            
            // Display
            present(alert, animated: true)
        }
        // Not the last question
        else {
            // Tap then move to the next
            currentQuestionIndex += 1
            configure(with: trevias[currentQuestionIndex]) //
        }
        
        
    }
    
    // init the var
    private var trevias = [Question]() // track all posstible questions
    private var currentQuestionIndex = 0 //tracks which question is being shown, default to 0
    private var correctanswers = 0 // track how many answers are correct
    
    
    override func viewDidLoad() {
        // vision
        super.viewDidLoad()
        contentLabel.textAlignment = .center  // make the UITextView word center
        
        // Do any additional setup after loading the view.
        trevias = createMockQuestion()
        configure(with:trevias[currentQuestionIndex])
        
    }
    

    private func createMockQuestion() -> [Question] {
        let Q1 = Question(
            category: "music",
            text: "Who is known as the KING OF POP?",  // question content
            options:["Michael Jackson", "Bruno Mars", "khalid", "BTS"], // options
            correctanswer:"Michael Jackson" // answer
            )
        
        let Q2 = Question(
            category: "music",
            text: "Who sang the 1990 hit Vogue?",  // question content
            options:["Adele", "Madonna", "Taylor Swift", "Miley Cyrus"], // options
            correctanswer:"Madonna" // answer
            )
        
        let Q3 = Question(
            category: "chem",
            text: "What is the chemical formula for water?",  // question content
            options:["H2O", "CO2", "O3", "H2"], // options
            correctanswer:"H2O"
            )
        
        let Q4 = Question(
            category: "history",
            text: "In what year did World War II end?",  // question content
            options:["1914", "1918", "1939", "1945"], // options
            correctanswer:"1945"
            )
        
        return [Q1, Q2, Q3, Q4]
        
        
        
    } // private createMock
    
    private func configure(with q: Question) {
        QNumberLabel.text = "Question \(currentQuestionIndex + 1)/\(trevias.count)" // Show progress like "Question 1/4"
        catagoryLabel.text = "Category: \(q.category)"
        contentLabel.text = q.text
        
        // Display buttons correctly
        ALabel.setTitle(q.options[0], for: .normal)
        BLabel.setTitle(q.options[1], for: .normal)
        CLabel.setTitle(q.options[2], for: .normal)
        DLabel.setTitle(q.options[3], for: .normal)

        
    }
    
    // reset the game
    private func resetQuiz() {
        // Reset to first question
        currentQuestionIndex = 0
        // Reset the score
        correctanswers = 0
        // Configure the first question
        configure(with: trevias[0])
    }

}
