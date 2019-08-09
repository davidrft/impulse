//
//  DoubleArrayTests.swift
//  ImpulseTests
//
//  Created by David Riff on 8/25/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import XCTest
@testable import Impulse

class DoubleArrayTests: XCTestCase {

    func testArraySum() {
        let a = [3.0, 2.0, 1.0]
        let b = [1.0, 42.0, 58.0, 1.0]
        let expected = [4.0, 44.0, 59.0, 4.0]

        print(a .+ b)
        XCTAssert((a .+ b).elementsEqual(expected))
    }

}
