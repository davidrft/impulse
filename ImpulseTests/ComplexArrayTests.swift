//
//  ComplexArrayTests.swift
//  ImpulseTests
//
//  Created by David Riff on 8/19/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

@testable import Impulse
import XCTest

class ComplexArrayTests: XCTest {
    func testFFT() {
        let alist: [Double] = [0, 2, 3, 4]
        let expected: [Complex] = [9.0+0.j, -3.0+2.0.j, -3.0 + 0.j, -3.0 + (-2.0).j]

        print(alist)
        print(alist.fft())
        print(expected)

        XCTAssert(alist.fft().elementsEqual(expected))
    }

    func testIFFT() {
        let alist: [Complex] = [9.0+0.j, -3.0+2.0.j, -3.0 + 0.j, -3.0 + (-2.0).j]
        let expected: [Double] = [0, 2, 3, 4]
        print(alist)
        print(expected.ifft())
        print(expected)

        for i in 0..<alist.count {
            XCTAssert(alist.ifft()[i] == expected[i])
        }
    }
}
