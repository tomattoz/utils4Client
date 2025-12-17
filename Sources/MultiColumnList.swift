//  Created by Ivan Kh on 14.11.2025.

import SwiftUI

public struct MultiColumnList<Model: Identifiable, ItemView: View>: View {
    let model: [Model]
    let itemPadding: CGFloat
    let maxItemWidth: CGFloat
    @ViewBuilder var itemView: (_ model: Model, _ width: CGFloat) -> ItemView

    public init(model: [Model],
                maxItemWidth: CGFloat,
                itemPadding: CGFloat = 8,
                @ViewBuilder itemView: @escaping (Model, CGFloat) -> ItemView) {
        self.model = model
        self.itemPadding = itemPadding
        self.maxItemWidth = maxItemWidth
        self.itemView = itemView
    }
    
    public var body: some View {
        GeometryReader { g in
            ScrollView(showsIndicators: false) {
                VStack {
                    let widthWithoutPadding = g.size.width - itemPadding
                    let itemWidthWithPadding = (maxItemWidth + itemPadding)
                    let count = max(Int(floor(widthWithoutPadding / itemWidthWithPadding)), 1)
                    let widthWithoutAllPaddings = g.size.width - itemPadding * CGFloat(count + 1)
                    let itemWidth = widthWithoutAllPaddings / CGFloat(count)
                    let array = model.chunked(into: count)

                    Spacer()
                        .frame(height: 16)

                    ForEach(array) { row in
                        HStack(alignment: .top, spacing: itemPadding) {
                            ForEach(row.array) { item in
                                itemView(item, itemWidth)
                            }
                            
                            if row.array.count < count {
                                Spacer()
                            }
                        }
                        .padding(.horizontal, itemPadding)
                        .padding(.bottom, array.last != row ? 8 : 0)
                    }
                    
                    Spacer()
                        .frame(height: 16)
                }
            }
        }
    }
}

private extension Array where Element: Identifiable {
    func chunked(into size: Int) -> [ArrayRow<Element>] {
        var result: [ArrayRow<Element>] = []
        
        for index in stride(from: 0, to: self.count, by: size) {
            let array = Array(self[index ..< Swift.min(index + size, self.count)])
            let id = array.map {
                $0.id
            }
            result.append(.init(id: id, array: array))
        }
        
        return result
    }
}

private struct ArrayRow<T: Identifiable>: Identifiable, Equatable {
    let id: [T.ID]
    let array: [T]
    
    init(id: [T.ID], array: [T]) {
        self.id = id
        self.array = array
    }
    
    static func == (lhs: ArrayRow<T>, rhs: ArrayRow<T>) -> Bool {
        lhs.id == rhs.id
    }
}
