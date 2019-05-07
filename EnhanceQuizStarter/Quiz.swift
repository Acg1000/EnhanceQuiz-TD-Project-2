//
//  QuestionProvider.swift
//  EnhanceQuizStarter
//
//  Created by Andrew Graves on 5/1/19.
//  Copyright © 2019 Treehouse. All rights reserved.
//

import Foundation
import GameKit


// Structure for storing and returning random questions
struct Quiz {
    // question collection using the Question Struct
    let questions = [
        Question(question: "This was the only US President to serve more than two consecutive terms." , possibleAnswers: ["George Washington", "Woodrow Wilson", "Andrew Jackson", "Franklin D. Roosevelt"], correctAnswer: 3),
        Question(question: "Which of the following countries has the most residents?", possibleAnswers: ["Nigeria","Russia","Iran"], correctAnswer: 0),
        Question(question: "In what year was the United Nations founded?", possibleAnswers: ["1919","1945","1954"], correctAnswer: 1),
        Question(question: "The Titanic departed from the United Kingdom, where was it supposed to arrive?", possibleAnswers: ["Paris","Washington D.C.","New York City","Boston"], correctAnswer: 2),
        Question(question: "Which nation produces the most oil?", possibleAnswers: ["Iran","Brazil","Canada"], correctAnswer: 2),
        Question(question: "Which country has most recently won consecutive World Cups in Soccer?", possibleAnswers: ["Italy","Brazil","Argetina","Spain"], correctAnswer: 1),
        Question(question: "Which of the following rivers is longest?", possibleAnswers: ["Yangtze","Mississippi","Congo"], correctAnswer: 1),
        Question(question: "Which city is the oldest", possibleAnswers: ["Mexico City","Cape Town","San Jose","Sydney"], correctAnswer: 0),
        Question(question: "Which country was the first to allow women to vote in national elections?", possibleAnswers: ["Poland","United States","Sweden","Sengal"], correctAnswer: 0),
        Question(question: "Which of these countries won the most medals in the 2012 Summer Games?", possibleAnswers: ["France","Germany","Japan","Great Britan"], correctAnswer: 3)
        
    ]
}

