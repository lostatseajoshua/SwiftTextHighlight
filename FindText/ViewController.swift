//
//  ViewController.swift
//  FindText
//
//  Created by Joshua Alvarado on 7/31/16.
//  Copyright © 2016 Joshua Alvarado. All rights reserved.
//

import UIKit
import SwiftExpression

class ViewController: UIViewController {
    @IBOutlet weak var exampleTextView: UITextView!
    @IBOutlet weak var outputTextView: UITextView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        dispatch_async(dispatch_get_main_queue()) {
            if let exampleText = self.exampleTextView.text {
                let regexWords = Regex(pattern: "(a|e|i|o|u)+")
                self.exampleTextView.attributedText = self.highlight(exampleText, matching: regexWords)
            }
        }
    }
    
    func highlight(text: String, matching regex: Regex) -> NSAttributedString {
        let attributedString = NSMutableAttributedString(string: text)
        for (_, (_, range)) in text.match(regex).components.enumerate() {
            attributedString.addAttributes([NSBackgroundColorAttributeName: UIColor.yellowColor()], range: NSRange(location: text.startIndex.distanceTo(range.startIndex), length: range.startIndex.distanceTo(range.endIndex)))
        }
        return attributedString
    }
}
