//
//  TextSnippetEntryViewController.swift
//  Snippets
//
//  Created by Jak Tiano on 8/7/16.
//  Copyright © 2016 PacktPub. All rights reserved.
//

import Foundation
import UIKit

class TextSnippetEntryViewController: UIViewController {
    
    @IBOutlet weak var textView: UITextView!
    var shouldExit = false
    
    var saveText: (_ text: String) -> Void = { (text:String) in }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textView.inputAccessoryView = createKeyboardToolbar()
        textView.becomeFirstResponder()
    }

    
    func createKeyboardToolbar () -> UIView {
        let keyboardToolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
        
        let flexSpace = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(doneButtonPressed))
        keyboardToolbar.setItems([flexSpace, doneButton], animated: false)
        
        return keyboardToolbar
    }

    func doneButtonPressed() {
        shouldExit = true
        textView.resignFirstResponder()
    }

}

extension TextSnippetEntryViewController : UITextViewDelegate {
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        guard shouldExit else { return }
        
        saveText(textView.text)
        dismiss(animated: true, completion: nil)
    }
}
