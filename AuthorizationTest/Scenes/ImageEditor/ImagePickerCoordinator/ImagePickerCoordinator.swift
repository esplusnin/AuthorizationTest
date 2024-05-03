import SwiftUI

class ImagePickerCoordinator: NSObject {
    
    // MARK: - Constant and Variables:
    var picker: AccessCameraView
    
    // MARK: - Lifecycle:
    init(picker: AccessCameraView) {
        self.picker = picker
    }
}

// MARK: - UINavigationControllerDelegate, UIImagePickerControllerDelegate:
extension ImagePickerCoordinator: UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let uiImage = info[.originalImage] as? UIImage else { return }
        let image = Image(uiImage: uiImage)
        self.picker.selectedImage = image
        self.picker.isPresented.wrappedValue.dismiss()
    }
}
