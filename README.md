# CoreGraphicsExt

[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)

CoreGraphicsExt is my personal CoreGraphics toolbox which completes some missing conveniences.

## What This Library Extends With

### Linear Mixing

You can now linear mix CGFloat, CGPoint and CGSize now.

### Geometric Position Detection

You can now check:

- If a `CGPoint` value is inside a circle which is the biggest circle inside the given `CGRect` value.
- If a `CGPoint` value is on the circumference of a circle which is the biggest circle inside the given `CGRect` value.
- If a `CGPoint` value is inside a `CGRect` value.
- If a `CGPoint` value is on the circumference of a `CGRect` value.
- If a `CGRect` value touches an other.

### More Conveniences on Value Creation

You can now create `CGRect` value with:

- Center and size.
- Center, width and height.
- A given CGRect value and optional origin and size.
- `CGPoint` values which require created `CGRect` value to cover.
- `CGRect` values which require created `CGRect` value to cover.

You also can now create `CGRect` value by:

- Swapping width and height.
- Modify a given `CGRect` value’s origin or size.

You can now create `CGPoint` value with:

- Definite proportion and seperated points.

### Integral and Align to Screen Pixel

You can now integral CGFloat, CGPoint, CGSize and CGRect value by accessing their  `integral` property.

You can now algin CGFloat, CGPoint, CGSize and CGRect value to screen pixel by calling `func alignToScreenPixel(policy: ScreenPixelAlignmentPolicy)` function on those value.

### Arithmetic Operation on CGPoint and CGSize Value

You can `+`, `-` a CGPoint value with an other now.
You can `*`, `/` a CGPoint value with a CGFloat value now
You can make a dot product with two CGPoint values now.
You can `+`, `-` a CGSize value with an other now.
You can `*`, `/` a CGSize value with a CGFloat or an Int value now.

### More Functionalities Can Be Found inside The Library

- Get distance between two `CGPoint` values
- Get mid point between two `CGPoint` values
- Get max and min side length of `CGSize` value
- Enumerate each vertex on a `CGRect` value

## License

MIT.
