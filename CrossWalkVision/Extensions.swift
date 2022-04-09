//
//  Extensions.swift
//  CrosswalkVision
//
//  Created by Afraz Siddiqui on 3/18/21.
//

import UIKit
import VideoToolbox

extension UIImage {
    public convenience init?(pixelBuffer: CVPixelBuffer) {
        var cgImage: CGImage?
        VTCreateCGImageFromCVPixelBuffer(pixelBuffer, options: nil, imageOut: &cgImage)

        guard let cgImage = cgImage else {
            return nil
        }

        self.init(cgImage: cgImage)
    }
    /// Resize image
    /// - Parameter size: Size to resize to
    /// - Returns: Resized image
    func resize(size: CGSize) -> UIImage? {
        UIGraphicsBeginImageContext(size)
        draw(in: CGRect(x: 0, y: 0, width: size.width, height: size.height))
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return image
    }

    /// Create and return CoreVideo Pixel Buffer
    /// - Returns: Pixel Buffer
    func getCVPixelBuffer() -> CVPixelBuffer? {
        guard let image = cgImage else {
             return nil
        }
        let imageWidth = Int(image.width)
        let imageHeight = Int(image.height)

        let attributes : [NSObject:AnyObject] = [
            kCVPixelBufferCGImageCompatibilityKey : true as AnyObject,
            kCVPixelBufferCGBitmapContextCompatibilityKey : true as AnyObject
        ]

        var pxbuffer: CVPixelBuffer? = nil
        CVPixelBufferCreate(
            kCFAllocatorDefault,
            imageWidth,
            imageHeight,
            kCVPixelFormatType_32ARGB,
            attributes as CFDictionary?,
            &pxbuffer
        )

        if let _pxbuffer = pxbuffer {
            let flags = CVPixelBufferLockFlags(rawValue: 0)
            CVPixelBufferLockBaseAddress(_pxbuffer, flags)
            let pxdata = CVPixelBufferGetBaseAddress(_pxbuffer)

            let rgbColorSpace = CGColorSpaceCreateDeviceRGB();
            let context = CGContext(
                data: pxdata,
                width: imageWidth,
                height: imageHeight,
                bitsPerComponent: 8,
                bytesPerRow: CVPixelBufferGetBytesPerRow(_pxbuffer),
                space: rgbColorSpace,
                bitmapInfo: CGImageAlphaInfo.premultipliedFirst.rawValue
            )

            if let _context = context {
                _context.draw(
                    image,
                    in: CGRect.init(
                        x: 0,
                        y: 0,
                        width: imageWidth,
                        height: imageHeight
                    )
                )
            }
            else {
                CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
                return nil
            }

            CVPixelBufferUnlockBaseAddress(_pxbuffer, flags);
            return _pxbuffer;
        }

        return nil
    }

    func rotate(radians: Float) -> UIImage? {
        var newSize = CGRect(origin: CGPoint.zero, size: self.size).applying(CGAffineTransform(rotationAngle: CGFloat(radians))).size
        // Trim off the extremely small float value to prevent core graphics from rounding it up
        newSize.width = floor(newSize.width)
        newSize.height = floor(newSize.height)

        UIGraphicsBeginImageContextWithOptions(newSize, false, self.scale)
        let context = UIGraphicsGetCurrentContext()!

        // Move origin to middle
        context.translateBy(x: newSize.width/2, y: newSize.height/2)
        // Rotate around middle
        context.rotate(by: CGFloat(radians))
        // Draw the image at its center
        self.draw(in: CGRect(x: -self.size.width/2, y: -self.size.height/2, width: self.size.width, height: self.size.height))

        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()

        return newImage
    }
}