//  Created by Ivan Kh on 12.03.2026.

import SwiftUI

public struct AnyViewModifier: ViewModifier {
    private let transform: (Content) -> AnyView

    public init<TModifier: ViewModifier>(_ inner: TModifier) {
        self.transform = {
            AnyView($0.modifier(inner))
        }
    }

    public func body(content: Content) -> some View {
        transform(content)
    }
}

