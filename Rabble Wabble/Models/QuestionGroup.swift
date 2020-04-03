//
//  QuestionGroup.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 3/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

public class QuestionGroup: Codable {
    
    public class Score: Codable {
        public var correctCount: Int = 0
        public var incorrectCount: Int = 0
        public init() {}
    }
    
    public let questions: [Question]
    public var score: Score
    public let title: String
    
    public init(questions: [Question],
                score: Score = Score() ,
                title: String) {
        self.questions = questions
        self.score = score
        self.title = title
    }
}

