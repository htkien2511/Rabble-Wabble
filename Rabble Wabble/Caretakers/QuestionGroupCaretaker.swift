//
//  QuestionGroupCatetaker.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 4/2/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

public final class QuestionGroupCaretaker {
    // MARK: - Properties
    private let fileName = "QuestionGroupData"
    public var questionGroups: [QuestionGroup] = []
    public var selectedQuestionGroup: QuestionGroup!
    
    // MARK: - Object Lifecycle
    public init() {
        loadQuestionGroup()
    }
    
    private func loadQuestionGroup() {
        if let questionGroups =
            try? DiskCaretaker.retrieve([QuestionGroup].self,
                                        from: fileName) {
            self.questionGroups = questionGroups
        } else {
            let bundle = Bundle.main
            let url = bundle.url(forResource: fileName, withExtension: "json")!
            self.questionGroups =
                try! DiskCaretaker.retrieve([QuestionGroup].self,
                                            from: url)
            try! save()
        }
    }
    
    // MARK: - Instance Methods
    public func save() throws {
        try DiskCaretaker.save(questionGroups, to: fileName)
    }
}
