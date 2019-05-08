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
    
    // Global Vars
    let questionsPerRound = 4
    var questionsAsked = 0
    var correctQuestions = 0
    var gameManager = GameManager()
    var soundManager = SoundManager()
    var isTimerOn = false
    
    
    // Outlets
    @IBOutlet weak var timerField: UILabel!
    @IBOutlet weak var questionField: UILabel!
    @IBOutlet weak var button1: UIButton!
    @IBOutlet weak var button2: UIButton!
    @IBOutlet weak var button3: UIButton!
    @IBOutlet weak var button4: UIButton!
    @IBOutlet weak var playAgainButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        displayQuestion()
        loadGameSounds()
        soundManager.playStartSound()
    }
    
    // Load all the game sounds from SoundManager
    func loadGameSounds() {
        soundManager.loadStartSound()
        soundManager.loadCorrectSound()
        soundManager.loadIncorrectSound()
        print("Sounds have been loaded")
    }

    
    func displayQuestion() {
        
        //Changed the question getting stuff to be different
        // Get the first set of questions
        let currentRound = gameManager.currentRound
        let question = gameManager.questions[currentRound].question
        let answers = gameManager.questions[currentRound].possibleAnswers
        
        // Set the button background color back to the normal color
        button1.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button2.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button3.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        button4.backgroundColor = UIColor(red: 0.204, green: 0.471, blue: 0.576, alpha: 1.00)
        
        // Allows them to be clicked
        button1.isEnabled = true
        button2.isEnabled = true
        button3.isEnabled = true
        button4.isEnabled = true
        
        // Sets the label to display the question
        questionField.text = question
        timerField.text = "15"
        
        // Sets the buttons to display the possible answers
        button1.setTitle(answers[0], for: .normal)
        button2.setTitle(answers[1], for: .normal)
        button3.setTitle(answers[2], for: .normal)
        
        playAgainButton.isHidden = true
        
        // If there are 3 possible answers
        if gameManager.questions[currentRound].possibleAnswers.count == 3 {
            
            // Hide the fourth button
            button4.isHidden = true
            
        // if there are 4 possible answers
        } else if gameManager.questions[currentRound].possibleAnswers.count == 4 {
            
            // Set the fourth button title and unhide the 4th button
            button4.setTitle(answers[3], for: .normal)
            button4.isHidden = false
        }
        // Start the 15 second timer
//        beginRoundCounter(currentRound: currentRound)
        isTimerOn = true
        roundTimer(currentRound: currentRound, withTimerOf: 15)
    }
    
    // Allows the main timer to function
    func roundTimer(currentRound: Int, withTimerOf time: Int) {
        var counter = time
        // Converts a delay in seconds to nanoseconds as signed 64 bit integer
        let delay = Int64(NSEC_PER_SEC * UInt64(1))
        // Calculates a time value to execute the method given current time and delay
        let dispatchTime = DispatchTime.now() + Double(delay) / Double(NSEC_PER_SEC)
        
        // Executes the nextRound method at the dispatch time on the main queue
        DispatchQueue.main.asyncAfter(deadline: dispatchTime) {
            if self.isTimerOn {
                // when the counter runs to 0
                if counter == 0 {
                    
                    // if the
                    if currentRound == self.gameManager.currentRound {
                        
                        self.button1.isEnabled = false
                        self.button2.isEnabled = false
                        self.button3.isEnabled = false
                        self.button4.isEnabled = false
                        
                        self.questionField.text = "You are out of time! Next Question"
                        self.loadNextRound(delay: 3)
                        
                    } else {
                        // Do nothing, the timer does not apply to this round
                    }
                } else {
                    
                    if currentRound == self.gameManager.currentRound {
                        counter -= 1
                        self.timerField.text = "\(counter)"
                        print(counter)
                        self.roundTimer(currentRound: currentRound, withTimerOf: counter)
                    } else {
                        // Do nothing, the timer does not apply to this round
                    }
                }
            }
        }
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
        
        timerField.isHidden = true
        
        // Change the text
        questionField.text = "You finished with a score of \(gameManager.score) out of \(gameManager.questions.count)"
        
        // Reveal a button that starts the button again
        playAgainButton.isHidden = false

    }
    
    // MARK: - Actions
    
    // Move this to the inside of Game Manager
    @IBAction func checkAnswer(_ sender: UIButton) {
        let currentRound = gameManager.currentRound
        let selectedAnswer = sender.title(for: .normal)
        let isCorrect = gameManager.checkAnswer(selectedAnseer: selectedAnswer!, currentRound: currentRound)
        
        // Disables the buttons so they can not be clicked again
        self.button1.isEnabled = false
        self.button2.isEnabled = false
        self.button3.isEnabled = false
        self.button4.isEnabled = false
        isTimerOn = false
        
        
        if isCorrect {
            
            // Set Button Color
            sender.backgroundColor = UIColor(red: 0.675, green: 0.839, blue: 0.506, alpha: 1.00)
            
            // Change the score
            gameManager.isCorrect()
            
            // Load next round
            loadNextRound(delay: 2)
            
            // Play sounds
            soundManager.playCorrectSound()
            
        } else {
            
            // Change Button Color
            sender.backgroundColor = UIColor(red: 0.486, green: 0.239, blue: 0.220, alpha: 1.00)
            
            // Change Text information to show correct answer
            questionField.text = "The correct answer is \(gameManager.questions[currentRound].getCorrectAnswer())"
            
            //Load the next round
            loadNextRound(delay: 2)
            
            //Play Sounds
            soundManager.playIncorrectSound()
            
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
        displayQuestion()
    }
}

