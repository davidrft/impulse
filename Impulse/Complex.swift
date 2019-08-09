//
//  Complex.swift
//  Impulse
//
//  Created by David Riff on 8/9/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import Accelerate

class Complex: ComplexRepresentable {
    var real: Double
    var imag: Double

    init(real: Double, imag: Double) {
        self.real = real
        self.imag = imag
    }

    init(_ real: Double) {
        self.real = real
        self.imag = 0
    }

    static prefix func - (complex: Complex) -> Complex {
        return Complex(real: -complex.real, imag: -complex.imag)
    }

    static prefix func + (complex: Complex) -> Complex {
        return complex
    }

    static func + (lhs: Double, rhs: Complex) -> Complex {
        return Complex(real: lhs + rhs.real, imag: rhs.imag)
    }

    static func + (lhs: Complex, rhs: Double) -> Complex {
        return Complex(real: lhs.real + rhs, imag: lhs.imag)
    }

    static func + (lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real + rhs.real,
                       imag: lhs.imag + rhs.imag)
    }

    static func += (lhs: inout Complex, rhs: Complex) {
        lhs = lhs + rhs
    }

    static func += (lhs: inout Complex, rhs: Double) {
        lhs = lhs + rhs
    }

    static func - (lhs: Double, rsh: Complex) -> Complex {
        return Complex(real: lhs - rsh.real,
                       imag: rsh.imag)
    }

    static func - (lhs: Complex, rhs: Double) -> Complex {
        return Complex(real: lhs.real - rhs,
                       imag: lhs.imag)
    }

    static func - (lhs: Complex, rhs: Complex) -> Complex {
        return Complex(real: lhs.real - rhs.real,
                       imag: lhs.imag - rhs.imag)
    }

    static func -= (lhs: inout Complex, rhs: Double) {
        lhs = lhs - rhs
    }

    static func -= (lhs: inout Complex, rhs: Complex) {
        lhs = lhs - rhs
    }

    // https://kek.gg/u/mkk8
    static func * (lhs: Complex, rhs: Complex) -> Complex {
        let k1 = lhs.real * (rhs.real + rhs.imag)
        let k2 = rhs.imag * (lhs.real + lhs.imag)
        let k3 = rhs.real * (lhs.imag - lhs.real)
        return Complex(real: k1 - k2, imag: k1 + k3)
    }

    static func * (lhs: Double, rhs: Complex) -> Complex {
        return Complex(real: lhs * rhs.real, imag: lhs * rhs.imag)
    }

    static func * (lhs: Complex, rhs: Double) -> Complex {
        return rhs * lhs
    }

    static func *= (lhs: inout Complex, rhs: Double) {
        lhs = lhs * rhs
    }

    static func *= (lhs: inout Complex, rhs: Complex) {
        lhs = lhs * rhs
    }

    // https://kek.gg/u/sgXd
    static func / (lhs: Complex, rhs: Complex) -> Complex {
        let a = lhs.real
        let b = lhs.imag
        let c = rhs.real
        let d = rhs.imag
        var e: Double
        var f: Double

        if abs(d) <= abs(c) {
            let r = d / c
            let t = 1 / (c + d * r)

            if r == 0 {
                e = (a + d * (b/c)) * t
                f = (b - a * (a/c)) * t
            } else {
                e = (a + b * r) * t
                f = (b  - a * r) * t
            }
        } else {
            let r = c / d
            let t = 1 / (c * r + d)

            if r == 0 {
                e = (c * (a/d) + b) * t
                f = (c * (b/d) - a) * t
            } else {
                e = (a * r + b) * t
                f = (b * r - a) * t
            }
        }

        return Complex(real: e, imag: f)
    }

    static func / (lhs: Double, rhs: Complex) -> Complex {
        return Complex(lhs)/rhs
    }

    static func / (lhs: Complex, rhs: Double) -> Complex {
        return lhs * (1/rhs)
    }
}

extension Complex: Equatable {
    static func == (lhs: Complex, rhs: Complex) -> Bool {
        return lhs.real == rhs.real && lhs.imag == rhs.imag
    }

    static func == (lhs: Double, rhs: Complex) -> Bool {
        return Complex(lhs) == rhs
    }

    static func == (lhs: Complex, rhs: Double) -> Bool {
        return lhs == Complex(rhs)
    }
}

extension Complex: CustomStringConvertible {
    var description: String {
        if self.real == 0 {
            return "\(self.imag)j"
        }
        if self.imag == 0 {
            return "\(self.real)"
        } else if self.imag < 0 {
            return "\(self.real) - \(-self.imag)j"
        }
        return "\(self.real) + \(self.imag)j"
    }
}
