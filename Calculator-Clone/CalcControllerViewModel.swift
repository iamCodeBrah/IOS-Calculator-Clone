//
//  CalcControllerViewModel.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import Foundation

enum CurrentNumber {
    case firstNumber
    case secondNumber
}

class CalcControllerViewModel {
    
    var updateViews: (()->Void)?
    
    // MARK: - TableView DataSource Array
    let calcButtonCells: [CalculatorButton] = [
        .allClear, .plusMinus, .percentage, .divide,
        .number(7), .number(8), .number(9), .multiply,
        .number(4), .number(5), .number(6), .subtract,
        .number(1), .number(2), .number(3), .add,
        .number(0), .decimal, .equals
    ]
    
    // MARK: - Normal Variables
    private(set) lazy var calcHeaderLabel: String = (self.firstNumber ?? 0).description
    private(set) var currentNumber: CurrentNumber = .firstNumber
    
    private(set) var firstNumber: Int? = nil { didSet { self.calcHeaderLabel = self.firstNumber?.description ?? "0" }}
    private(set) var secondNumber: Int? = nil {didSet {self.calcHeaderLabel = self.secondNumber?.description ?? "0" }}
    
    private(set) var operation: CalculatorOperation? = nil
    
    // MARK: - Memory Variables
    private(set) var prevNumber: Int? = nil
    private(set) var prevOperation: CalculatorOperation? = nil
}

extension CalcControllerViewModel {
    
    public func didSelectButton(with calcButton: CalculatorButton) {
        
        switch calcButton {
        case .allClear: self.didSelectAllClear()
        case .plusMinus: self.didSelectPlusMinus()
        case .percentage: self.didSelectPercentage()
        case .divide: self.didSelectOperation(with: .divide)
        case .multiply: self.didSelectOperation(with: .multiply)
        case .subtract: self.didSelectOperation(with: .subtract)
        case .add: self.didSelectOperation(with: .add)
        case .equals: self.didSelectEqualsButton()
        case .number(let number): self.didSelectNumber(with: number)
        case .decimal: fatalError()
        }
        
        self.updateViews?()
    }
    
    private func didSelectAllClear() {
        self.currentNumber = .firstNumber
        self.firstNumber = nil
        self.secondNumber = nil
        self.operation = nil
        self.prevNumber = nil
        self.prevOperation = nil
    }
}

// MARK: - Selecting Numbers
extension CalcControllerViewModel {
    
    private func didSelectNumber(with number: Int) {
        
        if self.currentNumber == .firstNumber {
            
            if let firstNumber = self.firstNumber {
                var firstNumberString = firstNumber.description
                firstNumberString.append(number.description)
                self.firstNumber = Int(firstNumberString)
                self.prevNumber = Int(firstNumberString)
                
            } else {
                self.firstNumber = Int(number)
                self.prevNumber = Int(number)
            }
            
        } else {
            if let secondNumber = self.secondNumber {
                var secondNumberString = secondNumber.description
                secondNumberString.append(number.description)
                self.secondNumber = Int(secondNumberString)
                self.prevNumber = Int(secondNumberString)
            } else {
                self.secondNumber = Int(number)
                self.prevNumber = Int(number)
            }
        }
    }
}

// MARK: - Equals & Arithmetic Operations
extension CalcControllerViewModel {
    
    private func didSelectEqualsButton() {
        
        if let operation = self.operation,
           let firstNumber = self.firstNumber,
           let secondNumber = self.secondNumber {
            // Equals is pessed normally after firstNumber, then an operation, then a secondNumber
            
            let result = self.getOperationResult(operation, firstNumber, secondNumber)
            self.secondNumber = nil
            self.prevOperation = operation
            self.operation = nil
            self.firstNumber = result
            self.currentNumber = .firstNumber
        }
        else if let prevOperation = self.prevOperation,
                let firstNumber = self.firstNumber,
                let prevNumber = self.prevNumber {
            
            // This will update the calculated based on previously selected number and arithmatic operation
            let result = self.getOperationResult(prevOperation, firstNumber, prevNumber)
            self.firstNumber = result
        }
    }
    
    
    private func didSelectOperation(with operation: CalculatorOperation) {
        if self.currentNumber == .firstNumber {
            self.operation = operation
            self.currentNumber = .secondNumber
            
        } else if self.currentNumber == .secondNumber {
            
            if let prevOperation = self.operation, let firstNumber = self.firstNumber, let secondNumber = self.secondNumber {
                let result = self.getOperationResult(prevOperation, firstNumber, secondNumber)
                
                self.secondNumber = nil
                self.firstNumber = result
                self.currentNumber = .secondNumber
                self.operation = operation
            } else {
                // Else switch operation
                self.operation = operation
            }
        }
    }
    
    // MARK: - Helper
    private func getOperationResult(_ operation: CalculatorOperation, _ firstNumber: Int, _ secondNumber: Int) -> Int {
        switch operation {
        case .divide:
            return (firstNumber / secondNumber)
            
        case .multiply:
            return (firstNumber * secondNumber)
            
        case .subtract:
            return (firstNumber - secondNumber)
            
        case .add:
            return (firstNumber + secondNumber)
        }
    }
}

// MARK: - Action Buttons
extension CalcControllerViewModel {
    
    
    private func didSelectPlusMinus() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber {
            
            number.negate()
            self.firstNumber = number
            self.prevNumber = number
        } else if self.currentNumber == .secondNumber, var number = self.secondNumber {
            
            number.negate()
            self.secondNumber = number
            self.prevNumber = number
        }
    }
    
    private func didSelectPercentage() {
        if self.currentNumber == .firstNumber, var number = self.firstNumber {
            
            number /= 100
            self.firstNumber = number
            self.prevNumber = number
        }
        else if self.currentNumber == .secondNumber, var number = self.secondNumber {
            
            number /= 100
            self.secondNumber = number
            self.prevNumber = number
        }
    }
}

