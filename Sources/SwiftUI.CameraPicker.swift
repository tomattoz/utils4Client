//  Created by Ivan Kh on 13.03.2026.

import SwiftUI

#if os(iOS)
public struct CameraPicker: UIViewControllerRepresentable {
    public struct Selection: Equatable {
        let id = UUID()
        public let info: [UIImagePickerController.InfoKey : Any]
        
        public init(_ info: [UIImagePickerController.InfoKey : Any]) {
            self.info = info
        }
        
        public static func == (lhs: Selection, rhs: Selection) -> Bool {
            lhs.id == rhs.id
        }
    }

    @Binding var selection: Selection?
    @Environment(\.dismiss) var dismiss
    
    public init(selection: Binding<Selection?>) {
        self._selection = selection
    }
    
    public func makeUIViewController(context: Context) -> UIImagePickerController {
        let picker = UIImagePickerController()
        picker.delegate = context.coordinator
        picker.sourceType = .camera
        return picker
    }

    public func updateUIViewController(_ uiViewController: UIImagePickerController, context: Context) {}

    public func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    public class Coordinator: NSObject, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
        var parent: CameraPicker

        init(_ parent: CameraPicker) {
            self.parent = parent
        }

        public func imagePickerController(
            _ picker: UIImagePickerController,
            didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
                parent.selection = Selection(info)
                parent.dismiss()
        }
        
        public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
            parent.dismiss()
        }
    }
}
#endif
