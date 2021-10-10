//
//  ViewController.swift
//  Calculator
//
//  Created by yumizhi on 2021/10/6.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var displayLabel: UILabel!
    @IBOutlet weak var theClearButton: MyButton!
    
    //The Button that need to change Text
    
    @IBOutlet weak var e_To_y: MyButton!
    @IBOutlet weak var ten_to_two: MyButton!
    @IBOutlet weak var ln_to_logy: MyButton!
    @IBOutlet weak var to_log2: MyButton!
    @IBOutlet weak var sin_1: MyButton!
    @IBOutlet weak var cos_1: MyButton!
    @IBOutlet weak var tan_1: MyButton!
    @IBOutlet weak var sinh_1: MyButton!
    @IBOutlet weak var cosh_1: MyButton!
    @IBOutlet weak var tanh_1: MyButton!
    
    //
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.ß
        self.displayLabel.text! = "0"
        
    }
    
    var digitOnDisplay:String{
        get{
            return self.displayLabel.text!
        }
        
        set{
            self.displayLabel.text! = newValue
        }
    }
    
    var is_change:Bool = false
    @IBAction func changeToAnotherMod(_ sender: MyButton) {
        if is_change{
            e_To_y.setTitle("eˣ", for: .normal)
            ten_to_two.setTitle("10ˣ", for: .normal)
            ln_to_logy.setTitle("ln", for: .normal)
            to_log2.setTitle("log₁₀", for: .normal)
            sin_1.setTitle("sin", for: .normal)
            cos_1.setTitle("cos", for: .normal)
            tan_1.setTitle("tan", for: .normal)
            sinh_1.setTitle("sinh", for: .normal)
            cosh_1.setTitle("cosh", for: .normal)
            tanh_1.setTitle("tanh", for: .normal)
            is_change = false
        }
        else{
            e_To_y.setTitle("yˣ", for: .normal)
            ten_to_two.setTitle("2ˣ", for: .normal)
            ln_to_logy.setTitle("logy", for: .normal)
            to_log2.setTitle("log2", for: .normal)
            sin_1.setTitle("arcsin", for: .normal)
            cos_1.setTitle("arccos", for: .normal)
            tan_1.setTitle("arctan", for: .normal)
            sinh_1.setTitle("asinh", for: .normal)
            cosh_1.setTitle("acosh", for: .normal)
            tanh_1.setTitle("atanh", for: .normal)
            is_change = true
        }
    }
    
    
    var inTypingMode = false
    
    //隐式可选类型解析
    @IBAction func numbertouched(_ sender: MyButton) {
        print("Number \(String(describing: sender.currentTitle!)) is touched!")
        
        if inTypingMode || sender.currentTitle == "."{
            digitOnDisplay = digitOnDisplay + sender.currentTitle!
        }
        else{
            digitOnDisplay = sender.currentTitle!
            inTypingMode = true
        }
    }
    
    
    let calculator = Calculator()
    
    @IBAction func operatortouched(_ sender: MyButton) {
        
        print("Operator \(String(describing: sender.currentTitle!)) is touched!")
        if sender.currentTitle == "C"{theClearButton.setTitle("AC", for: UIControl.State.normal)}
        else if sender.currentTitle != "AC" && theClearButton.currentTitle != "C"
        {theClearButton.setTitle("C", for: UIControl.State.normal)}
        
        if let op = sender.currentTitle{
            if(digitOnDisplay == "NAN" || digitOnDisplay == "inf"){digitOnDisplay = String(0)}
            else if let result = calculator.performOperation(operation: op, operand: Double(digitOnDisplay)!){
                
                if(result == Double(Int.min)){digitOnDisplay = "NAN"}
                else{
                    let tmp = String(round(1e13*result)/1e13)
                    
                    let res = Double(tmp)
                    if res! < 1E18 && Double(Int(result)) == result{  digitOnDisplay = String(Int(res!)) }
                    else{ digitOnDisplay = String(res!) }}
            }
            inTypingMode = false
        }
    }
    
}

@IBDesignable class MyButton: UIButton
{
    
    override func layoutSubviews() {
        super.layoutSubviews()
        updateCornerRadius()
    }

    @IBInspectable var rounded: Bool = false {
        didSet {
            updateCornerRadius()
        }
    }

    func updateCornerRadius() {
        var k: CGFloat = 0.0
        if(frame.size.height > frame.size.width){
            k = frame.size.width
        }
        else{
            k = frame.size.height
        }
        if self.currentTitle == "0"{self.titleLabel?.font = .systemFont(ofSize: 30.0)}
        else if frame.size.height > frame.size.width{self.titleLabel?.font = .systemFont(ofSize: 35.0)}
        else{self.titleLabel?.font = .systemFont(ofSize: 25.0)}
        layer.cornerRadius = rounded ? 0 : k / 2
    }
}
