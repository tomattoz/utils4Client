//  Created by Ivan Khvorostinin on 25.06.2025.

import SwiftUI
import WebKit

public struct WebViewWrapper: ViewRepresentable9 {
    let webView: WKWebView
    
    public init(_ webView: WKWebView) {
        self.webView = webView
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        webView
    }
    
    public func makeNSView(context: Context) -> WKWebView {
        makeUIView(context: context)
    }

    public func updateUIView(_ uiView: WKWebView, context: Context) {
    }
    
    public func updateNSView(_ uiView: WKWebView, context: Context) {
    }
}

public struct WebView: ViewRepresentable9 {
    let url: URL
    
    public init(_ url: URL) {
        self.url = url
    }
    
    public func makeUIView(context: Context) -> WKWebView {
        WKWebView()
    }
    
    public func makeNSView(context: Context) -> WKWebView {
        makeUIView(context: context)
    }
    
    public func updateUIView(_ uiView: WKWebView, context: Context) {
        guard uiView.url != url else { return }
        uiView.load(URLRequest(url: url))
    }
    
    public func updateNSView(_ uiView: WKWebView, context: Context) {
        updateUIView(uiView, context: context)
    }
}
