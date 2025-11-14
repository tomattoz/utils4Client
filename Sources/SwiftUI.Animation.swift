//  Created by Ivan Khvorostinin on 22.09.2025.

import SwiftUI

public extension Animation {
    static func startBlinking(_ opacity: Binding<CGFloat>) {
        withAnimation(
            Animation.easeInOut(duration: 0.75)
                .repeatForever(autoreverses: true)
        ) {
            opacity.wrappedValue = 0.25
        }
    }
    
    static func stopBlinking(_ opacity: Binding<CGFloat>) {
        withAnimation {
            opacity.wrappedValue = 1
        }
    }
}
