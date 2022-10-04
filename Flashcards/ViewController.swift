//
//  ViewController.swift
//  Flashcards
//
//  Created by Renaud Fred Noubieptie Kamgang on 9/13/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
//        card.clipsToBounds = tru
        card.layer.shadowRadius = 20.0
        card.layer.shadowOpacity = 0.2
        
        // labels
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
        //botton
        btnOptionOne.layer.cornerRadius = 20.0
        btnOptionTwo.layer.cornerRadius = 20.0
        btnOptionThree.layer.cornerRadius = 20.0
        
        btnOptionOne.clipsToBounds = true
        btnOptionTwo.clipsToBounds = true
        btnOptionThree.clipsToBounds = true
        
        btnOptionOne.layer.borderWidth = 3.0
        btnOptionTwo.layer.borderWidth = 3.0
        btnOptionThree.layer.borderWidth = 3.0
//        btnOptionOne.layer.borderColor =
        
        
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?){
        
        let navigationController = segue.destination as! UINavigationController
        
        let creationController = navigationController.topViewController as! CreationViewController
        
        creationController.flashcardsController = self
    }

    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }else{
            frontLabel.isHidden = true
        }
    }
    
    func updateFlashcard(question: String, answer: String) {
        frontLabel.text = question
        backLabel.text = answer
    }
    
    
    @IBAction func didTapOptionOne(_ sender: Any) {
        btnOptionOne.isHidden = true
    }
    
    @IBAction func didTapOptionTwo(_ sender: Any) {
        frontLabel.isHidden = true
    }
    
    
    @IBAction func didTapOptionThree(_ sender: Any) {
        btnOptionThree.isHidden = true
    }
    
    
    
}

