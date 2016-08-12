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
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        if let text = textField.text, regex = Regex(pattern: text) {
            highlightTextView(matching: regex)
        }
        return true
    }
    
    func highlightTextView(matching regex: Regex) {
        let attributedString = NSMutableAttributedString(string: exampleTextView.text)
        for range in exampleTextView.text.match(regex).ranges() {
            attributedString.addAttributes([NSFontAttributeName: UIFont.systemFontOfSize(14), NSBackgroundColorAttributeName: UIColor.redColor()], range: NSRange(location: exampleTextView.text.startIndex.distanceTo(range.startIndex), length: range.startIndex.distanceTo(range.endIndex)))
        }
        exampleTextView.attributedText = attributedString
    }
}
