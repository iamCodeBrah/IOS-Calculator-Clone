//
//  Extensions.swift
//  Calculator-Clone
//
//  Created by John Lee on 2022-09-15.
//

import Foundation

extension Double {
    var toInt: Int? {
        return Int(self)
    }
}

extension String {
    var toDouble: Double? {
        return Double(self)
    }
}

extension FloatingPoint {
    var isInteger: Bool { return rounded() == self }
}
