//
//  ImpulseTests.swift
//  ImpulseTests
//
//  Created by David Riff on 8/9/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import XCTest
@testable import Impulse

class ImpulseTests: XCTestCase {

    func testSum() {
        XCTAssertEqual(Complex(real: 2 + 2, imag: 3),
                       Complex(real: 2, imag: 3) + 2 + 0.j)

        XCTAssertEqual(Complex(real: 2 + 2, imag: 3),
                       2 + 0.j + Complex(real: 2, imag: 3))

        XCTAssertEqual(Complex(real: 2 + 2, imag: 3),
                       Complex(2) + Complex(real: 2, imag: 3))
    }

    func testImaginary() {
        let a = (-2.0).j
        let b = 2.j

        XCTAssertEqual(a, Complex(real: 0, imag: -2.0))
        XCTAssertEqual(b, Complex(real: 0, imag: 2.0))
    }

    func testDivision() {
        let b = (2 + 32.j)
        let a = (1 + 1.j)
        let result = b / a

        print(result)
        XCTAssertEqual(result.real, 17)
        XCTAssertEqual(result.imag, 15)
    }
}
