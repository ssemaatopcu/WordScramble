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
}

