//
//  ViewController.swift
//  Test1
//
//  Created by Paul on 15/6/2566 BE.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(
         target: self,
         action: #selector(dismissMyKeyboard))
         view.addGestureRecognizer(tap)
    }
    @objc func dismissMyKeyboard(){
    view.endEditing(true)
    }
    
    @IBOutlet weak var inputTest1: UITextField! {
        didSet {
            inputTest1.keyboardType = .numberPad
            inputTest1.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var inputTest2: UITextField! {
        didSet {
            inputTest2.keyboardType = .numberPad
            inputTest2.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    @IBOutlet weak var inputTest3: UITextField! {
        didSet {
            inputTest3.keyboardType = .numberPad
            inputTest3.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }

    @IBOutlet weak var inputTest4: UITextField! {
        didSet {
            inputTest4.keyboardType = .numberPad
            inputTest4.addTarget(self, action: #selector(ViewController.textFieldDidChange(_:)), for: .editingChanged)
        }
    }
    
    
    @IBAction func actionTest4(_ sender: Any) {
        self.checkMutiSetDigits2(input: inputTest4.text ?? "")
    }
    
    @IBAction func actionTest3(_ sender: Any) {
        self.checkNumberLineUp(input: inputTest3.text ?? "")
    }
    
    @IBAction func actionTest2(_ sender: Any) {
        self.checkMutiDigits2(input: inputTest2.text ?? "")
    }
    
    @IBAction func actionTest1(_ sender: Any) {
        
        self.checkCountNumberTest1(input: inputTest1.text ?? "")
        
    }
    

    //MARK: -Function
    
    func checkCountNumberTest1(input: String) {
        if input.count >= 6 {
            print("Input is Correct count: \(input.count) input is: \(input)")
        } else {
            print("Input is Not Correct count: \(input.count) input is: \(input)")
        }
    }
    
    func checkMutiDigits2(input: String) {
        // input =  123
        var cutArray: [Character] = [] // เก็บค่าที่ตัดออกมา
        var countMutiChar: Int = 0
        var isCorrect: Bool = true
        for index in input {
            cutArray.append(index)
        }
        
        for (index, char) in cutArray.enumerated() {
            //print(char) // index is 012 char is 123
            for charInput in input {
                if countMutiChar <= 2 {
                    if char == charInput {
                        countMutiChar += 1
                        print(countMutiChar)
                    } else {
                        countMutiChar = 0
                    }
                } else {
                    isCorrect = false
                    break
                }
            }
        }
        
        if isCorrect {
            print("This \(input) is Correct!!")
        } else {
            print("This \(input) is not Correct!!")
        }
        
    }
    
    func checkNumberLineUp(input: String) {
        var cutString: [Character] = []
        var countLineup: Int = 0
        var isCorrect: Bool = true
        let countInput = input.count - 1
        
        for index in input {
            cutString.append(index) // 1, 2, 3, 4, 5 || 1, 3, 4, 5, 7, 8
        }
        // input 12345
        for (index,char) in cutString.enumerated() {
            var charIntPlus = (char.wholeNumberValue ?? 0) + 1 // 2
            var charIntMinus = (char.wholeNumberValue ?? 0) - 1 // 0
            var charStringPlus = String(charIntPlus) // 2
            var charStringMinus = String(charIntMinus) // 0
            if countLineup < 2 {
                if (index + 1) <= countInput || (index + 2) <= countInput {
                    if charStringPlus == String(input[index+1]) || charStringMinus == String(input[index+1]){ // 2 == 2 T
                        charStringPlus = String(charIntPlus + 1)
                        charStringMinus = String(charIntMinus - 1)
                        countLineup += 1
                        if (index + 2) <= countInput {
                            if charStringPlus == String(input[index+2]) || charStringMinus == String(input[index+2]) { // 3 == 3 T
                                countLineup += 1
                            } else {
                                countLineup = 0
                            }
                        } else {
                            break
                        }

                    } else {
                        countLineup = 0
                    }
                } else {
                    break
                }
            } else {
                isCorrect = false
                break
            }

        }
        
        if isCorrect {
            print("This \(input) is Correct!!")
        } else {
            print("This \(input) is not Correct!!")
        }
        
    }
    
    func checkMutiSetDigits2(input: String) {
        var cutArray: [Character] = []
        var isCorrect: Bool = true
        let countInput = input.count - 1
        var currentIndex: Int = 0
        var countSet: Int = 0
        
        for char in input {
            cutArray.append(char) // [1, 1, 2, 2, 3, 3]
        }
        
        for char in cutArray {
            if countSet <= 2 {
                if currentIndex <= countInput && (currentIndex + 1) <= countInput{
                    if cutArray[currentIndex] == cutArray[currentIndex + 1] {
                        countSet += 1
                        currentIndex += 2
                    } else {
                        currentIndex += 2
                    }
                } else {
                    break
                }
            } else {
                isCorrect = false
                break
            }
        }
        
        if isCorrect {
            print("This \(input) is Correct!!")
        } else {
            print("This \(input) is not Correct!!")
        }
        
        
        
    }
    
    //MARK: -Method
    @objc func textFieldDidChange(_ textField: UITextField) {
        checkValidation(text: textField.text ?? "")
        textField.text = checkValidation(text: textField.text ?? "")
    }
    
    private func checkValidation(text: String) -> String {
        let regex = try! NSRegularExpression(pattern: "[^0-9]")
        let modString = regex.stringByReplacingMatches(in: text, options: [], range: NSMakeRange(0, text.count), withTemplate: "")
        return modString
    }
    
}

extension StringProtocol {
    subscript(offset: Int) -> Character {
        self[index(startIndex, offsetBy: offset)]
    }
}

