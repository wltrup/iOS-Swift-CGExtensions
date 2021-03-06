# CGExtensions
A `Swift` collection of useful extensions to `CGFloat`, `CGPoint`, `CGVector`, and `CGGradient`, plus test suites. If you need 2-dimensional vectors then you'll want this.

## IMPORTANT
2016.12.03: This project has been **deprecated** and replaced by separate libraries compatible with Swift 3.0. Please refer to [WTOpenSource](https://github.com/wltrup/WTOpenSource).

## Latest

**2015.05.05:** Added an extension to `CGGradient` to make it easier to create gradients from `UIColor` and corresponding location arrays. The extension defines the static method

```swift
static func gradientWithColors(colors: [UIColor], atLocations locations: [CGFloat],
        colorSpace: CGColorSpace = CGColorSpaceCreateDeviceRGB()) -> CGGradient
```

The location array doesn't even need to be in ascending order of its values nor do those values need to be in the range [0,1]. That's all taken care of automatically. Note that the `colorSpace` parameter is optional, with a default value appropriate for `iOS` devices.

## Why?

If you look at the definition of `CGFloat`, you'll find quite a few `init` methods, some properties, and some extensions but if you look at `CGPoint` and `CGVector` you'll see that they leave much to be desired. In fact, if you do any two-dimensional game development then you know that `CGVector` - as defined - is no vector at all!

```swift
    /* Points. */

    struct CGPoint {
        var x: CGFloat
        var y: CGFloat
        init()
        init(x: CGFloat, y: CGFloat)
    }

    extension CGPoint {
        static var zeroPoint: CGPoint { get }
        init(x: Int, y: Int)
        init(x: Double, y: Double)
    }

    extension CGPoint : Equatable {
    }

    extension CGPoint : Reflectable {

        /// Returns a mirror that reflects `self`.
        func getMirror() -> MirrorType
    }

    /* Vectors. */

    var CGVECTOR_DEFINED: Int32 { get }

    struct CGVector {
        var dx: CGFloat
        var dy: CGFloat
        init()
        init(dx: CGFloat, dy: CGFloat)
    }

    extension CGVector {
        static var zeroVector: CGVector { get }
        init(dx: Int, dy: Int)
        init(dx: Double, dy: Double)
    }

    extension CGVector : Equatable {
    }
```

Well, not anymore. I've put together a comprehensive suite of methods for 2d vector manipulations, everything from addition of a vector to a point, to dot and cross products, to rotations. And, best of all, these have been extensively tested, as the accompanying test suites will attest.

## How to install:

Just copy the source file `CGExtensions.swift` into your project. That's it. No frameworks.

## Requirements:

I wrote this using an earlier version of XCode and Swift but I've now verified that these work fine with **Xcode 6.3 (6D570)** and **Swift 1.2**.

## Test app:

There's no test app but there are test suites.

## Creator

That would be me, _Wagner Truppel_. If you need or want to contact me, send a message to `wagner` at `restlessbrain` dot com.

## License:

I'm sharing this work under the **MIT License**. See the LICENSE file for more information.
