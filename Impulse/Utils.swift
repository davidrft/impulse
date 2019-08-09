//
//  Utils.swift
//  Impulse
//
//  Created by David Riff on 8/19/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import Foundation

internal func isPowerOfTwo(_ number: Int) -> Bool {
    return number != 0 && (number & (number - 1)) == 0
}
