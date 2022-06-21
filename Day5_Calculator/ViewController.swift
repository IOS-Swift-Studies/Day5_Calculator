//
//  ViewController.swift
//  Day5_Calculator
//
//  Created by Quyen Lu on 18/06/2022.
//

import UIKit

class ViewController: UIViewController {

    var valueStr: String = ""
    var lastButtonPressed: String = ""
    var lastValue: Double = 0
    var mathSign = ""
    
    @IBOutlet weak var textLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        lastValue = 0
        valueStr = ""
        lastButtonPressed = ""
        textLabel.text = "0"
    }
    
    
    @IBAction func buttonOnPress(_ sender: UIButton) {
        guard let title = sender.currentTitle else { return }
        
        if (title.isDot) {
            handleDotBtn()
        }
        else if (title.isNumeric) {
            handleNumberBtns(value: title)
        }
        else if (title.isPositiveNegative) {
            handleNegativeBtn()
        }
        else if (title.isAC) {
            handleACBtn()
        }
        else if (title.isAC) {
            handleACBtn()
        }
        else if (title.isPercent) {
            handlePercentBtn()
        }
        else if (title.isEqualSign) {
            handleEqualBtn()
            
        }
        else if (title.isMathSigns) {
            handleOperations(sign: title)
        }
        lastButtonPressed = title
        
    }
    
    func handleNegativeBtn() {
        var value:Double = Double(textLabel.text!) ?? 0
        value = value * -1
        if (value.isDouble) {
            valueStr = String(value)
        }
        else {
            valueStr = String(Int(value))
        }
        textLabel.text = valueStr
    }
    
    func handleNumberBtns(value: String) {
        if (value == "0" && valueStr == "0") {
            return
        }
        
        if (valueStr == "0") {
            valueStr = value
        }
        else {
            valueStr += value
        }
        textLabel.text = valueStr
        
    }
    
    func handleDotBtn() {
        if (!lastButtonPressed.isNumeric) {
            valueStr = "0."
        }
        else {
            valueStr += "."
        }
        textLabel.text = valueStr
    }
    
    func handleACBtn() {
        valueStr = "0"
        lastValue = 0
        textLabel.text = valueStr
        mathSign = ""
    }
    
    
    func handlePercentBtn() {
        let value:Double = Double(textLabel.text!) ?? 0
        valueStr = String(value / 100)
        textLabel.text = valueStr
    }
    
    
    func handleOperations(sign: String) {
        if (mathSign.isEmpty) {
            lastValue += Double(valueStr) ?? 0
            mathSign = sign
            valueStr = ""
        }
        else if (valueStr.isNumeric){
            lastValue = lastValue.calculate(sign: mathSign, value: Double(valueStr) ?? 0)
            if (lastValue.isDouble) {
                valueStr = String(lastValue)
            }
            else {
                valueStr = String(Int(lastValue))
            }
            
            textLabel.text = valueStr
            mathSign = sign
            valueStr = ""
        }
        
    }
    
    func handleEqualBtn() {
        if (!valueStr.isEmpty && !mathSign.isEmpty) {
            lastValue = lastValue.calculate(sign: mathSign, value: Double(valueStr) ?? 0)
            if (lastValue.isDouble) {
                valueStr = String(lastValue)
            }
            else {
                valueStr = String(Int(lastValue))
            }
            
            textLabel.text = valueStr
        }
        lastValue = 0
        mathSign = ""
        valueStr = ""
        
    }

}

extension Double {
    func calculate(sign: String, value:Double) -> Double {
        if (sign.isPlus) {
            return self + value
        }
        else if (sign.isMinus) {
            return self - value
        }
        else if (sign.isMultiply) {
            return self * value
        }
        else if (sign.isDivide) {
            return self / value
        }
        else if (sign.isPercent) {
            return self / 100
        }
        return 0
    }
    
    var isDouble: Bool { return floor(self) != self }
    
}

extension String {
    var isNumeric : Bool {
        return Double(self) != nil
    }
    var isDot: Bool { return (self == ".") }
    var isAC: Bool { return (self == "AC") }
    var isPositiveNegative: Bool { return (self == "+/-") }
    var isPercent: Bool { return (self == "%") }
    var isMathSigns: Bool {
        return (self == "+") || (self == "-") ||  (self == "x")  || (self == "÷")
    }
    var isPlus: Bool { return (self == "+") }
    var isMinus: Bool { return (self == "-") }
    var isMultiply: Bool { return (self == "x") }
    var isDivide: Bool { return (self == "÷") }
    var isEqualSign: Bool { return (self == "=") }
    
}

