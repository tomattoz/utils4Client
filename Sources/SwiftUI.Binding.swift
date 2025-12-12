//  Created by Ivan Kh on 23.10.2023.

import SwiftUI

public extension Binding where Value == Bool {
    init<T>(source src: Binding<Optional<T>>) {
        self.init(get: { src.wrappedValue != nil },
                  set: { newValue in
            if !newValue {
                src.wrappedValue = nil
            }
        })
    }

    init<T>(source src: Binding<Optional<T>>, value: T) where T: Equatable {
        self.init(get: { src.wrappedValue == value },
                  set: { newValue in
            if newValue {
                src.wrappedValue = newValue ? value : nil
            }
        })
    }

    init<T>(source: Binding<T>, trueValue: T, falseValue: T) where T: Equatable {
        self.init(get: { source.wrappedValue == trueValue },
                  set: { newValue in
            if newValue {
                source.wrappedValue = newValue ? trueValue : falseValue
            }
        })
    }

    var not: Binding<Value> {
        Binding<Value>(
            get: { !self.wrappedValue },
            set: { self.wrappedValue = !$0 }
        )
    }
}
