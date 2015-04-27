//
//  CGPointExtensionsTests.swift
//  CGExtensionsTests
//
//  Created by Wagner Truppel on 27/12/2014.
//  Copyright (c) 2014 Wagner Truppel. All rights reserved.
//

import XCTest
import Foundation
import CoreGraphics

class CGPointExtensionsTests: XCTestCase
{
    // Tests that CGPoint(x: a, y: b) does in fact generate a CGPoint with
    // coordinates x = a and y = b, when a and b are Floats.
    func test_initFromFloats()
    {
        let a = 100 * Float(CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * Float(CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        XCTAssert(p.x == CGFloat(a) && p.y == CGFloat(b), "Creating a CGPoint instance with Float coordinates x = \(a) and y = \(b) failed, resulting in a CGPoint instance with actual coordinates p.x = \(p.x) and p.y = \(p.y)")
    }

    // Tests that CGPoint(vector: v) does in fact generate a CGPoint with
    // coordinates x = v.dx and y = v.dy.
    func test_initFromCGVector()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: a, dy: b)
        let p = CGPoint(vector: v)

        XCTAssert(p.x == v.dx && p.y == v.dy, "Creating a CGPoint instance from a CGVector instance with coordinates dx = \(v.dx) and dy = \(v.dy) failed, resulting in a CGPoint instance with actual coordinates p.x = \(p.x) and p.y = \(p.y)")
    }

    // Tests that CGPoint(point: p, vector: v) does in fact generate a CGPoint with
    // coordinates x = p.x + v.dx and y = p.y + v.dy.
    func test_initFromPointAndVector()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let dx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let dy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: dx, dy: dy)

        let q = CGPoint(point: p, vector: v)

        XCTAssert(q.x == p.x + v.dx && q.y == p.y + v.dy, "Creating a CGPoint instance from CGPoint and CGVector instances p = (\(a), \(b)) and v = (\(v.dx), \(v.dy)) failed, resulting in a CGPoint instance with actual coordinates q.x = \(q.x) and q.y = \(q.y)")
    }

    // Tests that CGPoint(point: p, scalar: s, vector: v) does in fact generate a CGPoint with
    // coordinates x = p.x + s * v.dx and y = p.y + s * v.dy.
    func test_initFromPointScalarAndVector()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let s = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))

        let dx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let dy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: dx, dy: dy)

        let q = CGPoint(point: p, scalar: s, vector: v)

        XCTAssert(q.x == p.x + s * v.dx && q.y == p.y + s * v.dy, "Creating a CGPoint instance from CGPoint and CGVector instances p = (\(a), \(b)) and v = (\(v.dx), \(v.dy)), and a scalar s = \(s), failed, resulting in a CGPoint instance with actual coordinates q.x = \(q.x) and q.y = \(q.y)")
    }

    // Tests the operator overloading of == for CGPoints.
    func test_operatorEquals()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let x = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let y = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let q = CGPoint(x: p.x + x, y: p.x + y)

        let    equal: Bool = (p == p) // should be true
        let notEqual: Bool = (p == q) // should be false

        XCTAssert(equal && !notEqual, "Either the equality of p(\(p.x), \(p.y)) to itself or the inequality of p to q(\(q.x), \(q.y)) failed when using the == operator.")
    }

    // Tests the operator overloading of + for CGPoints, which adds a point to a vector
    // and returns a point.
    func test_operatorPointPlusVector()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let dx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let dy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: dx, dy: dy)

        let u = p + v

        XCTAssert(u.x == a + dx && u.y == b + dy, "u = p + v failed for p = (\(a), \(b)) and v = (\(dx), \(dy))")
    }

    // Tests the operator overloading of + for CGPoints, which adds a point to a vector
    // and returns a point.
    func test_operatorVectorPlusPoint()
    {
        let a = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let b = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let p = CGPoint(x: a, y: b)

        let dx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let dy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: dx, dy: dy)

        let u = v + p

        XCTAssert(u.x == a + dx && u.y == b + dy, "u = v + p failed for p = (\(a), \(b)) and v = (\(dx), \(dy))")
    }

    // Tests the operator overloading of - for CGPoints, which subtracts two points
    // and returns a vector.
    func test_operatorPointMinusPoint()
    {
        let px = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let py = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let P = CGPoint(x: px, y: py)

        let qx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let qy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let Q = CGPoint(x: qx, y: qy)

        let v = Q - P // should be a vector from point P to point Q

        XCTAssert(v.dx == qx - px && v.dy == qy - py, "v = Q - P failed for P = (\(px), \(py)) and Q = (\(qx), \(qy))")
    }

    // Tests the operator overloading of += for CGPoints, which adds a vector to the
    // receiver point.
    func test_operatorPlusEqual()
    {
        let px = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let py = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        var P = CGPoint(x: px, y: py)

        let dx = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let dy = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let v = CGVector(dx: dx, dy: dy)

        P += v // should change P

        XCTAssert(P.x == px + dx && P.y == py + dy, "P += v failed for P = (\(px), \(py)) and v = (\(dx), \(dy))")
    }

    // Tests the implementation of the Hashable interface for CGPoints.
    func test_Hashable()
    {
        let px = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let py = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let P = CGPoint(x: px, y: py)

        let expected = px.hashValue ^ py.hashValue
        let   actual = P.hashValue

        XCTAssert(actual == expected, "P.hashValue failed for P = (\(px), \(py)): expected \(expected) but found \(actual)")
    }

    // Tests the implementation of the Printable interface for CGPoints.
    func test_Printable()
    {
        let px = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let py = 100 * (CGFloat.randomUniform01 - CGFloat(0.5))
        let P = CGPoint(x: px, y: py)

        let expected = "(x: \(px), y: \(py))"
        let   actual = P.description

        XCTAssert(actual == expected, "description failed for P = (\(px), \(py)): expected '\(expected)' but found '\(actual)'")
    }
}
