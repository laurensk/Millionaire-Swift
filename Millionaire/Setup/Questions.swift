//
//  Questions.swift
//  Millionaire
//
//  Created by Laurens on 19.10.19.
//  Copyright © 2019 Laurens K. All rights reserved.
//

import Foundation

struct QuestionAnswers {
    
    let id: Int
    let answer: String
    
}


struct Question {
    
    let id: Int
    let question: String
    var answers: [QuestionAnswers]
    let correctAnswer: Int
    
}


let questions: [Question] = [
    
    Question(id: 0, question: "Wie viele Schüler/innen besuchen die HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "50 Schüler/innen"), QuestionAnswers(id: 1, answer: "100 Schüler/innen"), QuestionAnswers(id: 2, answer: "500 Schüler/innen"), QuestionAnswers(id: 3, answer: "1000 Schüler/innen")], correctAnswer: 3),
    Question(id: 1, question: "Wie viele Lehrer unterrichten an der HTBLA Kaindorf?", answers: [QuestionAnswers(id: 0, answer: "20 Lehrer/innen"), QuestionAnswers(id: 1, answer: "80 Lehrer/innen"), QuestionAnswers(id: 2, answer: "100 Lehrer/innen"), QuestionAnswers(id: 3, answer: "200 Lehrer/innen")], correctAnswer: 2),
    Question(id: 2, question: "Habe ich zum Erstellen dieser App ein Flussdiagramm bzw. ein Struktogramm verwendet?", answers: [QuestionAnswers(id: 0, answer: "Sogar beide"), QuestionAnswers(id: 1, answer: "Ja"), QuestionAnswers(id: 2, answer: "Was ist das?"), QuestionAnswers(id: 3, answer: "Nein")], correctAnswer: 2),
    Question(id: 3, question: "Finden Sie diese App toll?", answers: [QuestionAnswers(id: 0, answer: "Nein"), QuestionAnswers(id: 1, answer: "Nein"), QuestionAnswers(id: 2, answer: "Nein"), QuestionAnswers(id: 3, answer: "Ja")], correctAnswer: 3),
    Question(id: 3, question: "Werden Sie all Ihren Freunden von dieser App erzählen?", answers: [QuestionAnswers(id: 0, answer: "Ja, ich rufe gleich an"), QuestionAnswers(id: 1, answer: "Ja, über Facebook"), QuestionAnswers(id: 2, answer: "Ja, ich besuche heute alle"), QuestionAnswers(id: 3, answer: "Nein")], correctAnswer: 3)

]
