//
//  CalculatorOperation.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import Foundation

enum CalculatorOperation {
    case divide
    case multiply
    case subtract
    case add
    
    var title: String {
        switch self {
        case .divide:
            return "÷"
        case .multiply:
            return "x"
        case .subtract:
            return "-"
        case .add:
            return "+"
        }
    }
}
