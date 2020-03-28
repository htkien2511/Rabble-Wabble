//
//  ViewController.swift
//  Rabble Wabble
//
//  Created by Hoang Trong Kien on 3/28/20.
//  Copyright © 2020 Hoang Trong Kien. All rights reserved.
//

import UIKit

// MARK: - QuestionViewControllerDelegate
public protocol QuestionViewControllerDelegate: class {
    func questionViewController(_ viewController: QuestionViewController,
                                didCancel questionGroup: QuestionGroup,
                                at questionIndex: Int)
    func questionViewController(_ viewController: QuestionViewController,
                                didComplete questionGroup: QuestionGroup)
}

public class QuestionViewController: UIViewController {
    
    // MARK: - Instance Properties
    public var delegate: QuestionViewControllerDelegate?
    public var questionGroup: QuestionGroup! {
        didSet {
            navigationItem.title = questionGroup.title
        }
    }
    public var questionIndex = 0
    public var correctCount = 0
    public var incorrectCount = 0
    public var questionView: QuestionView! {
        guard isViewLoaded else {
            return nil
        }
        return (view as! QuestionView)
    }
    private lazy var questionIndexItem: UIBarButtonItem = {
        let item = UIBarButtonItem(title: "",
                                   style: .plain,
                                   target: nil,
                                   action: nil)
        item.tintColor = .black
        navigationItem.rightBarButtonItem = item
        return item
    }()
    
    // MARK: - View Lifecycle
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupCancelButton()
        showQuestion()
    }
    
    private func setupCancelButton() {
        let action = #selector(handleCancelPressed(sender:))
        let image = UIImage(named: "ic_menu")
        let barButtonItem = UIBarButtonItem(image: image,
                                            landscapeImagePhone: nil,
                                            style: .plain,
                                            target: self,
                                            action: action)
        navigationItem.leftBarButtonItem = barButtonItem
    }
    @objc private func handleCancelPressed(sender: UIBarButtonItem) {
        delegate?.questionViewController(self,
                                         didCancel: questionGroup,
                                         at: questionIndex)
    }
    
    private func showQuestion() {
        let question = questionGroup.questions[questionIndex]
        
        questionView.promptLabel.text = question.prompt
        questionView.hintLabel.text = question.hint
        questionView.answerLabel.text = question.answer
        
        questionView.answerLabel.isHidden = true
        questionView.hintLabel.isHidden = true
        
        questionIndexItem.title = "\(questionIndex + 1)/\(questionGroup.questions.count)"
    }
    
    // MARK: - Actions
    @IBAction func toggleAnswerLabels(_ sender: Any) {
        questionView.answerLabel.isHidden = !questionView.answerLabel.isHidden
        questionView.hintLabel.isHidden = !questionView.hintLabel.isHidden
    }
    
    @IBAction func handleIncorrect(_ sender: UIButton) {
        incorrectCount += 1
        questionView.incorrectCountLabel.text = "\(incorrectCount)"
        showNextQuestion()
    }
    @IBAction func handleCorrect(_ sender: UIButton) {
        correctCount += 1
        questionView.correctCountLabel.text = "\(correctCount)"
        showNextQuestion()
    }
    
    private func showNextQuestion() {
        questionIndex += 1
        guard questionIndex < questionGroup.questions.count else {
            delegate?.questionViewController(self, didComplete: questionGroup)
            return
        }
        showQuestion()
    }
}
