//
//  Calculator.swift
//  Calculator
//
//  Created by nju on 2021/10/9.
//

import UIKit

let NC_E = 2.718281828459045
var is_Rad:Bool = true

func getFactorIal(num: Int) -> Int {
    var sum = 1
    if(num == 0){return 1}
    for i in 1...num {
        sum *= i
    }
    return sum
}

class Calculator: NSObject {
    
    
    
    enum Operation{
        case UnaryOp((Double)->Double)
        case BinaryOp((Double,Double)->Double)
        case EqualOp
        case Constant(Double)
    }
    
    var operations = [
        "➕": Operation.BinaryOp{ op1, op2 in
            return op1 + op2
        },
        "➖":Operation.BinaryOp{ op1,op2 in
            return op1 - op2
        },
        "✖️":Operation.BinaryOp{ op1,op2 in
            return op1 * op2
        },
        "➗":Operation.BinaryOp{ op1,op2 in
            return op1/op2
        },
        
        
        "=":Operation.EqualOp,
        
        
        "x²":Operation.UnaryOp{ op in
            return pow(Double(op),2)
        },
        "x³":Operation.UnaryOp{ op in
            return pow(Double(op),3)
        },
        "xʸ":Operation.BinaryOp{ op1,op2 in
            return pow(op1,op2)
        },
        "eˣ":Operation.UnaryOp{ op in
            
            return pow(Double(NC_E),op)
        },
        "10ˣ":Operation.UnaryOp{ op in
            return pow(Double(10),op)
        },
        "yˣ":Operation.BinaryOp{ op1, op2 in
            return pow(op1,op2)
        },
        "2ˣ":Operation.UnaryOp{ op in
            return pow(2,op)
        },
        
        
        
        "1/x":Operation.UnaryOp{ op in
            if(op==0){return Double(Int.min)}
            return 1/op
        },
        "√x":Operation.UnaryOp{ op in
            if(op<0){return Double(Int.min)}
            return sqrt(op)
        },
        "∛x":Operation.UnaryOp{ op in
            return pow(Double(op),1.0/3.0)
        },
        "ʸ√x":Operation.BinaryOp{ op1,op2 in
            return pow(op1,1.0/op2)
        },
        "ln":Operation.UnaryOp{ op in
            if(op<=0){return Double(Int.min)}
            return log(op)
        },
        "log₁₀":Operation.UnaryOp{ op in
            if(op<=0){return Double(Int.min)}
            return log10(op)
        },
        "logy":Operation.BinaryOp{ op1,op2 in
            if(op1 <= 0 || op2 <= 0){return Double(Int.min)}
            return log(op1)/log(op2)
        },
        "log2":Operation.UnaryOp{ op in
            if(op<=0){return Double(Int.min)}
            return log2(op)
        },
        
        
        "x!":Operation.UnaryOp{ op in
            if(op < 0){return -Double(getFactorIal(num: Int(-op)))}
            return Double(getFactorIal(num: Int(op)))
        },
        "sin":Operation.UnaryOp{ op in
            if is_Rad{
                return sin(op)
            }
            else{
                return sin(op/180.0 * .pi)
            }
        },
        "cos":Operation.UnaryOp{ op in
            if is_Rad{
                return cos(op)
            }
            else{
                return cos(op/180.0 * .pi)
            }
        },
        "tan":Operation.UnaryOp{ op in
            if is_Rad{
                return tan(op)
            }
            else{
                return tan(op/180.0 * .pi)
            }
        },
        "arcsin":Operation.UnaryOp{ op in
            if(abs(op) > 1 && abs(op - 1.0)>1e-9){
                print("arcsin here")
                return Double(Int.min)}
            if is_Rad{
                return asin(op)
            }
            else{
                return asin(op/180.0 * .pi)
            }
        },
        "arccos":Operation.UnaryOp{ op in
            if(abs(op) > 1 && abs(op - 1.0)>1e-9){return Double(Int.min)}
            if is_Rad{
                return acos(op)
            }
            else{
                return acos(op/180.0 * .pi)
            }
        },
        "arctan":Operation.UnaryOp{ op in
            if is_Rad{
                return atan(op)
            }
            else{
                return atan(op/180.0 * .pi)
            }
        },
        "e":Operation.Constant(NC_E),
        
        "EE":Operation.BinaryOp{ op1,op2 in
            return op1 * pow(10, op2)
        },
        
        "Rad":Operation.UnaryOp{ op in
            is_Rad = !is_Rad
            print(is_Rad)
            return op
        },
        "sinh":Operation.UnaryOp{ op in
            if is_Rad{
                return sinh(op)
            }
            else{
                return sinh(op/180.0 * .pi)
            }
        },
        "cosh":Operation.UnaryOp{ op in
            if is_Rad{
                return cosh(op)
            }
            else{
                return cosh(op/180.0 * .pi)
            }
        },
        "tanh":Operation.UnaryOp{ op in
            if is_Rad{
                return tanh(op)
            }
            else{
                return tanh(op/180.0 * .pi)
            }
        },
        "asinh":Operation.UnaryOp{ op in
            if is_Rad{
                return asinh(op)
            }
            else{
                return asinh(op/180.0 * .pi)
            }
        },
        "acosh":Operation.UnaryOp{ op in
            if(op<1){return Double(Int.min)}
            if is_Rad{
                return acosh(op)
            }
            else{
                return acosh(op/180.0 * .pi)
            }
        },
        "atanh":Operation.UnaryOp{ op in
            if(op < 0 || op > 1){return Double(Int.min)}
            if is_Rad{
                return atanh(op)
            }
            else{
                return atanh(op/180.0 * .pi)
            }
        },
        "π":Operation.Constant(.pi),
        "Rand":Operation.UnaryOp{ _ in
            return drand48()
        },
        
        "%":Operation.UnaryOp{ op in
            return op/100.0
        },
        "+/-":Operation.UnaryOp{ op in
            return -op
        },
        "AC":Operation.UnaryOp{ _ in
            is_Rad = true
            return 0
        },
        "C":Operation.UnaryOp{ _ in
            is_Rad = true
            return 0
        },
    ]
    
    struct Intermediate{
        var firstOp: Double
        var waiting_Opration: (Double,Double)->Double
    }
    var pendingOp:Intermediate? = nil
    
    func performOperation(operation: String, operand: Double = 0.0) -> Double?{
        if let op = operations[operation]{
            switch op{
            case .BinaryOp(let function):
                pendingOp = Intermediate(firstOp: operand, waiting_Opration: function)
                return nil
            case .UnaryOp(let function):
                return function(operand)
            case .EqualOp:
                if pendingOp == nil{return operand}
                else{
                    let res = pendingOp!.waiting_Opration(pendingOp!.firstOp,operand)
                    pendingOp = nil
                    return res
                }
            case .Constant(let value):
                return value
        }
        }
        return nil
    }
}
