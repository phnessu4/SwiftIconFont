//
//  FontLoader.swift
//  SwiftIconFont
//
//  Created by Sedat Ciftci on 18/03/16.
//  Copyright © 2016 Sedat Gokbek Ciftci. All rights reserved.
//

import Cocoa
import Foundation
import CoreText

class FontLoader: NSObject {
    class func loadFont(_ fontName: String) {
        let bundle = Bundle(for: FontLoader.self)
        let paths = bundle.paths(forResourcesOfType: "ttf", inDirectory: nil)
        var fontURL = URL(string: "")
        var error: Unmanaged<CFError>?

        paths.forEach {
            guard let filename = NSURL(fileURLWithPath: $0).lastPathComponent,
                filename.lowercased().range(of: fontName.lowercased()) != nil else {
                    return
            }

            fontURL = NSURL(fileURLWithPath: $0) as URL
        }

        guard let unwrappedFontURL = fontURL,
            let data = try? Data(contentsOf: unwrappedFontURL),
            let provider = CGDataProvider(data: data as CFData) else {

                return
        }

        let font = CGFont.init(provider)

        guard let unwrappedFont = font,
            !CTFontManagerRegisterGraphicsFont(unwrappedFont, &error),
            let unwrappedError = error,
            let nsError = (unwrappedError.takeUnretainedValue() as AnyObject) as? NSError else {

            return
        }

        let errorDescription: CFString = CFErrorCopyDescription(unwrappedError.takeUnretainedValue())

        NSException(name: NSExceptionName.internalInconsistencyException,
                    reason: errorDescription as String,
                    userInfo: [NSUnderlyingErrorKey: nsError]).raise()
    }
}

public extension NSFont {
    static func icon(from font: Fonts, ofSize size: CGFloat) -> NSFont {
        let fontName = font.rawValue
        if (NSFont(name: fontName, size: 0.0) == nil)
        {
            FontLoader.loadFont(fontName)
        }
        return NSFont(name: font.rawValue, size: size)!
    }
}
