//  Created by Ivan Khvorostinin on 06.02.2025.

import WebKit

public extension WKWebView {
    func clearCookies(in domain: String) {
        configuration.websiteDataStore.httpCookieStore.getAllCookies { cookies in
            for cookie in cookies {
                if cookie.domain.contains(domain) {
                    self.configuration.websiteDataStore.httpCookieStore.delete(cookie)
                }
            }
        }
    }
}

#if DEBUG && os(iOS)
@MainActor public extension WKWebView {
    @discardableResult func saveScreenshot(folder: String, name: String) async throws -> URL? {
        // Get the screenshot
        let screenshot = try await takeSnapshot(configuration: nil)

        // Get the path to the tmp directory
        let fileManager = FileManager.default
        let id = Bundle.main.bundleIdentifier ?? Bundle.main.bundleURL.lastPathComponent
        let tmpDirectory = fileManager
            .temporaryDirectory
            .appendingPathComponent(id)
            .appendingPathComponent("debug")
            .appendingPathComponent(folder)

        if !FileManager.default.fileExists(atPath: tmpDirectory.path, isDirectory: nil) {
            try! FileManager.default.createDirectory(at: tmpDirectory, withIntermediateDirectories: true)
        }
        
        let screenshotURL = tmpDirectory.appendingPathComponent(name + ".png")

        // Save the image as PNG
        if let data = screenshot.pngData() {
            try data.write(to: screenshotURL)
//            print("WEBVIEWSHOT \(screenshotURL.path)")
            return screenshotURL
        }
        else {
            assertionFailure()
        }
        
        return nil
    }
}
#endif
