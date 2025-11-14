//  Created by Ivan Khvorostinin on 06.08.2025.

import Utils9
import SwiftUI

#if os(macOS)
import AppKit
#else
import UIKit
#endif

#if os(macOS)
public typealias Image9 = NSImage
public typealias Color9 = NSColor
public typealias TableView9 = NSTableView
public typealias ViewRepresentable9 = NSViewRepresentable
#else
public typealias Image9 = UIImage
public typealias Color9 = UIColor
public typealias TableView9 = UITableView
public typealias ViewRepresentable9 = UIViewRepresentable
#endif

#if os(macOS)
public extension NSAttributedString {
    convenience init?(html data: Data,
                      options: [NSAttributedString.DocumentReadingOptionKey: Any] = [:]) throws {
        self.init(html: data, options: options, documentAttributes: nil)
    }
}

extension Image {
    public init(image: Image9) {
        self.init(nsImage: image)
    }
}
#else
public extension NSAttributedString {
    convenience init?(html data: Data,
                      options: [NSAttributedString.DocumentReadingOptionKey: Any] = [:]) throws {
        try self.init(data: data, options: options, documentAttributes: nil)
    }
}

public extension UIImage {
    public convenience init?(contentsOf url: URL) {
        if url.isFileURL {
            self.init(contentsOfFile: url.path)
        }
        else {
            if let data = try? Data(contentsOf: url) {
                self.init(data: data)
            } else {
                return nil
            }
        }
    }
}

extension Image {
    public init(image: Image9) {
        self.init(uiImage: image)
    }
}
#endif
