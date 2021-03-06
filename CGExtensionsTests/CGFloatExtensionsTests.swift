//
//  CGFloatExtensionsTests.swift
//  CGExtensionsTests
//
//  Created by Wagner Truppel on 27/12/2014.
//  Copyright (c) 2014 Wagner Truppel. All rights reserved.
//

import XCTest
import Foundation
import CoreGraphics

class CGFloatExtensionsTests: XCTestCase
{
    // Tests that conversions back and forth between degrees and radians are correct and
    // accurate, to a certain resolution.
    func test_convertingDegreesToRadsAndBack()
    {
        let epsilon = CGFloat(1e-12)

        for var i = -720; i <= 720; i += 1
        {
            let degs = CGFloat(i)
            let rads = CGFloat(i) * CGFloat(M_PI / 180)
            XCTAssert(abs(degs.degreesInRadians - rads) <= epsilon, "\(degs) degrees == \(rads) radians")
            XCTAssert(abs(rads.radiansInDegrees - degs) <= epsilon, "\(rads) radians == \(degs) degrees")
        }
    }

    // Tests that uniform random CGFloats in the closed interval [0, 1] satisfy the properties
    // of a uniform continuous distribution in that interval, namely, that the sample average
    // and sample variance of the generated numbers approach 1/2 and 1/12, respectively.
    func test_randomUniform01()
    {
        let N = 100_000
        let epsilon = CGFloat(1e-2)

        var values = [CGFloat]()
        for i in 1...N { values += [CGFloat.randomUniform01] }

        var avg: CGFloat = 0
        for value in values { avg += value }
        avg /= CGFloat(N)

        let absAvgMinusHalf = abs(avg - CGFloat(0.5))
        XCTAssert(absAvgMinusHalf <= epsilon, "Average of uniform random numbers in [0, 1] not close to 1/2 within a resolution of \(epsilon): abs(average - 1/2) = \(absAvgMinusHalf)")

        var sqStdDev: CGFloat = 0
        for value in values
        { sqStdDev += (value - avg)*(value - avg) }
        sqStdDev /= CGFloat(N)

        let absSqStdDevMinusOneTwelveth = abs(sqStdDev - CGFloat(1.0/12.0))
        XCTAssert(absSqStdDevMinusOneTwelveth <= epsilon, "Variance of uniform random numbers in [0, 1] not close to 1/12 within a resolution of \(epsilon): abs(variance - 1/12) = \(absSqStdDevMinusOneTwelveth)")
    }

    // Tests that uniform random numbers generated by the call
    // CGFloat.randomUniform(a: a, b: b) do, in fact, fall in the closed
    // range [min(a,b), max(a,b)].
    func test_randomUniformMinMax()
    {
        var a = 100 * (CGFloat.randomUniform01 - 2)
        var b = 100 * (CGFloat.randomUniform01 - 2)
        let r = CGFloat.randomUniform(a: a, b: b)

        if a > b { (a,b) = (b,a) }

        XCTAssert(r >= a && r <= b, "Generated uniform random number r = \(r), supposedly in the closed range [\(a), \(b)], is not actually in that range.")
    }
}
