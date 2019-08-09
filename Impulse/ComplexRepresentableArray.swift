//
//  ComplexRepresentableArray.swift
//  Impulse
//
//  Created by David Riff on 8/16/19.
//  Copyright © 2019 David Riff. All rights reserved.
//

import Accelerate

extension Array where Element: ComplexRepresentable {
    fileprivate func fft(withDirection direction: FFTDirection) -> [Complex] {
        let length = floor(log2(Double(self.count)))

        var real = self.map { $0.real }
        var imag = self.map { $0.imag }
        var splitComplex = DSPDoubleSplitComplex(realp: &real, imagp: &imag)

        let setup = vDSP_create_fftsetupD(vDSP_Length(length),
                                          FFTRadix(kFFTRadix2))

        if let setup = setup {
            vDSP_fft_zipD(setup,
                          &splitComplex,
                          vDSP_Stride(1),
                          vDSP_Length(length),
                          direction)
        }

        var result = [Complex](repeating: Complex(0), count: self.count)
        var i = 0
        for (realElement, imagElement) in zip(real, imag) {
            result[i] = Complex(real: realElement, imag: imagElement)

            // TODO: Improve division
            if direction == kFFTDirection_Inverse {
                result[i] = result[i]/Double(self.count)
            }
            
            i += 1
        }
        vDSP_destroy_fftsetupD(setup)
        return result
    }

    func fft() -> [Complex] {
        if (isPowerOfTwo(self.count)) {
            return self.fft(withDirection: FFTDirection(kFFTDirection_Forward))
        }
        return []
    }

    func ifft() -> [Complex] {
        if (isPowerOfTwo(self.count)) {
            return self.fft(withDirection: FFTDirection(kFFTDirection_Inverse))
        }
        return []
    }
}
