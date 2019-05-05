//
//  ViewController.swift
//  EnhanceQuizStarter
//
//  Created by Pasan Premaratne on 3/12/18.
//  Copyright © 2018 Treehouse. All rights reserved.
//

import UIKit
import GameKit
import AudioToolbox

class ViewController: UIViewController {
    
    // MARK: - Properties
    
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var indexOfSelectedQuestion = 0
    var gameManager = GameManager()
    
    var gameSound: SystemSoundID = 0
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
//        loadGameStartSound()
//        playGameStartSound()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameStartSound() {
        let path = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl = URL(fileURLWithPath: path!)
        AudioServicesCreateSystemSoundID(soundUrl as CFURL, &gameSound)
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    
    
    func displayQuestion() {
        
        //Changed the question getting stuff to be different
        // Get the first set of questions
        let currentRound = gameManager.currentRound
        let question = gameManager.questions[currentRound].question
        let answers = gameManager.questions[currentRound].possibleAnswers
        
        //Set all the colors back to their normal colors
        button1.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button2.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button3.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button4.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        
        // Setting all the strings to their respective labels and buttons
        questionField.text = question
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        button4.setTitle(answers[3], for: .normal)
        
        playAgainButton.isHidden = true
    }
    
    func displayScore() {
        
        // Display play again button
        playAgainButton.isHidden = false
        
        questionField.text = "Way to go!\nYou got \(correctQuestions) out of \(questionsPerRound) correct!"
    }
    
    func nextRound() {
        gameManager.incrementRound()

        // check if the round # is = to the number of questions
        if gameManager.currentRound == gameManager.questions.count {
            
            finishGame()
//            view.backgroundColor = UIColor(red: 0.937, green: 0.514, blue: 0.690, alpha: 1.00)
//            questionField.text = "FINISHED"
        } else {
            
            // Adds one to the round number and loads the next questions
            displayQuestion()
        }
    }
    
    // Adds delay to the loading of the next round
    func loadNextRound(delay seconds: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(seconds))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            self.nextRound()
        }
    }
    
    func finishGame() {
        // Hide the buttons
        button1.isHidden = true
        button2.isHidden = true
        button3.isHidden = true
        button4.isHidden = true
        
        // Change the text
        questionField.text = "You finished with a score of \(gameManager.score)"
        
        // Reveal a button that starts the button again
        playAgainButton.isHidden = false

    }
    
    // MARK: - Actions
    
    @IBAction func checkAnswer(_ sender: UIButton) {
        let currentRound = gameManager.currentRound
        let correctAnswer = gameManager.questions[currentRound].getCorrectAnswer()
        
        if sender.title(for: .normal) == correctAnswer {
            // The answer is correct
            // Play correct noise
            // Change color of sender to green
            gameManager.score += 1
            sender.backgroundColor = UIColor(red: 0.675, green: 0.839, blue: 0.506, alpha: 1.00)
            loadNextRound(delay: 2)

        } else {
            // The answer is wrong
            // Play incorrect noise
            // Change color of sender to red and correct button to green
            sender.backgroundColor = UIColor(red: 0.486, green: 0.239, blue: 0.220, alpha: 1.00)
            loadNextRound(delay: 2)

        }
    }
    
    
    @IBAction func playAgain(_ sender: UIButton) {
        // Show the answer buttons
        button1.isHidden = false
        button2.isHidden = false
        button3.isHidden = false
        button4.isHidden = false

        // COMPLETLY RESET THE GAME MANAGER
        gameManager.resetGame()
        nextRound()
    }
}

