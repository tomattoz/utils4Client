//  Created by Ivan Kh on 12.03.2026.

import SwiftUI
import Utils9

public struct ErrorAlertKey: EnvironmentKey {
    public static let defaultValue: Binding<Error?> = .constant(nil)
}

public extension EnvironmentValues {
    var errorAlert: Binding<Error?> {
        get {
            self[ErrorAlertKey.self]
        } set {
            self[ErrorAlertKey.self] = newValue
        }
    }
}

public extension View {
    func errorAlert() -> some View {
        modifier(ErrorAlertViewModifier())
    }
}

private struct ErrorAlertViewModifier: ViewModifier {
    @Environment(\.errorAlert) var error
        
    func body(content: Content) -> some View {
        if let theError = error.wrappedValue {
            content
                .alert((theError as NSError).friendlyTitle ?? "Error occured",
                       isPresented: .init(source: error),
                       actions: {
                    Button(action: { error.wrappedValue = nil }) {
                        Text("OK")
                    }
                },
                       message: {
                    Text(theError.friendlyDescriptionNotTitle)
                })
        }
        else {
            content
        }
    }
}

