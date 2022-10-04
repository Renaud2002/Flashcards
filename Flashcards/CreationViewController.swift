//
//  CreationViewController.swift
//  Flashcards
//
//  Created by Renaud Fred Noubieptie Kamgang on 9/27/22.
//

import UIKit

class CreationViewController: UIViewController {
    
    var flashcardsController: ViewController!
    
    @IBOutlet weak var questionTextField: UITextField!
    @IBOutlet weak var answerTextField: UITextField!
    
    
    @IBAction func didTapOnCancel(_ sender: Any) {
        
        dismiss(animated: true)
    }
    
    @IBAction func didTapOnDone(_ sender: Any) {
        
        
        let questionText = questionTextField.text
        
        let answerText = answerTextField.text
        
        //show error is the text inputs are empty
        if(questionText == nil || answerText == nil || questionText!.isEmpty || answerText!.isEmpty){
            
            let alert = UIAlertController(title:"Missing Text", message:"You forgot to input either a question or an answer", preferredStyle: UIAlertController.Style.alert)
            
            let okAction = UIAlertAction(title:"Ok", style: .default)
            
            alert.addAction(okAction)
            
            present(alert, animated: true)
            
        }else{
            flashcardsController.updateFlashcard(question: questionText!, answer: answerText!)
            dismiss(animated: true)
        }
        
        
        
    }
    
}
