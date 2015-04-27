//
//  CGVectorExtensionsTests.swift
//  CGExtensionsTests
//
//  Created by Wagner Truppel on 27/12/2014.
//  Copyright (c) 2014 Wagner Truppel. All rights reserved.
//

import XCTest
import Foundation
import CoreGraphics

class CGVectorExtensionsTests: XCTestCase
{
    // Tests that CGVector() creates a vector with both components equal to zero.
    func test_init()
    {
        let v = CGVector()

        XCTAssert(v.dx == CGFloat(0) && v.dy == CGFloat(0), "CGVector() failed to create the zero vector, resulting in \(v)")
    }

    // Tests that CGVector(dx: a, dy: b) creates the correct vector, when both
    // a and b are CGFloats.
    func test_initFromCGFloats()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: a, dy: b)

        XCTAssert(v.dx == a && v.dy == b, "Creating a CGVector instance with CGFloat components dx = \(a) and dy = \(b) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(dx: a, dy: b) creates the correct vector, when both
    // a and b are Floats.
    func test_initFromFloats()
    {
        let a = 100 * Float(CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * Float(CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: a, dy: b)

        XCTAssert(v.dx == CGFloat(a) && v.dy == CGFloat(b), "Creating a CGVector instance with Float components dx = \(a) and dy = \(b) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(vector: v) does in fact generate a CGVector with
    // components dx = v.dx and dy = v.dy.
    func test_initFromCGVector()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let u = CGVector(dx: a, dy: b)

        let v = CGVector(vector: u)

        XCTAssert(v.dx == a && v.dy == b, "Creating a CGVector instance from a CGVector instance with components dx = \(u.dx) and dy = \(u.dy) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(point: p) does in fact generate a CGVector with
    // components dx = p.x and dy = p.y.
    func test_initFromCGPoint()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let v = CGVector(point: p)

        XCTAssert(v.dx == a && v.dy == b, "Creating a CGVector instance from a CGPoint instance with coordinates x = \(p.x) and y = \(p.y) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(fromPoint: A, toPoint: B) does in fact generate a CGVector with
    // components dx = B.x - A.x and dy = B.y - A.y.
    func test_initFromTwoCGPoints()
    {
        let ax = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let ay = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let A = CGPoint(x: ax, y: ay)

        let bx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let by = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let B = CGPoint(x: bx, y: by)

        let v = CGVector(fromPoint: A, toPoint: B)

        XCTAssert(v.dx == bx - ax && v.dy == by - ay, "CGVector(fromPoint: A, toPoint: B), with A = \(A) and B = \(B) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(magnitude: m, radians: a) does in fact generate a CGVector with
    // components dx = m cos(a) and dy = m sin(a).
    func test_initFromMagnitudeAndAngle()
    {
        let m = 100 * CGFloat.randomUniform01
        let a = 720 * (CGFloat.randomUniform01 - CGFloat(0.5))

        let v = CGVector(magnitude: m, radians: a.degreesInRadians)

        XCTAssert(v.dx == m * cos(a.degreesInRadians) && v.dy == m * sin(a.degreesInRadians), "CGVector(magnitude: m, radians: a), with m = \(m) and a = \(a) degrees = \(a.degreesInRadians) radians failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector(magnitude: m, sina: sina, cosa: cosa) does in fact generate
    // a CGVector with components dx = m cosa and dy = m sina.
    func test_initFromMagnitudeSinAndCos()
    {
        let m = 100 * CGFloat.randomUniform01
        let a = 720 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let sina = sin(a.degreesInRadians)
        let cosa = cos(a.degreesInRadians)

        let v = CGVector(magnitude: m, sina: sina, cosa: cosa)

        XCTAssert(v.dx == m * cosa && v.dy == m * sina, "CGVector(magnitude: m, sina: sina, cosa: cosa), with m = \(m), sina = \(sina), and cosa = \(cosa) failed, resulting in the CGVector v = \(v)")
    }

    // Tests the instance method clone().
    func test_clone()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let u = CGVector(dx: a, dy: b)

        let v = u.clone()

        XCTAssert(v.dx == a && v.dy == b, "u.clone(), with u.dx = \(a) and u.dy = \(b) failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector.unitVectorX returns the vector (1, 0).
    func test_unitVectorX()
    {
        let v = CGVector.unitVectorX

        XCTAssert(v.dx == CGFloat(1) && v.dy == CGFloat(0), "CGVector.unitVectorX failed, resulting in the CGVector v = \(v)")
    }

    // Tests that CGVector.unitVectorY returns the vector (0, 1).
    func test_unitVectorY()
    {
        let v = CGVector.unitVectorY

        XCTAssert(v.dx == CGFloat(0) && v.dy == CGFloat(1), "CGVector.unitVectorY failed, resulting in the CGVector v = \(v)")
    }

    // Tests CGVector.randomUniform(a: a, b: b).
    func test_randomUniform()
    {
        var a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        var b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector.randomUniform(a: a, b: b)

        if a > b { (a,b) = (b,a) }

        XCTAssert(v.dx >= a && v.dx <= b && v.dy >= a && v.dy <= b, "CGVector.randomUniform(a: \(a), b: \(b)) failed, resulting in the CGVector v = \(v)")
    }

    // Tests the instance method isZero().
    func test_isZero()
    {
        var u = CGVector.zeroVector
        XCTAssert(u.isZero(), "u.isZero() failed to return true for vector u = \(u)")

        u = CGVector()
        XCTAssert(u.isZero(), "u.isZero() failed to return true for vector u = \(u)")

        u = CGVector(dx: 0, dy: 0)
        XCTAssert(u.isZero(), "u.isZero() failed to return true for vector u = \(u)")

        u = CGVector.randomUniform(a: 2, b: 3)
        XCTAssert(!u.isZero(), "u.isZero() failed to return false for vector u = \(u)")
    }

    // Tests the instance method isEqualTo(other:, within:).
    func test_isEqualToOtherWithinResolution()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var s = CGFloat.randomUniform01
        var expected = true
        var actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")

        u = CGVector.randomUniform(a: 1, b: 2)
        v = u
        s = CGFloat.randomUniform01
        expected = true
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")

        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 1, b: 2)
        s = CGFloat.randomUniform01
        expected = false
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")
        (u,v) = (v,u)
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")

        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        s = sqrt(2)
        expected = true
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")
        (u,v) = (v,u)
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")

        u = CGVector.randomUniform(a: 0, b: 1)
        v = u + CGVector.randomUniform(a: 3, b: 5)
        s = 2
        expected = false
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")
        (u,v) = (v,u)
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")

        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGVector.randomUniform(a: 0, b: 1)
        s = 2
        expected = true
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")
        (u,v) = (v,u)
        actual = u.isEqualTo(v, within: s)
        XCTAssert(actual == expected, "u.isEqualTo(v, within: s) failed to return \(expected) for vectors u = \(u) and v = \(v), and resolution s = \(s)")
    }

    // Tests the instance method isZero(within epsilon: CGFloat).
    func test_isZeroWithinResolution()
    {
        var u = CGVector.randomUniform(a: 0, b: 0.01)
        var nearlyZero = u.isZero(within: 0.015)
        XCTAssert(nearlyZero, "u.isZero(within:) failed to return true for vector u = \(u)")

        u = CGVector.randomUniform(a: 1, b: 2)
        nearlyZero = u.isZero(within: 0.5)
        XCTAssert(!nearlyZero, "u.isZero(within:) failed to return false for vector u = \(u)")
    }

    // Tests the instance method magnitude().
    func test_magnitude()
    {
        let u = CGVector.randomUniform(a: -10, b: 10)
        let expected = sqrt(u.dx * u.dx + u.dy * u.dy)
        let actual = u.magnitude()

        XCTAssert(actual == expected, "u.magnitude() failed to return \(expected) for vector u = \(u). It returned \(actual) instead.")
    }

    // Tests the instance method magnitudeSquared().
    func test_magnitudeSquared()
    {
        let u = CGVector.randomUniform(a: -10, b: 10)
        let expected = (u.dx * u.dx + u.dy * u.dy)
        let actual = u.magnitudeSquared()

        XCTAssert(actual == expected, "u.magnitudeSquared() failed to return \(expected) for vector u = \(u). It returned \(actual) instead.")
    }

    // Tests the instance method isNormalizable().
    func test_isNormalizable()
    {
        var u = CGVector.randomUniform(a: -10, b: 10)
        var expected = true
        var actual = u.isNormalizable()
        XCTAssert(actual == expected, "u.isNormalizable() failed to return \(expected) for vector u = \(u). It returned \(actual) instead.")

        u = CGVector.zeroVector
        expected = false
        actual = u.isNormalizable()
        XCTAssert(actual == expected, "u.isNormalizable() failed to return \(expected) for vector u = \(u). It returned \(actual) instead.")
    }

    // Tests the instance method normalize().
    func test_normalize()
    {
        var u = CGVector.randomUniform(a: 1, b: 5)
        let bx = u.dx
        let by = u.dy
        let v = u.normalize()
        let msq = u.magnitudeSquared()

        XCTAssert(abs(msq - 1) <= CGVector.EPS, "u.normalize() failed to normalize vector u = (\(bx), \(by)). It returned a magnitude squared of \(msq).")

        XCTAssert(v! == u, "u.normalize() failed to return self for vector u = (\(bx), \(by)), after normalization. It returned v = \(v!) instead.")
    }

    // Tests the instance method scaleTo(value:).
    func test_scaleTo()
    {
        var u = CGVector.randomUniform(a: 1, b: 5)
        let bx = u.dx
        let by = u.dy
        let s = CGFloat.randomUniform(a: 1, b: 5)
        let v = u.scaleTo(value: s)
        let m = u.magnitude()
        let ax = u.dx
        let ay = u.dy

        XCTAssert(abs(m - s) <= CGVector.EPS, "u.scaleTo(value: \(s)) failed to scale vector u = (\(bx), \(by)). It returned a magnitude of \(m).")

        XCTAssert(abs(bx/ax - by/ay) <= CGVector.EPS, "u.scaleTo(value: \(s)) failed to scale vector u = (\(bx), \(by)) as the resulting vector, (\(ax), \(ay)), is not parallel to the original vector.")

        XCTAssert(v == u, "u.scaleTo(value: \(s)) failed to return self for vector u = (\(bx), \(by)), after scaling. It returned v = \(v) instead.")
    }

    // Tests the instance method truncateTo(maxValue:).
    func test_truncateTo()
    {
        var u = CGVector.randomUniform(a: 1, b: 5)
        let bx = u.dx
        let by = u.dy
        let mb = u.magnitude()
        let s = CGFloat.randomUniform(a: 3, b: 10)
        let v = u.truncateTo(maxValue: s)
        let ma = u.magnitude()
        let ax = u.dx
        let ay = u.dy

        if mb <= s // no truncation
        {
            XCTAssert(abs(ma - mb) <= CGVector.EPS && abs(ax - bx) <= CGVector.EPS && abs(ay - by) <= CGVector.EPS, "u.truncateTo(maxValue: \(s)) failed to preserve the vector u = (\(bx), \(by)) of magnitude \(mb). It returned a vector v = (\(ax), \(ay)), of magnitude \(ma).")

            XCTAssert(v == u, "u.truncateTo(maxValue: \(s)) failed to return self for vector u = (\(bx), \(by)), in the case of no truncation. It returned v = \(v) instead.")
        }
        else // truncation
        {
            XCTAssert(abs(ma - s) <= CGVector.EPS, "u.truncateTo(maxValue: \(s)) failed to truncate the vector u = (\(bx), \(by)) of magnitude \(mb). It returned a vector v = (\(ax), \(ay)), of magnitude \(ma).")

            XCTAssert(abs(bx/ax - by/ay) <= CGVector.EPS, "u.truncateTo(maxValue: \(s)) failed to truncate the vector u = (\(bx), \(by)) as the resulting vector, (\(ax), \(ay)), is not parallel to the original vector.")

            XCTAssert(v == u, "u.truncateTo(maxValue: \(s)) failed to return self for vector u = (\(bx), \(by)), after truncation. It returned v = \(v) instead.")
        }
    }

    // Tests the instance method dot(with:).
    func test_Dot()
    {
        let u = CGVector.randomUniform(a: 1, b: 5)
        let v = CGVector.randomUniform(a: 1, b: 5)
        let r = u.dot(v)
        let s = v.dot(u)
        let expected = u.dx * v.dx + u.dy * v.dy

        XCTAssert(abs(r - expected) <= CGVector.EPS, "u.dot(v) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(r).")

        XCTAssert(abs(s - expected) <= CGVector.EPS, "v.dot(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(s).")
    }

    // Tests the instance method cross(with:).
    func test_Cross()
    {
        let u = CGVector.randomUniform(a: 1, b: 5)
        let v = CGVector.randomUniform(a: 1, b: 5)
        let r = u.cross(v)
        let s = v.cross(u)
        let expected = u.dx * v.dy - u.dy * v.dx

        XCTAssert(abs(r - expected) <= CGVector.EPS, "u.cross(v) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(r).")

        XCTAssert(abs(s + expected) <= CGVector.EPS, "v.cross(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(s).")
    }

    // Tests the instance method sinAngleFromX().
    func test_sinAngleFromX()
    {
        var u = CGVector.zeroVector
        var actual = u.sinAngleFromX()
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.sinAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.sinAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.sinAngleFromX()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method cosAngleFromX().
    func test_cosAngleFromX()
    {
        var u = CGVector.zeroVector
        var actual = u.cosAngleFromX()
        var expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.cosAngleFromX()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.cosAngleFromX()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.cosAngleFromX()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method tanAngleFromX().
    func test_tanAngleFromX()
    {
        var u = CGVector.zeroVector
        var actual = u.tanAngleFromX()
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.tanAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.tanAngleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.tanAngleFromX()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromX() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method angleFromX().
    func test_angleFromX()
    {
        var u = CGVector.zeroVector
        var actual = u.angleFromX()
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX
        actual = u.angleFromX()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(45).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(135).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX
        actual = u.angleFromX()
        expected = CGFloat(180).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(225).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.angleFromX()
        expected = CGFloat(315).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromX() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")
    }

    // Tests the instance method sinAngleFromY().
    func test_sinAngleFromY()
    {
        var u = CGVector.zeroVector
        var actual = u.sinAngleFromY()
        var expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.sinAngleFromY()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.sinAngleFromY()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.sinAngleFromY()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.sinAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method cosAngleFromY().
    func test_cosAngleFromY()
    {
        var u = CGVector.zeroVector
        var actual = u.cosAngleFromY()
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.cosAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.cosAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.cosAngleFromY()
        expected = -sqrt(2)/CGFloat(2)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.cosAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method tanAngleFromY().
    func test_tanAngleFromY()
    {
        var u = CGVector.zeroVector
        var actual = u.tanAngleFromY()
        var expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        actual = u.tanAngleFromY()
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        actual = u.tanAngleFromY()
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.tanAngleFromY()
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.tanAngleFromY() failed to return the expected value \(expected) for u = \(u). It returned a value of \(actual).")
    }

    // Tests the instance method angleFromY().
    func test_angleFromY()
    {
        var u = CGVector.zeroVector
        var actual = u.angleFromY()
        var expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX
        actual = u.angleFromY()
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(315).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX + CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(45).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX
        actual = u.angleFromY()
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(135).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = -CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(180).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")

        u = CGVector.unitVectorX - CGVector.unitVectorY
        actual = u.angleFromY()
        expected = CGFloat(225).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "u.angleFromY() failed to return the expected value \(expected) (\(expected.radiansInDegrees) degrees) for u = \(u). It returned a value of \(actual) (\(actual.radiansInDegrees) degrees).")
    }

    // Tests the instance method sinAngleFrom(other:).
    func test_sinAngleFromOther()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var actual = v.sinAngleFrom(u)
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.zeroVector
        actual = v.sinAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.zeroVector
        actual = v.sinAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.zeroVector
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.zeroVector
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.sinAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.sinAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")
    }

    // Tests the instance method cosAngleFrom(other:).
    func test_cosAngleFromOther()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var actual = v.cosAngleFrom(u)
        var expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.zeroVector
        actual = v.cosAngleFrom(u)
        expected = CGFloat(1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.zeroVector
        actual = v.cosAngleFrom(u)
        expected = CGFloat(-1)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.zeroVector
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.zeroVector
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.cosAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.cosAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")
    }

    // Tests the instance method tanAngleFrom(other:).
    func test_tanAngleFromOther()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var actual = v.tanAngleFrom(u)
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.zeroVector
        actual = v.tanAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.zeroVector
        actual = v.tanAngleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.zeroVector
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.zeroVector
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.tanAngleFrom(u)
        expected = -CGFloat.infinity
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.tanAngleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")
    }

    // Tests the instance method angleFrom(other:).
    func test_angleFromOther()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var actual = v.angleFrom(u)
        var expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(180).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.zeroVector
        v = CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.zeroVector
        v = -CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v = -CGVector.unitVectorY
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorX
        v = CGVector.zeroVector
        actual = v.angleFrom(u)
        expected = CGFloat(0)
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorX
        v =  CGVector.zeroVector
        actual = v.angleFrom(u)
        expected = CGFloat(180).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.zeroVector
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.zeroVector
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = CGVector.unitVectorY
        v = CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v =  CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u =  CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(90).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")

        u = -CGVector.unitVectorY
        v = -CGVector.unitVectorX
        actual = v.angleFrom(u)
        expected = CGFloat(270).degreesInRadians
        XCTAssert(abs(actual - expected) <= CGVector.EPS, "v.angleFrom(u) failed to return the expected value \(expected) for u = \(u) and v = \(v). It returned a value of \(actual).")
    }

    // Tests the instance method parallelProjectionTo(other:).
    func test_parallelProjectionTo()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = CGVector.zeroVector
        var a = u.parallelProjectionTo(v)
        XCTAssert(a == e, "u.parallelProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        e = CGVector.zeroVector
        a = u.parallelProjectionTo(v)
        XCTAssert(a == e, "u.parallelProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        e = v
        a = v.parallelProjectionTo(u)
        XCTAssert(a == e, "v.parallelProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 0, b: 1)
        v = u
        e = u
        a = u.parallelProjectionTo(v)
        XCTAssert(a == e, "u.parallelProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        e = v
        a = v.parallelProjectionTo(u)
        XCTAssert(a == e, "v.parallelProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGFloat.randomUniform01 * u
        e = u
        a = u.parallelProjectionTo(v)
        XCTAssert(a == e, "u.parallelProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        e = v
        a = v.parallelProjectionTo(u)
        XCTAssert(a == e, "v.parallelProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGFloat.randomUniform01 * CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGFloat.randomUniform01 * CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        e = CGVector.zeroVector
        a = u.parallelProjectionTo(v)
        XCTAssert(a == e, "u.parallelProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.parallelProjectionTo(u)
        XCTAssert(a == e, "v.parallelProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
    }

    // Tests the instance method perpendicularProjectionTo(other:).
    func test_perpendicularProjectionTo()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = CGVector.zeroVector
        var a = u.perpendicularProjectionTo(v)
        XCTAssert(a == e, "u.perpendicularProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        e = CGVector.zeroVector
        a = u.perpendicularProjectionTo(v)
        XCTAssert(a == e, "u.perpendicularProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        e = v
        a = v.perpendicularProjectionTo(u)
        XCTAssert(a == e, "v.perpendicularProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 0, b: 1)
        v = u
        e = CGVector.zeroVector
        a = u.perpendicularProjectionTo(v)
        XCTAssert(a == e, "u.perpendicularProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.perpendicularProjectionTo(u)
        XCTAssert(a == e, "v.perpendicularProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGFloat.randomUniform01 * u
        e = CGVector.zeroVector
        a = u.perpendicularProjectionTo(v)
        XCTAssert(a == e, "u.perpendicularProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.perpendicularProjectionTo(u)
        XCTAssert(a == e, "v.perpendicularProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGFloat.randomUniform01 * CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGFloat.randomUniform01 * CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        e = u
        a = u.perpendicularProjectionTo(v)
        XCTAssert(a == e, "u.perpendicularProjectionTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        e = v
        a = v.perpendicularProjectionTo(u)
        XCTAssert(a == e, "v.perpendicularProjectionTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
    }

    // Tests the instance method isParallelTo(other:).
    func test_isParallelTo()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = true
        var a = u.isParallelTo(v)
        XCTAssert(a == e, "u.isParallelTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        e = true
        a = u.isParallelTo(v)
        XCTAssert(a == e, "u.isParallelTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isParallelTo(u)
        XCTAssert(a == e, "v.isParallelTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 0, b: 1)
        v = u
        e = true
        a = u.isParallelTo(v)
        XCTAssert(a == e, "u.isParallelTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isParallelTo(u)
        XCTAssert(a == e, "v.isParallelTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGFloat.randomUniform01 * u
        e = true
        a = u.isParallelTo(v)
        XCTAssert(a == e, "u.isParallelTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isParallelTo(u)
        XCTAssert(a == e, "v.isParallelTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGFloat.randomUniform01 * CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGFloat.randomUniform01 * CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        e = false
        a = u.isParallelTo(v)
        XCTAssert(a == e, "u.isParallelTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isParallelTo(u)
        XCTAssert(a == e, "v.isParallelTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
    }

    // Tests the instance method isParallelTo(other: within:).
    func test_isParallelToOtherWithinResolution()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var s = CGFloat.randomUniform01
        var e = true
        var a = u.isParallelTo(v, within: s)
        XCTAssert(a == e, "u.isParallelTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        s = CGFloat.randomUniform01
        e = true
        a = u.isParallelTo(v, within: s)
        XCTAssert(a == e, "u.isParallelTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isParallelTo(u, within: s)
        XCTAssert(a == e, "v.isParallelTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 0, b: 1)
        v = u
        s = CGFloat.randomUniform01
        e = true
        a = u.isParallelTo(v, within: s)
        XCTAssert(a == e, "u.isParallelTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isParallelTo(u, within: s)
        XCTAssert(a == e, "v.isParallelTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGFloat.randomUniform01 * u
        s = CGFloat.randomUniform01
        e = true
        a = u.isParallelTo(v, within: s)
        XCTAssert(a == e, "u.isParallelTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isParallelTo(u, within: s)
        XCTAssert(a == e, "v.isParallelTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        s = CGFloat.randomUniform01
        e = false
        a = u.isParallelTo(v, within: s)
        XCTAssert(a == e, "u.isParallelTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isParallelTo(u, within: s)
        XCTAssert(a == e, "v.isParallelTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
    }

    // Tests the instance method isPerpendicularTo(other:).
    func test_isPerpendicularTo()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = true
        var a = u.isPerpendicularTo(v)
        XCTAssert(a == e, "u.isPerpendicularTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        e = true
        a = u.isPerpendicularTo(v)
        XCTAssert(a == e, "u.isPerpendicularTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isPerpendicularTo(u)
        XCTAssert(a == e, "v.isPerpendicularTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 0, b: 1)
        v = u
        e = false
        a = u.isPerpendicularTo(v)
        XCTAssert(a == e, "u.isPerpendicularTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isPerpendicularTo(u)
        XCTAssert(a == e, "v.isPerpendicularTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 0, b: 1)
        v = CGFloat.randomUniform01 * u
        e = false
        a = u.isPerpendicularTo(v)
        XCTAssert(a == e, "u.isPerpendicularTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isPerpendicularTo(u)
        XCTAssert(a == e, "v.isPerpendicularTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGFloat.randomUniform01 * CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGFloat.randomUniform01 * CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        e = true
        a = u.isPerpendicularTo(v)
        XCTAssert(a == e, "u.isPerpendicularTo(v) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
        a = v.isPerpendicularTo(u)
        XCTAssert(a == e, "v.isPerpendicularTo(u) failed to return the expected result \(e) for u = \(u) and v = \(v). It returned a result of \(a).")
    }

    // Tests the instance method isPerpendicularTo(other: within:).
    func test_isPerpendicularToOtherWithinResolution()
    {
        // two zero vectors
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var s = CGFloat.randomUniform01
        var e = true
        var a = u.isPerpendicularTo(v, within: s)
        XCTAssert(a == e, "u.isPerpendicularTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // zero with non-zero
        u = CGVector.zeroVector
        v = CGVector.randomUniform(a: 0, b: 1)
        s = CGFloat.randomUniform01
        e = true
        a = u.isPerpendicularTo(v, within: s)
        XCTAssert(a == e, "u.isPerpendicularTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isPerpendicularTo(u, within: s)
        XCTAssert(a == e, "v.isPerpendicularTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // a vector with itself
        u = CGVector.randomUniform(a: 1, b: 2)
        v = u
        s = CGFloat.randomUniform01
        e = false
        a = u.isPerpendicularTo(v, within: s)
        XCTAssert(a == e, "u.isPerpendicularTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isPerpendicularTo(u, within: s)
        XCTAssert(a == e, "v.isPerpendicularTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // 2 parallel vectors
        u = CGVector.randomUniform(a: 1, b: 2)
        v = CGFloat.randomUniform(a: 1, b: 2) * u
        s = CGFloat.randomUniform01
        e = false
        a = u.isPerpendicularTo(v, within: s)
        XCTAssert(a == e, "u.isPerpendicularTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isPerpendicularTo(u, within: s)
        XCTAssert(a == e, "v.isPerpendicularTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")

        // 2 perpendicular vectors
        let angle = CGFloat.randomUniform01
        u = CGVector.unitVectorX
        u.clockwiseRotate(radians: angle)
        v = CGVector.unitVectorY
        v.clockwiseRotate(radians: angle)
        s = CGFloat.randomUniform01
        e = true
        a = u.isPerpendicularTo(v, within: s)
        XCTAssert(a == e, "u.isPerpendicularTo(v, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
        a = v.isPerpendicularTo(u, within: s)
        XCTAssert(a == e, "v.isPerpendicularTo(u, within s) failed to return the expected result \(e) for u = \(u), v = \(v), and s = \(s). It returned a result of \(a).")
    }

    // Tests the instance methods
    // clockwiseRotate(radians:)
    // clockwiseRotate(sina:, cosa:)
    // counterClockwiseRotate(radians:)
    // counterClockwiseRotate(sina:, cosa:)
    func test_counterClockwiseRotateByAngle()
    {
        var u = CGVector.zeroVector
        var angle = CGFloat.randomUniform01 * CGFloat(360).degreesInRadians
        var e = CGVector.zeroVector
        var a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(0)
        e = u
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(45).degreesInRadians
        e = (CGVector.unitVectorX + CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = (CGVector.unitVectorX - CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(90).degreesInRadians
        e = CGVector.unitVectorY
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = -CGVector.unitVectorY
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(135).degreesInRadians
        e = (-CGVector.unitVectorX + CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = (-CGVector.unitVectorX - CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(180).degreesInRadians
        e = -u
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = -u
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(225).degreesInRadians
        e = (-CGVector.unitVectorX - CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = (-CGVector.unitVectorX + CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(270).degreesInRadians
        e = -CGVector.unitVectorY
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = CGVector.unitVectorY
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")

        u = CGVector.unitVectorX
        angle = CGFloat(315).degreesInRadians
        e = (CGVector.unitVectorX - CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
        u = CGVector.unitVectorX
        angle = -angle
        e = (CGVector.unitVectorX + CGVector.unitVectorY) / sqrt(2)
        a = u.counterClockwiseRotate(radians: angle)
        XCTAssert(a == e, "u.counterClockwiseRotate(radians: angle) failed to return the expected result \(e) for u = \(u) and angle = \(angle) radians = \(angle.radiansInDegrees) degrees. It returned a result of \(a).")
    }

    // Tests the operator +.
    func test_OperatorPlus()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = CGVector.zeroVector
        var a = u + v
        XCTAssert(a == e, "u+v failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")

        u = CGVector.randomUniform(a: -10, b: 10)
        v = CGVector.randomUniform(a: -10, b: 10)
        e = CGVector(dx: u.dx + v.dx, dy: u.dy + v.dy)
        a = u + v
        XCTAssert(a == e, "u+v failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")
        a = v + u
        XCTAssert(a == e, "v+u failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")
    }

    // Tests the operator -.
    func test_OperatorMinus()
    {
        var u = CGVector.zeroVector
        var v = CGVector.zeroVector
        var e = CGVector.zeroVector
        var a = u - v
        XCTAssert(a == e, "u+v failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")

        u = CGVector.randomUniform(a: -10, b: 10)
        v = u
        e = CGVector.zeroVector
        a = u - v
        XCTAssert(a == e, "u-v failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")

        u = CGVector.randomUniform(a: -10, b: 10)
        v = CGVector.randomUniform(a: -10, b: 10)
        e = CGVector(dx: u.dx - v.dx, dy: u.dy - v.dy)
        a = u - v
        XCTAssert(a == e, "u+v failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")
        e = -e
        a = v - u
        XCTAssert(a == e, "v-u failed to return \(e) for vectors u = \(u) and v = \(v), resulting in \(a)")
    }

    // Tests the operators *(CGFloat,CGVector) and *(CGVector,CGFloat).
    func test_OperatorFloatTimesVector()
    {
        var u = CGVector.zeroVector
        var s = CGFloat.randomUniform01
        var e = CGVector.zeroVector
        var a = s * u
        XCTAssert(a == e, "s * u failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
        a = u * s
        XCTAssert(a == e, "u * s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = 0
        e = CGVector.zeroVector
        a = s * u
        XCTAssert(a == e, "s * u failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
        a = u * s
        XCTAssert(a == e, "u * s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = 1
        e = u
        a = s * u
        XCTAssert(a == e, "s * u failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
        a = u * s
        XCTAssert(a == e, "u * s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = -1
        e = -u
        a = s * u
        XCTAssert(a == e, "s * u failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
        a = u * s
        XCTAssert(a == e, "u * s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = CGFloat.randomUniform01
        e = CGVector(dx: s * u.dx, dy: s * u.dy)
        a = s * u
        XCTAssert(a == e, "s * u failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
        a = u * s
        XCTAssert(a == e, "u * s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
    }

    // Tests the operator /(CGVector,CGFloat).
    func test_OperatorVectorDividedByFloat()
    {
        var u = CGVector.zeroVector
        var s = CGFloat.randomUniform01
        var e = CGVector.zeroVector
        var a = u / s
        XCTAssert(a == e, "u / s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = 1
        e = u
        a = u / s
        XCTAssert(a == e, "u / s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = -1
        e = -u
        a = u / s
        XCTAssert(a == e, "u / s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        s = 1 + CGFloat.randomUniform01
        e = CGVector(dx: u.dx / s, dy: u.dy / s)
        a = u / s
        XCTAssert(a == e, "u / s failed to return \(e) for u = \(u) and s = \(s), resulting in \(a)")
    }

    // Tests the operator -(CGVector).
    func test_OperatorUnaryMinus()
    {
        var u = CGVector.zeroVector
        var e = CGVector.zeroVector
        var a = -u
        XCTAssert(a == e, "-u failed to return \(e) for u = \(u), resulting in \(a)")

        u = CGVector.randomUniform(a: 0, b: 1)
        e = CGVector(dx: -u.dx, dy: -u.dy)
        a = -u
        XCTAssert(a == e, "-u failed to return \(e) for u = \(u), resulting in \(a)")
    }

    // Tests the operator +=(CGVector,CGVector).
    func test_OperatorPlusEqual()
    {
        var u = CGVector.zeroVector
        var w = u
        var v = CGVector.zeroVector
        var e = CGVector.zeroVector
        u += v
        XCTAssert(u == e, "u += v failed to return \(e) for vectors u = \(w) and v = \(v), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        v = CGVector.randomUniform(a: -10, b: 10)
        e = CGVector(dx: w.dx + v.dx, dy: w.dy + v.dy)
        u += v
        XCTAssert(u == e, "u += v failed to return \(e) for vectors u = \(w) and v = \(v), resulting in \(u)")
    }

    // Tests the operator -=(CGVector,CGVector).
    func test_OperatorMinusEqual()
    {
        var u = CGVector.zeroVector
        var w = u
        var v = CGVector.zeroVector
        var e = w
        u -= v
        XCTAssert(u == e, "u -= v failed to return \(e) for vectors u = \(w) and v = \(v), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        v = u
        e = CGVector.zeroVector
        u -= v
        XCTAssert(u == e, "u -= v failed to return \(e) for vectors u = \(w) and v = \(v), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        v = CGVector.randomUniform(a: -10, b: 10)
        e = CGVector(dx: w.dx - v.dx, dy: w.dy - v.dy)
        u -= v
        XCTAssert(u == e, "u -= v failed to return \(e) for vectors u = \(w) and v = \(v), resulting in \(u)")
    }

    // Tests the operator *=(CGVector,CGFloat).
    func test_OperatorTimesEqual()
    {
        var u = CGVector.zeroVector
        var w = u
        var s = CGFloat.randomUniform01
        var e = CGVector.zeroVector
        u *= s
        XCTAssert(u == e, "u *= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = 0
        e = CGVector.zeroVector
        u *= s
        XCTAssert(u == e, "u *= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = 1
        e = w
        u *= s
        XCTAssert(u == e, "u *= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = -1
        e = -w
        u *= s
        XCTAssert(u == e, "u *= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = CGFloat.randomUniform01
        e = CGVector(dx: s * w.dx, dy: s * w.dy)
        u *= s
        XCTAssert(u == e, "u *= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")
    }

    // Tests the operator /=(CGVector,CGFloat).
    func test_OperatorDivideEqual()
    {
        var u = CGVector.zeroVector
        var w = u
        var s = 1 + CGFloat.randomUniform01
        var e = CGVector.zeroVector
        u /= s
        XCTAssert(u == e, "u /= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = 1
        e = w
        u /= s
        XCTAssert(u == e, "u /= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = -1
        e = -w
        u /= s
        XCTAssert(u == e, "u /= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")

        u = CGVector.randomUniform(a: -10, b: 10)
        w = u
        s = 1 + CGFloat.randomUniform01
        e = CGVector(dx: w.dx / s, dy: w.dy / s)
        u /= s
        XCTAssert(u == e, "u /= s failed to return \(e) for u = \(w) and s = \(s), resulting in \(u)")
    }
}
