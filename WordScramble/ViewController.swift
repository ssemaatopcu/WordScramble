//
//  ViewController.swift
//  WordScramble
//
//  Created by Sema Topcu on 2/12/24.
//

import UIKit

class ViewController: UITableViewController {
    var allWords = [String]()
    var usedWords = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(promptForAnswer))
        /* that created a new UIBarButtonItem using the "add" system item, and configured it to run a method called promptForAnswer() when tapped */
        
        if let startWordsURL = Bundle.main.url(forResource: "start", withExtension: "txt"){
            if let startWords = try? String(contentsOf: startWordsURL) {
                allWords = startWords.components(separatedBy: "\n")
            }
        } else {
            allWords = ["silkworm"]
        }
        startGame()
    }
/* try? means "call this code, and if it throws an error just send me back nil instead." This means the code you call will always work, but you need to unwrap the result carefully
 that code carefully checks for and unwraps the contents of our start file, then converts it to an array
 */

    func startGame(){
        title = allWords.randomElement() //sets view controller's title to be a random word in the array, which will be the word the player has to find
        usedWords.removeAll(keepingCapacity: true) //adding anything to it right now
        tableView.reloadData()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return usedWords.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Word", for: indexPath)
        cell.textLabel?.text = usedWords[indexPath.row]
        return cell
    }
    
    @objc func promptForAnswer(){
        let ac = UIAlertController(title: "Enter answer", message: nil, preferredStyle: .alert)
        ac.addTextField()
        /*  addTextField() method just adds an editable text input field to the UIAlertController
            UITextField is a simple editable text box that shows the keyboard so the user can enter something, we added a single text field to the UIAlertController using its addTextField() method
         */
        
        let submitAction = UIAlertAction(title: "Submit", style: .default) {
            [weak self, weak ac] _ in
            guard let answer = ac?.textFields?[0].text else {return}
            self?.submit(answer)
            /* in: everything after that is the closure, so action in means that it accepts one parameter in, of type UIAlertAction 
              3th line safely unwraps the array of text fields – it's optional because there might not be any.
             4th line pulls out the text from the text field and passes it to our (all-new-albeit-empty) submit() method */
        }
        ac.addAction(submitAction)
        present(ac, animated: true)
        /* addAction() method is used to add a UIAlertAction to a UIAlertController */
    }
    
    func submit(_ answer: String) {
        let lowerAnswer = answer.lowercased()
        
        /* we have three if statements, one inside another. These are called nested statements, because you nest one inside the other
           only if all three statements are true (the word is possible, the word hasn't been used yet, and the word is a real word), does the main block of code execute */
        if isPossible(word: lowerAnswer){
            if isOriginal(word: lowerAnswer) {
                if isReal(word: lowerAnswer) {
                    usedWords.insert(answer, at: 0)
                    
                    let indexPath = IndexPath(row: 0, section: 0)
                    tableView.insertRows(at: [indexPath], with: .automatic)
                }
            }
        }
    }
    
    func isPossible(word: String) -> Bool{
        return true
    }
    
    func isOriginal(word: String) -> Bool{
        return true
    }
    
    func isReal(word: String) -> Bool{
        return true
    }
}

