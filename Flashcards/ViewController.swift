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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        card.layer.cornerRadius = 20.0
//        card.clipsToBounds = true
        card.layer.shadowRadius = 20.0
        card.layer.shadowOpacity = 0.2
        
        frontLabel.layer.cornerRadius = 20.0
        backLabel.layer.cornerRadius = 20.0
        frontLabel.clipsToBounds = true
        backLabel.clipsToBounds = true
        
    }

    
    @IBAction func didTapOnFlashcard(_ sender: Any) {
        
        if(frontLabel.isHidden == true){
            frontLabel.isHidden = false
        }else{
            frontLabel.isHidden = true
        }
    }
    
    
}

