//
//  ViewController.swift
//  simple-calc
//
//  Created by Chris Li on 4/17/17.
//  Copyright © 2017 Chris Li. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    var operators = [String]()
    var index = 0
    
    @IBOutlet weak var display: UITextField!

    
    @IBAction func EqualsButtonPressed(_ sender: Any) {
        if operators.count > 2 {
            let op1 = Int(operators[0])
            let op2 = Int(operators[2])
            let opMiddle = operators[1]
            print("TEST: \(operators)")
            display.text?.removeAll()
            if opMiddle == "+" {
                display.text?.append("\(op1! + op2!)")
            } else if opMiddle == "*" {
                display.text?.append("\(op1! * op2!)")
            } else if opMiddle == "-" {
                display.text?.append("\(op1! - op2!)")
            } else if opMiddle == "/" {
                if op2 == 0 {
                    display.text?.append("not a number")
                } else {
                    display.text?.append("\(op1! / op2!)")
                }
            } else if opMiddle == "%" {
                display.text?.append("\(op1! % op2!)")
            } else if opMiddle == "count" {
                display.text?.append("\((operators.count + 1) / 2)")
            } else if opMiddle == "avg" {
                let numOfElements = (operators.count + 1) / 2
                var total = 0
                for index in 0...operators.count {
                    if index % 2 == 0 {
                        total += Int.init(operators[index])!
                    }
                }
                display.text?.append("\(total/numOfElements)")
            }
        } else if operators.count == 2 {
            print("TEST: \(operators)")
            display.text?.removeAll()
            
            let opMiddle = operators[1]
                
            if opMiddle == "fact" {
                
                var total = 1
                let firstNumber = Int.init(operators[0])
                for index in 1...firstNumber! {
                    total *= index
                }
                display.text?.append("\(total)")

            } else if opMiddle == "count" {
                display.text?.append("\((operators.count + 1) / 2)")
            } else if opMiddle == "avg" {
                display.text?.append("\(operators[0])")
            }
        }
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
            print("TEST: \(operators)")
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

