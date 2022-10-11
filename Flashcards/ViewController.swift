//
//  ViewController.swift
//  Flashcards
//
//  Created by Renaud Fred Noubieptie Kamgang on 9/13/22.
//

import UIKit

struct Flashcard {
    var question: String
    var answer: String
}

class ViewController: UIViewController {

    
    @IBOutlet weak var frontLabel: UILabel!
    @IBOutlet weak var backLabel: UILabel!
    @IBOutlet weak var card: UIView!
    
    
    @IBOutlet weak var btnOptionOne: UIButton!
    @IBOutlet weak var btnOptionTwo: UIButton!
    @IBOutlet weak var btnOptionThree: UIButton!
    
    
    //next and prev button
    @IBOutlet weak var prevButton: UIButton!
    @IBOutlet weak var nextButton: UIButton!
    
    
    
    
    // array to hold flashcards
    var flashcards = [Flashcard]()
    // current flashacard index
    var currentIndex = 0
    
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
        
        // read saved flashcards
        readSavedFlashcards()
        
        // adding our initial flashcard if needed
        if flashcards.count == 0{
            updateFlashcard(question: "How big is the Earth?", answer: "3,958.8mi")
        }else{
            updateLabels()
            updateNextPrevButtons()
        }
        
        
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
        let flashcard = Flashcard(question: question, answer: answer)
        
//        if isExisting {
            
            // replace existing flashcard
//            flashcards[currentIndex] = flashcard
//        }else{
            
            // adding a flashcard to flashcards
            flashcards.append(flashcard)
            
    //        frontLabel.text = flashCard.question
    //        backLabel.text = flashCard.answer
            
            //upadating the current index
            currentIndex = flashcards.count-1
            
            
//        }

        
        
        print("A new flashcard was added, here it is->", flashcard)
        print("we have \(flashcards.count)")
        // just for the console log
        print("Print the log")
        
        updateNextPrevButtons()
        
        // update labels
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
    func updateNextPrevButtons(){
        
        // Disable the next button if at end of flashcards array
        if(currentIndex == flashcards.count-1){
            nextButton.isEnabled = false
        }else{
            nextButton.isEnabled = true
        }
        
        // Disable prev button if at begining of array
        if(currentIndex == 0){
            prevButton.isEnabled = false
        }else{
            prevButton.isEnabled = true
        }
    }
    
    func updateLabels(){
        
        // get current flashcard ** also ask why its a let and not a var
        let currentFlashcard = flashcards[currentIndex]
        
        // update labels
        frontLabel.text = currentFlashcard.question
        backLabel.text = currentFlashcard.answer
        
        
    }
    
    // to save all the created flashcards in a disk so the memory persist
    func saveAllFlashcardsToDisk(){
        
        // converting array to dictionary
        let dictionaryArray = flashcards.map { (card) -> [String: String] in
            return ["question":card.question, "answer":card.answer]
        }
        
        
        // save array to disk using UserDefaults
        UserDefaults.standard.set(dictionaryArray, forKey: "flashcards")
        print("Flashcards saved to UserDefault")
    }
    
    func readSavedFlashcards(){
        
        // read dictionary array from disk (if any)
        if let dictionaryArray = UserDefaults.standard.array(forKey: "flashcards") as? [[String: String]]{
            
            // convert from dictionary to array
            let savedCards = dictionaryArray.map { dictionary -> Flashcard in
                return Flashcard(question: dictionary["question"]!, answer: dictionary["answer"]!)
            }
            
            // Put all these cards in our flashcards array
            flashcards.append(contentsOf: savedCards)
        }
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
    
    @IBAction func didTapOnPrev(_ sender: Any) {
        // decrememting the current index
        currentIndex = currentIndex - 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnNext(_ sender: Any) {
        
        // incrememtingvcurrent index
        currentIndex = currentIndex + 1
        
        // update labels
        updateLabels()
        
        // update buttons
        updateNextPrevButtons()
    }
    
    @IBAction func didTapOnDelete(_ sender: Any) {
        
        print("hello")
        // show confirmation
        let alert = UIAlertController(title: "Delete Flashcard", message: "Are you sure you want to delete it?", preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: "Delete", style: .destructive) { action in self.deleteCurrentFlashcard()
        }
        
        print("hey")
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        present(alert, animated: true)
    }
    
    func deleteCurrentFlashcard(){
        
        // delete current flashcard
        flashcards.remove(at: currentIndex)
        
        // if the last flashcard was deleted
        if currentIndex > flashcards.count-1{
            currentIndex = flashcards.count-1
        }
        
        updateNextPrevButtons()
        updateLabels()
        saveAllFlashcardsToDisk()
    }
    
    
}

