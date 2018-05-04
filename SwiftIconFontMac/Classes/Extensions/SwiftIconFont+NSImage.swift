//
//  SwiftIconFont+UIImage.swift
//  SwiftIconFont
//
//  Created by Sedat Gökbek ÇİFTÇİ on 13.10.2017.
//  Copyright © 2017 Sedat Gökbek ÇİFTÇİ. All rights reserved.
//

import Foundation
import Cocoa

/// Taken from FontAwesome.io's Fixed Width Icon CSS.
public let FontAspectRatio: CGFloat = 1.28571429

public extension NSImage
{
    
    /// Get an image with the given font, icon name, text color, size and an optional background color.
    ///
    /// - parameter font: The preferred font.
    /// - parameter code: The preferred icon code.
    /// - parameter textColor: The text color.
    /// - parameter size: The image size.
    /// - parameter backgroundColor: The background color (optional).
    /// - returns: A string that will appear as icon with FontAwesome
    public convenience init(from font: Fonts, code: String, textColor: NSColor, size: CGSize, backgroundColor: NSColor = NSColor.clear, borderWidth: CGFloat = 0, borderColor: NSColor = NSColor.clear) {
        
        // Prevent application crash when passing size where width or height is set equal to or less than zero, by clipping width and height to a minimum of 1 pixel.
        var size = size
        if size.width <= 0 { size.width = 1 }
        if size.height <= 0 { size.height = 1 }
        
        let paragraph = NSMutableParagraphStyle()
        paragraph.alignment = NSTextAlignment.center
        
        let fontSize = min(size.width / FontAspectRatio, size.height)
        
        // stroke width expects a whole number percentage of the font size
        let strokeWidth: CGFloat = fontSize == 0 ? 0 : (-100 * borderWidth / fontSize)
        
        let attributedString = NSAttributedString(string: String.getIcon(from: font, code: code)!, attributes: [
            NSAttributedStringKey.font: NSFont.icon(from: font, ofSize: fontSize),
            NSAttributedStringKey.foregroundColor: textColor,
            NSAttributedStringKey.backgroundColor: backgroundColor,
            NSAttributedStringKey.paragraphStyle: paragraph,
            NSAttributedStringKey.strokeWidth: strokeWidth,
            NSAttributedStringKey.strokeColor: borderColor
        ])
        
        let rect: NSRect = NSRect(x: 0, y: (size.height - fontSize) / 2, width: size.width, height: fontSize)
        let image = NSImage(size: rect.size)
        image.lockFocus()
        attributedString.draw(in: rect)
        image.unlockFocus()
        
        if let image: NSImage = image {
            var imageRect:CGRect = NSRect(x: 0, y: 0, width: image.size.width, height: image.size.height);
            let imageRef = image.cgImage(forProposedRect: &imageRect, context: nil, hints: nil)
            self.init(cgImage: imageRef!, size: image.size)
        }else{
            self.init()
        }
    }
    
    /// Get a FontAwesome image with the given icon css code, text color, size and an optional background color.
    ///
    /// - parameter font: The preferred font.
    /// - parameter code: The preferred icon code.
    /// - parameter textColor: The text color.
    /// - parameter size: The image size.
    /// - parameter backgroundColor: The background color (optional).
    /// - returns: A string that will appear as icon with FontAwesome
    public static func icon(from font: Fonts, code: String, textColor: NSColor, size: CGSize, backgroundColor: NSColor = NSColor.clear, borderWidth: CGFloat = 0, borderColor: NSColor = NSColor.clear) -> NSImage {
        return self.init(from: font, code:code, textColor: textColor, size: size, backgroundColor: backgroundColor, borderWidth: borderWidth, borderColor: borderColor)
    }
}
