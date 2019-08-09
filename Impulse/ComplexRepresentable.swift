//
//  ComplexRepresentable.swift
//  Impulse
//
//  Created by David Riff on 8/16/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

protocol ComplexRepresentable {
    var real: Double { get }
    var imag: Double { get }
}

extension Double: ComplexRepresentable {
    var real: Double { return self }
    var imag: Double { return 0 }
}
