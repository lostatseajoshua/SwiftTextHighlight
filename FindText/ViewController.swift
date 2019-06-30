//
//  ViewController.swift
//  FindText
//
//  Created by Joshua Alvarado on 7/31/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit
import SwiftExpression

class ViewController: UIViewController, UITextFieldDelegate {
    @IBOutlet weak var exampleTextView: UITextView!
    @IBOutlet weak var inputTextField: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        inputTextField.delegate = self
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, let regex = Regex(pattern: text) {
            highlightTextView(matching: regex)
        }
        return true
    }
    
    func highlightTextView(matching regex: Regex) {
        guard let text = exampleTextView.text else {
            return
        }
        
        let attributedString = NSMutableAttributedString(string: text)
        let ranges = text.match(regex).ranges()
        
        ranges.forEach {
            let location = text.distance(from: text.startIndex, to: $0.lowerBound)
            let length = text.distance(from: $0.lowerBound, to: $0.upperBound)
            let range = NSRange(location: location, length: length)
            
          attributedString.addAttributes([NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14), NSAttributedString.Key.foregroundColor: UIColor.white, NSAttributedString.Key.backgroundColor: UIColor.purple], range: range)
        }
        
        exampleTextView.attributedText = attributedString
    }
}

