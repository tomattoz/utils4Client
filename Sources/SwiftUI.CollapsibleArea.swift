//  Created by Ivan Kh on 15.12.2025.

import SwiftUI

public struct CollapsibleArea<Content: View>: View {
    @Binding var visibility: CGFloat // 0 (collapsed) ... 1 (visible)
    let content: () -> Content
    @State private var initialHeight: CGFloat = 0
    
    public init(visibility: Binding<CGFloat>, @ViewBuilder content: @escaping () -> Content) {
        self._visibility = visibility
        self.content = content
    }
    
    public var body: some View {
        ZStack(alignment: .top) {
            content()
                .background(
                    GeometryReader { geo in
                        Color.clear
                            .onAppear {
                                initialHeight = max(geo.size.height, 1)
                            }
                    }
                )
        }
        .frame(height: visibility * initialHeight, alignment: .top)
        .contentShape(Rectangle())
        .clipped()
        .gesture(dragGesture)
    }
    
    private var dragGesture: some Gesture {
        DragGesture(minimumDistance: 5, coordinateSpace: .local)
            .onChanged { value in
                update(by: value.translation.height)
            }
            .onEnded { value in
                commit()
            }
    }
    
    private func update(by delta: CGFloat) {
        let currentHeight = min(initialHeight,
                            max(0, visibility * initialHeight - delta))
        visibility = currentHeight / initialHeight
    }
    
    private func commit() {
        withAnimation {
            visibility = (1 - visibility < 0.5) ? 1 : 0
        }
    }
}
