//
//  DoubleArray.swift
//  Impulse
//
//  Created by David Riff on 8/19/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import Foundation
import Accelerate

fileprivate let STRIDE = vDSP_Stride(1)

infix operator .+
infix operator .-
infix operator .*
infix operator ./

extension Array where Iterator.Element == Double {
    func sum() -> Double {
        var result: Double = 0.0
        var copy = self
        vDSP_sveD(&copy, STRIDE, &result, vDSP_Length(self.count))
        return result
    }

    func mean() -> Double {
        var result: Double = 0.0
        var copy = self
        vDSP_meanvD(&copy, STRIDE, &result, vDSP_Length(self.count))
        return result;
    }

    func std() -> Double {
        let mean = self.mean()

        var copy = self
        var meanOfSquares: Double = 0.0
        vDSP_measqvD(&copy, STRIDE, &meanOfSquares, vDSP_Length(self.count))

        return sqrt(meanOfSquares - mean)
    }

    func min() -> Double {
        var result: Double = 0.0
        var copy = self
        vDSP_minvD(&copy, STRIDE, &result, vDSP_Length(self.count))
        return result
    }

    func max() -> Double {
        var result: Double = 0.0
        var copy = self
        vDSP_maxvD(&copy, STRIDE, &result, vDSP_Length(self.count))
        return result
    }

    static func .+ (lhs: [Double], rhs: [Double]) -> [Double] {
        var smaller = lhs
        var bigger = rhs

        if smaller.count > bigger.count {
            (smaller, bigger) = (bigger, smaller)
        }

        var sum = [Double](repeating: 0.0, count: bigger.count)

        var currentPosition = 0

        while currentPosition < bigger.count {
            let length = Swift.min(smaller.count, bigger.count - currentPosition)

            vDSP_vaddD(&bigger + currentPosition,
                       STRIDE,
                       &smaller,
                       STRIDE,
                       &sum + currentPosition,
                       STRIDE,
                       vDSP_Length(length))

            currentPosition += length
        }

        return sum
    }

    static func .- (lhs: [Double], rhs: [Double]) -> [Double] {
        var right = rhs
        var negativeRight = rhs
        vDSP_vnegD(&right,
                   STRIDE,
                   &negativeRight,
                   STRIDE,
                   vDSP_Length(negativeRight.count))
        return lhs .+ negativeRight
    }
}
