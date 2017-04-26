//
//  ViewController.swift
//  simple-calc
//
//  Created by Chris Li on 4/17/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

// MARK: - Singleton

final class Singleton {
    
    // Can't init is singleton
    private init() { }
    
    // MARK: Shared Instance
    
    static let shared: Singleton = Singleton()
    
    // MARK: Local Variable
    
    var emptyStringArray : [String] = []
    
}

class ViewController: UIViewController {
    var operators = [String]()
    var history = [String]()
    var data = Singleton.shared
    var index = 0
    var historyTableViewController: HistoryTableViewController?
    
    @IBOutlet weak var display: UITextField!

    @IBOutlet weak var historyList: UIScrollView!
    

    
    @IBAction func EqualsButtonPressed(_ sender: Any) {
        // Goes through operators and builds up a string rep
        var historyString = ""
        for item in operators {
            historyString += item + " "
        }
        historyString += "= "
        
        if operators.count > 2 {
            let op1 = Int(operators[0])
            let op2 = Int(operators[2])
            let opMiddle = operators[1]
            
            //print("TEST: \(operators)"
            
            display.text?.removeAll()
            if opMiddle == "+" {
                display.text?.append("\(op1! + op2!)")
                historyString += "\(op1! + op2!)"
            } else if opMiddle == "*" {
                display.text?.append("\(op1! * op2!)")
                historyString += "\(op1! * op2!)"
            } else if opMiddle == "-" {
                display.text?.append("\(op1! - op2!)")
                historyString += "\(op1! - op2!)"
            } else if opMiddle == "/" {
                if op2 == 0 {
                    display.text?.append("not a number")
                    historyString += "not a number"
                } else {
                    display.text?.append("\(op1! / op2!)")
                    historyString += "\(op1! / op2!)"
                }
            } else if opMiddle == "%" {
                display.text?.append("\(op1! % op2!)")
                historyString += "\(op1! % op2!)"
            } else if opMiddle == "count" {
                display.text?.append("\((operators.count + 1) / 2)")
                historyString += "\((operators.count + 1) / 2)"
            } else if opMiddle == "avg" {
                let numOfElements = (operators.count + 1) / 2
                var total = 0
                for index in 0...operators.count {
                    if index % 2 == 0 {
                        total += Int.init(operators[index])!
                    }
                }
                display.text?.append("\(total/numOfElements)")
                historyString += "\(total/numOfElements)"
            }
        } else if operators.count == 2 {
            //print("TEST: \(operators)")
            
            display.text?.removeAll()
            
            let opMiddle = operators[1]
                
            if opMiddle == "fact" {
                
                var total = 1
                let firstNumber = Int.init(operators[0])
                if firstNumber! > 20 {
                    display.text?.append("too big a number")
                } else {
                    for index in 1...firstNumber! {
                        total *= index
                    }
                    display.text?.append("\(total)")
                    historyString += "\(total)"
                }
            } else if opMiddle == "count" {
                display.text?.append("\((operators.count + 1) / 2)")
                historyString += "\((operators.count + 1) / 2)"
            } else if opMiddle == "avg" {
                display.text?.append("\(operators[0])")
                historyString += "\(operators[0])"
            }
        }
        
        // print("History TEST: \(historyString)") // For Debug
        history.append(historyString)
        data.emptyStringArray.append(historyString)
        
        print(history)
        index = 0
        operators.removeAll()
        operators.append(display.text!)
    }
    
    
    @IBAction func ClearButtonPressed(_ sender: UIButton) {
        display.text?.removeAll()
        operators.removeAll()
    }
    
    @IBAction func OpButtonPressed(_ sender: UIButton) {
        let op = sender.titleLabel?.text
        if operators.count % 2 == 1 {
            display.text?.append(op!)
            operators.append(op!)
            index += 2
        }
    }
    
    @IBAction func NumButtonPressed(_ sender: UIButton) {
        if operators.count == 0 {
            display.text?.removeAll()
        }
        if index % 2 == 0 {
            var value = sender.titleLabel?.text
            display.text?.append(value!)
            if operators.count > index {
                value = operators[index] + value!
                operators.remove(at: index)
            }
            operators.append(value!)
            
            // print("TEST: \(operators)")
        }
    }
    
    // NOT USED YET
    @IBAction func HistoryButtonPressed(_ sender: UIButton) {
        
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        if historyList != nil {
            // print(history) // For Debug
            historyList.backgroundColor = UIColor.lightGray
            var count = 0
            for each in data.emptyStringArray {
                let item = UILabel(frame: CGRect(x: 20, y: 45 * count + 10, width: 225, height: 45))
                item.text = each
                historyList.addSubview(item)
                count += 1
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

