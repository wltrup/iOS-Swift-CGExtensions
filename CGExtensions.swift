/*
CGExtensions.swift
CGExtensions

Created by Wagner Truppel on 27/12/2014.

The MIT License (MIT)

Copyright (c) 2014 Wagner Truppel (wagner@restlessbrain.com).

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.

When crediting me (Wagner Truppel) for this work, please use one
of the following two suggested formats:

Uses "CGExtensions" code by Wagner Truppel
http://www.restlessbrain.com/wagner/

or

CGExtensions code by Wagner Truppel
http://www.restlessbrain.com/wagner/

Where possible, a hyperlink to http://www.restlessbrain.com/wagner/
would be appreciated.
*/

import Foundation
import CoreGraphics
import UIKit


// ================================================= //
// ==================== CGFloat ==================== //
// ================================================= //

public extension CGFloat
{
    // Usage: CGFloat(90).degreesInRadians and CGFloat(M_PI).radiansInDegrees, etc
    public var radiansInDegrees: CGFloat { return self * CGFloat(180.0 / M_PI) }
    public var degreesInRadians: CGFloat { return self * CGFloat(M_PI / 180.0) }

    // Returns a uniformly distributed random CGFloat in the range [0, 1].
    public static var randomUniform01: CGFloat
    { return CGFloat(arc4random_uniform(UInt32.max)) / CGFloat(UInt32.max - 1) }

    // Returns a uniformly distributed random CGFloat in the range [min(a,b), max(a,b)].
    public static func randomUniform(#a: CGFloat, b: CGFloat) -> CGFloat
    { return a + (b - a) * CGFloat.randomUniform01 }

    // Returns a uniformly distributed random boolean.
    public static var randomBool: Bool
    { return CGFloat.randomUniform01 <= 0.5 }
}


// ================================================= //
// ==================== CGPoint ==================== //
// ================================================= //

public extension CGPoint
{
    // Initializes the receiver with Float values
    public init(x: Float, y: Float)
    {
        self.x = CGFloat(x)
        self.y = CGFloat(y)
    }

    // Initializes the receiver with the components from a CGVector instance.
    public init(vector: CGVector)
    {
        x = vector.dx
        y = vector.dy
    }

    // Initializes the receiver with the value (point + vector).
    public init(point: CGPoint, vector: CGVector)
    {
        x = point.x + vector.dx
        y = point.y + vector.dy
    }

    // Initializes the receiver with the value (point + scalar*vector).
    public init(point: CGPoint, scalar: CGFloat, vector: CGVector)
    {
        x = point.x + scalar * vector.dx
        y = point.y + scalar * vector.dy
    }

    // Returns the distance between the receiver and another point.
    public func distanceTo(other: CGPoint) -> CGFloat
    { return (self - other).magnitude() }

    // Returns the square of the distance between the receiver and another point.
    public func distanceSquaredTo(other: CGPoint) -> CGFloat
    { return (self - other).magnitudeSquared() }
}

public func ==(lhs: CGPoint, rhs: CGPoint) -> Bool
{ return (lhs.x == rhs.x && lhs.y == rhs.y) }

public func +(lhs: CGPoint, rhs: CGVector) -> CGPoint
{ return CGPoint(point: lhs, vector: rhs) }

public func +(lhs: CGVector, rhs: CGPoint) -> CGPoint
{ return CGPoint(point: rhs, vector: lhs) }

public func -(lhs: CGPoint, rhs: CGPoint) -> CGVector
{ return CGVector(fromPoint: rhs, toPoint: lhs) }

public func +=(inout lhs: CGPoint, rhs: CGVector)
{ lhs = lhs + rhs }

extension CGPoint: Hashable
{
    public var hashValue: Int
    { return x.hashValue ^ y.hashValue }
}

extension CGPoint: Printable
{
    public var description: String
    { return "(x: \(x), y: \(y))" }
}


// ================================================== //
// ==================== CGVector ==================== //
// ================================================== //

public extension CGVector
{
    private static let ZERO = CGFloat(0)
    private static let  ONE = CGFloat(1)
    public  static let  EPS = CGFloat(1e-12)

    // Initializes the receiver to the zero vector.
    public init()
    {
        dx = CGVector.ZERO
        dy = CGVector.ZERO
    }

    // Initializes the receiver with the given CGFloat components.
    public init(dx: CGFloat, dy: CGFloat)
    {
        self.dx = dx
        self.dy = dy
    }

    // Initializes the receiver with the given Float components.
    public init(dx: Float, dy: Float)
    {
        self.dx = CGFloat(dx)
        self.dy = CGFloat(dy)
    }

    // Initializes the receiver with the components from another CGVector instance.
    public init(vector: CGVector)
    {
        dx = vector.dx
        dy = vector.dy
    }

    // Initializes the receiver with the components from a CGPoint (referred to some origin).
    public init(point: CGPoint)
    {
        dx = point.x
        dy = point.y
    }

    // Initializes the receiver with the components from a vector going from point A to point B.
    public init(fromPoint: CGPoint, toPoint: CGPoint)
    {
        dx = toPoint.x - fromPoint.x
        dy = toPoint.y - fromPoint.y
    }

    // Initializes the receiver with a magnitude and an angle (in radians) from the X axis.
    public init(magnitude m: CGFloat, radians a: CGFloat)
    {
        assert(m >= CGVector.ZERO, "Attempt to initialize a vector with a negative magnitude.")

        dx = m * cos(a)
        dy = m * sin(a)
    }

    // Initializes the receiver with a magnitude and an angle from the X axis, given the
    // angle's sine and cosine.
    public init(magnitude m: CGFloat, sina: CGFloat, cosa: CGFloat)
    {
        assert(m >= CGVector.ZERO, "Attempt to initialize a vector with a negative magnitude.")

        dx = m * cosa
        dy = m * sina
    }

    // Returns a copy of the receiver. Useful for chaining.
    public func clone() -> CGVector
    { return self } // it's sufficient to return self since CGVector is a struct (thus a value type).

    // Returns a unit vector along the X direction.
    public static var unitVectorX: CGVector
    { return CGVector(dx: CGVector.ONE, dy: CGVector.ZERO) }

    // Returns a unit vector along the Y direction.
    public static var unitVectorY: CGVector
    { return CGVector(dx: CGVector.ZERO, dy: CGVector.ONE) }

    // Returns a vector where each component is a uniform random number in the interval [min(a,b), max(a,b)].
    public static func randomUniform(#a: CGFloat, b: CGFloat) -> CGVector
    {
        let vx = CGFloat.randomUniform(a: a, b: b)
        let vy = CGFloat.randomUniform(a: a, b: b)
        return CGVector(dx: vx, dy: vy)
    }

    // Returns whether or not the receiver equals the zero vector.
    public func isZero() -> Bool
    { return (self == CGVector.zeroVector) }

    // Returns whether or not the receiver equals the zero vector, within a given resolution. More specifically,
    // returns whether or not the receiver's magnitude is within the given resolution.
    public func isZero(within epsilon: CGFloat) -> Bool
    {
        assert(epsilon >= 0, "Resolution must be non-negative.")
        return (magnitudeSquared() <= epsilon*epsilon)
    }

    // Returns whether or not the receiver equals another vector, within a given resolution. More specifically,
    // returns whether or not the magnitude of the difference between the two vectors is within the given resolution.
    public func isEqualTo(other: CGVector, within epsilon: CGFloat) -> Bool
    {
        assert(epsilon >= 0, "Resolution must be non-negative.")
        return (self - other).magnitudeSquared() <= epsilon*epsilon
    }

    // Returns the receiver's magnitude.
    public func magnitude() -> CGFloat
    { return sqrt(dx*dx + dy*dy) }

    // Returns the square of the receiver's magnitude.
    public func magnitudeSquared() -> CGFloat
    { return (dx*dx + dy*dy) }

    // Returns whether or not the vector can be normalized.
    public func isNormalizable() -> Bool
    { return (self != CGVector.zeroVector) }

    // Attempts to normalize the receiver. Returns the modified receiver,
    // if normalized, or nil, if not.
    public mutating func normalize() -> CGVector?
    {
        let m = magnitude()

        if m == CGVector.ZERO
        { return nil }
        else
        {
            dx /= m
            dy /= m
            return self
        }
    }

    // Maintains the receiver's direction but changes its magnitude to the desired
    // value. If the desired value is negative, reverses the receiver's direction
    // as well. Returns the modified receiver.
    public mutating func scaleTo(#value: CGFloat) -> CGVector
    {
        let m = magnitude()
        if m > 0 { self *= (value / m) }
        return self
    }

    // If the magnitude of the receiver is larger than maxValue, then
    // scale it back to maxValue. Otherwise, do nothing. Returns the modified receiver.
    public mutating func truncateTo(#maxValue: CGFloat) -> CGVector
    {
        assert(maxValue >= 0, "Attempt to truncate vector to a negative magnitude")

        let m = magnitude()
        if m > maxValue { self *= (maxValue / m) }
        return self
    }

    // Returns the dot product of the receiver with the given vector.
    public func dot(with: CGVector) -> CGFloat
    { return (dx * with.dx + dy * with.dy) }

    // Returns the cross product of the receiver with the given vector, in that order.
    public func cross(with: CGVector) -> CGFloat
    { return (dx * with.dy - dy * with.dx) }

    // Returns the sine of the oriented angle from the X axis to the receiver.
    // Returns 0 if the receiver is the zero vector.
    public func sinAngleFromX() -> CGFloat
    {
        let m = magnitude()
        if m == CGVector.ZERO
        { return CGVector.ZERO }
        else
        { return dy/m }
    }

    // Returns the cosine of the oriented angle from the X axis to the receiver.
    // Returns 1 if the receiver is the zero vector.
    public func cosAngleFromX() -> CGFloat
    {
        let m = magnitude()
        if m == CGVector.ZERO
        { return CGVector.ONE }
        else
        { return dx/m }
    }

    // Returns the tangent of the oriented angle from the X axis to the receiver.
    // Returns the value sign(Y component) * CGFloat.infinity if the receiver
    // has no X component. Note that it returns 0 for the zero vector.
    public func tanAngleFromX() -> CGFloat
    {
        if dx == CGVector.ZERO
        {
            if dy > CGVector.ZERO
            { return CGFloat.infinity }
            else if dy < CGVector.ZERO
            { return -CGFloat.infinity }
            else
            { return CGVector.ZERO }
        }
        else
        { return dy/dx }
    }

    // Returns the oriented angle (in radians) from the X axis to the receiver,
    // in the semi-closed range [0, 2π). Returns 0 if the receiver is the zero
    // vector.
    public func angleFromX() -> CGFloat
    {
        var a = atan2(dy, dx)
        if a < 0 { a += CGFloat(360).degreesInRadians }
        assert(a >= 0 && a < CGFloat(360).degreesInRadians, "Angle not in [0, 2π)")
        return a
    }

    // Returns the sine of the oriented angle from the Y axis to the receiver.
    // Returns -1 if the receiver is the zero vector.
    public func sinAngleFromY() -> CGFloat
    { return -cosAngleFromX() } // Note the negative sign!

    // Returns the cosine of the oriented angle from the Y axis to the receiver.
    // Returns 0 if the receiver is the zero vector.
    public func cosAngleFromY() -> CGFloat
    { return sinAngleFromX() } // Note: NO negative sign!

    // Returns the tangent of the oriented angle from the Y axis to the receiver.
    // Returns the value -sign(X component) * CGFloat.infinity if the receiver
    // has no Y component. Note that it returns -CGFloat.infinity for the zero
    // vector.
    public func tanAngleFromY() -> CGFloat
    {
        if dy == CGVector.ZERO
        {
            if dx >= CGVector.ZERO
            { return -CGFloat.infinity }
            else
            { return CGFloat.infinity }
        }
        else
        { return -dx/dy }
    }

    // Returns the oriented angle (in radians) from the Y axis to the receiver,
    // in the semi-closed range [0, 2π). Returns 3π/2 if the receiver is the
    // zero vector.
    public func angleFromY() -> CGFloat
    {
        let a = (angleFromX() + CGFloat(270).degreesInRadians) % CGFloat(360).degreesInRadians
        assert(a >= 0 && a < CGFloat(360).degreesInRadians, "Angle not in [0, 2π)")
        return a
    }

    // Returns the sine of the oriented angle from another vector to the receiver.
    // In order to be consistent with other such conventions used so far, we must
    // have:
    // sin[angle(zero ->    u)] = +u.sinAngleFromX()
    // sin[angle(   u -> zero)] = -u.sinAngleFromX()
    // sin[angle(zero -> zero)] =  0
    public func sinAngleFrom(other: CGVector) -> CGFloat
    {
        let thisa =  self.angleFromX()
        let thata = other.angleFromX()
        return sin(thisa - thata)
    }

    // Returns the cosine of the oriented angle from another vector to the receiver.
    // In order to be consistent with other such conventions used so far, we must
    // have:
    // cos[angle(zero ->    u)] = +u.cosAngleFromX()
    // cos[angle(   u -> zero)] = +u.cosAngleFromX()
    // cos[angle(zero -> zero)] = +1
    public func cosAngleFrom(other: CGVector) -> CGFloat
    {
        let thisa =  self.angleFromX()
        let thata = other.angleFromX()
        return cos(thisa - thata)
    }

    // Returns the tangent of the oriented angle from another vector to the receiver.
    public func tanAngleFrom(other: CGVector) -> CGFloat
    {
        if other.dot(self) == 0
        {
            let c = other.cross(self)

            if c > 0
            { return CGFloat.infinity }
            else if c < 0
            { return -CGFloat.infinity }
            else
            {
                // At least one of the vectors is the zero vector.

                if self == CGVector.zeroVector
                {
                    if other == CGVector.zeroVector
                    { return 0 }
                    else
                    { return -other.tanAngleFromX() }
                }
                else // other is the zero vector
                { return self.tanAngleFromX() }
            }
        }
        else
        {
            let thisa =  self.angleFromX()
            let thata = other.angleFromX()
            return tan(thisa - thata)
        }
    }

    // Returns the oriented angle (in radians) from another vector to the receiver,
    // in the semi-closed range [0, 2π).
    public func angleFrom(other: CGVector) -> CGFloat
    {
        let thisa =  self.angleFromX()
        let thata = other.angleFromX()

        var a: CGFloat = 0
        if thisa >= thata
        { a = thisa - thata }
        else
        { a = thisa - thata + CGFloat(360).degreesInRadians }

        assert(a >= 0 && a < CGFloat(360).degreesInRadians, "Angle not in [0, 2π)")
        return a
    }

    // Returns a vector whose magnitude is the projection of the receiver onto the given vector and whose
    // direction is the direction of the given vector. In other words, this method extracts from the receiver
    // a vector that's parallel to the given vector. If the given vector is the zero vector, then returns a
    // copy of the receiver (since, by convention, any vector is parallel to the zero vector).
    public func parallelProjectionTo(other: CGVector) -> CGVector
    {
        if self == CGVector.zeroVector || other == CGVector.zeroVector
        { return self } // it's sufficient to return self since CGVector is a struct (thus a value type).
        else
        { return (self.dot(other) / other.magnitudeSquared()) * other }
    }

    // Returns a vector whose magnitude is the projection of the receiver onto a direction perpendicular to
    // the given vector and whose direction is the direction perpendicular to that of the given vector.
    // In other words, this method extracts from the receiver a vector that's perpendicular to the given vector.
    // If the given vector is the zero vector, then returns a copy of the receiver (since, by convention, any
    // vector is perpendicular to the zero vector).
    public func perpendicularProjectionTo(other: CGVector) -> CGVector
    {
        if self == CGVector.zeroVector || other == CGVector.zeroVector
        { return self } // it's sufficient to return self since CGVector is a struct (thus a value type).
        else
        { return (self - self.parallelProjectionTo(other)) }
    }

    // Returns true when the receiver and the given vector are parallel. Always returns true if either vector
    // is the zero vector (since, by convention, any vector is parallel to the zero vector).
    public func isParallelTo(other: CGVector) -> Bool
    { return (abs(self.cross(other)) <= CGVector.EPS) }

    // Returns true when the receiver and the given vector are parallel, within a given resolution, by comparing
    // the magnitude of their cross product with the given resolution. Always returns true if either vector
    // is the zero vector (since, by convention, any vector is parallel to the zero vector).
    public func isParallelTo(other: CGVector, within epsilon: CGFloat) -> Bool
    {
        assert(epsilon >= 0, "Resolution must be non-negative.")
        return (abs(self.cross(other)) <= epsilon)
    }

    // Returns true when the receiver and the given vector are perpendicular. Always returns true if either vector
    // is the zero vector (since, by convention, any vector is perpendicular to the zero vector).
    public func isPerpendicularTo(other: CGVector) -> Bool
    { return (abs(self.dot(other)) <= CGVector.EPS) }

    // Returns true when the receiver and the given vector are perpendicular, within a given resolution, by comparing
    // the magnitude of their dot product with the given resolution. Always returns true if either vector
    // is the zero vector (since, by convention, any vector is perpendicular to the zero vector).
    public func isPerpendicularTo(other: CGVector, within epsilon: CGFloat) -> Bool
    {
        assert(epsilon >= 0, "Resolution must be non-negative.")
        return (abs(self.dot(other)) <= epsilon)
    }

    // Rotates the receiver clockwise around the z axis by the given angle, in radians.
    // Returns the modified receiver.
    public mutating func clockwiseRotate(#radians: CGFloat) -> CGVector
    { return self.counterClockwiseRotate(sina: -sin(radians), cosa: cos(radians)) }

    // Rotates the receiver clockwise around the z axis by an angle whose
    // sine and cosine are the given values. Returns the modified receiver.
    public mutating func clockwiseRotate(#sina: CGFloat, cosa: CGFloat) -> CGVector
    { return self.counterClockwiseRotate(sina: -sina, cosa: cosa) }

    // Rotates the receiver counter-clockwise around the z axis by the given angle, in radians.
    // Returns the modified receiver.
    public mutating func counterClockwiseRotate(#radians: CGFloat) -> CGVector
    { return self.counterClockwiseRotate(sina: sin(radians), cosa: cos(radians)) }

    // Rotates the receiver counter-clockwise around the z axis by an angle whose
    // sine and cosine are the given values. Returns the modified receiver.
    public mutating func counterClockwiseRotate(#sina: CGFloat, cosa: CGFloat) -> CGVector
    {
        let tx = dx * cosa - dy * sina
        let ty = dy * cosa + dx * sina

        dx = tx
        dy = ty

        return self
    }
}

public func ==(lhs: CGVector, rhs: CGVector) -> Bool
{ return (abs(lhs.dx - rhs.dx) <= CGVector.EPS && abs(lhs.dy - rhs.dy) <= CGVector.EPS) }

public func +(lhs: CGVector, rhs: CGVector) -> CGVector
{
    let vx = lhs.dx + rhs.dx
    let vy = lhs.dy + rhs.dy
    return CGVector(dx: vx, dy: vy)
}

public func -(lhs: CGVector, rhs: CGVector) -> CGVector
{
    let vx = lhs.dx - rhs.dx
    let vy = lhs.dy - rhs.dy
    return CGVector(dx: vx, dy: vy)
}

public func *(lhs: CGFloat, rhs: CGVector) -> CGVector
{
    let vx = lhs * rhs.dx
    let vy = lhs * rhs.dy
    return CGVector(dx: vx, dy: vy)
}

public func *(lhs: CGVector, rhs: CGFloat) -> CGVector
{
    let vx = lhs.dx * rhs
    let vy = lhs.dy * rhs
    return CGVector(dx: vx, dy: vy)
}

public func /(lhs: CGVector, rhs: CGFloat) -> CGVector
{
    assert(rhs != CGVector.ZERO, "Attempt to divide a vector by 0")

    let vx = lhs.dx / rhs
    let vy = lhs.dy / rhs
    return CGVector(dx: vx, dy: vy)
}

public prefix func -(vector: CGVector) -> CGVector
{ return CGVector(dx: -vector.dx, dy: -vector.dy) }

public func +=(inout lhs: CGVector, rhs: CGVector)
{ lhs = lhs + rhs }

public func -=(inout lhs: CGVector, rhs: CGVector)
{ lhs = lhs - rhs }

public func *=(inout lhs: CGVector, rhs: CGFloat)
{ lhs = lhs * rhs }

public func /=(inout lhs: CGVector, rhs: CGFloat)
{ lhs = lhs / rhs }

extension CGVector: Hashable
{
    public var hashValue: Int
    { return dx.hashValue ^ dy.hashValue }
}

extension CGVector: Printable
{
    public var description: String
    { return "(dx: \(dx), dy: \(dy), mag: \(magnitude()))" }
}


// ================================================= //
// ==================== UIColor ==================== //
// ================================================= //

public extension UIColor
{
    static func randomColor() -> UIColor
    {
        let r = CGFloat.randomUniform01
        let g = CGFloat.randomUniform01
        let b = CGFloat.randomUniform01
        return UIColor(red: r, green: g, blue: b, alpha: 1.0)
    }
}


// ==================================================== //
// ==================== CGGradient ==================== //
// ==================================================== //

extension CGGradient
{
    // The locations array need not be sorted in ascending order, nor normalized to the range [0,1].
    static func gradientWithColors(colors: [UIColor], atLocations locations: [CGFloat],
        colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) -> CGGradient
    {
        let numLocations: size_t = locations.count
        assert(numLocations > 1, "numLocations < 2: A gradient requires at least 2 location-color pairs.")
        assert(colors.count == locations.count,
            "colors.count != locations.count: A gradient requires an equal number of locations and colors")

        var tuples = [(CGFloat, UIColor)]()
        for i in 0..<locations.count
        { tuples.append( (locations[i], colors[i]) ) }

        var sortedTuples = sorted(tuples) { $0.0 <= $1.0 }
        let minValue = sortedTuples[0].0
        let maxValue = sortedTuples.last!.0
        let deltaValue = maxValue - minValue
        assert(deltaValue != 0, "Minimum (\(minValue)) and maximum (\(maxValue)) location values must be different.")

        var normalizedLocations = [CGFloat]()
        var colorComponents = [CGFloat]()
        for (location, color) in sortedTuples
        {
            normalizedLocations.append((location - minValue) / deltaValue)

            var r: CGFloat = 0; var g: CGFloat = 0
            var b: CGFloat = 0; var a: CGFloat = 0
            let success = color.getRed(&r, green: &g, blue: &b, alpha: &a)

            assert(success, "color \(color) is not compatible with RGB color space")

            colorComponents.append(r); colorComponents.append(g)
            colorComponents.append(b); colorComponents.append(a)
        }

        return CGGradientCreateWithColorComponents(colorSpace, colorComponents, normalizedLocations, numLocations)
    }
}
