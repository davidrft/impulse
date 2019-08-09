//
//  FloatingPoint+Complex.swift
//  Impulse
//
//  Created by David Riff on 8/9/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

extension BinaryFloatingPoint & SignedNumeric {
    var j: Complex {
        return Complex(real: 0, imag: Double(self))
    }
}
