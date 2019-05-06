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
    var gameManager = GameManager()
    
    var gameSound: SystemSoundID = 0
    var correctSound: SystemSoundID = 1
    var incorrectSound: SystemSoundID = 2
    
    // MARK: - Outlets
    
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadGameSounds()
        displayQuestion()
    }
    
    // MARK: - Helpers
    
    func loadGameSounds() {
        let path1 = Bundle.main.path(forResource: "GameSound", ofType: "wav")
        let soundUrl1 = URL(fileURLWithPath: path1!)
        AudioServicesCreateSystemSoundID(soundUrl1 as CFURL, &gameSound)
        
        let path2 = Bundle.main.path(forResource: "CorrectSound", ofType: "wav")
        let soundUrl2 = URL(fileURLWithPath: path2!)
        AudioServicesCreateSystemSoundID(soundUrl2 as CFURL, &correctSound)

        let path3 = Bundle.main.path(forResource: "IncorrectSound", ofType: "wav")
        let soundUrl3 = URL(fileURLWithPath: path3!)
        AudioServicesCreateSystemSoundID(soundUrl3 as CFURL, &incorrectSound)
        
        playGameStartSound()
    }
    
    func playGameStartSound() {
        AudioServicesPlaySystemSound(gameSound)
    }
    
    func playWrongSound() {
        AudioServicesPlaySystemSound(correctSound)

    }
    
    func playRightSound() {
        AudioServicesPlaySystemSound(incorrectSound)

    }
    
    
    
    func displayQuestion() {
        
        //Changed the question getting stuff to be different
        // Get the first set of questions
        let currentRound = gameManager.currentRound
        let question = gameManager.questions[currentRound].question
        let answers = gameManager.questions[currentRound].possibleAnswers
        
        button1.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button2.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button3.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button4.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        
        questionField.text = question
        
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        
        playAgainButton.isHidden = true
        
        if gameManager.questions[currentRound].possibleAnswers.count == 3 {
            
            // Hide the fourth button
            button4.isHidden = true
            
        } else if gameManager.questions[currentRound].possibleAnswers.count == 4 {
            
            // Set the fourth button title and unhide the 4th button
            button4.setTitle(answers[3], for: .normal)
            button4.isHidden = false
        }
        beginRoundCounter(currentRound: currentRound)
    }
    
    // 15 Second Round Counter
    func beginRoundCounter(currentRound: Int) {
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(15))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            if currentRound == self.gameManager.currentRound {
                // Time has expired
                self.button1.isEnabled = false
                self.button2.isEnabled = false
                self.button3.isEnabled = false
                self.button4.isEnabled = false
                
                self.questionField.text = "You are out of time! Next Question"
                self.loadNextRound(delay: 3)
            } else {
                //Time has not expired do nothing
            }
        }
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
    
    // Move this to the inside of Game Manager
    @IBAction func checkAnswer(_ sender: UIButton) {
        let currentRound = gameManager.currentRound
        let correctAnswer = gameManager.questions[currentRound].getCorrectAnswer()
        
        // OLD CODE
        if sender.title(for: .normal) == correctAnswer {
            
            // Set Button Color
            sender.backgroundColor = UIColor(red: 0.675, green: 0.839, blue: 0.506, alpha: 1.00)
            
            // Change the score
            gameManager.isCorrect()
            
            // Load next round
            loadNextRound(delay: 2)
            
            // Play sounds
            playRightSound()

        } else {
            
            // Change Button Color
            sender.backgroundColor = UIColor(red: 0.486, green: 0.239, blue: 0.220, alpha: 1.00)
            
            // Change Text information to show correct answer
            questionField.text = "The correct answer is \(gameManager.questions[currentRound].getCorrectAnswer())"
            
            //Load the next round
            loadNextRound(delay: 2)
            
            //Play Sounds
            playWrongSound()
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

