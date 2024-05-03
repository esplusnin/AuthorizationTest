import SwiftUI

struct AccessCameraView: UIViewControllerRepresentable {
    
    // MARK: - Environment:
    @Environment(\.presentationMode) var isPresented
    
    // MARK: - Binding:
    @Binding var selectedImage: Image?
    
    // MARK: - Public Methods:
    func makeUIViewController(context: Context) -> some UIViewController {
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.allowsEditing = true
        imagePicker.delegate = context.coordinator
        return imagePicker
    }
    
    func updateUIViewController(_ uiViewController: UIViewControllerType, context: Context) {}
    
    func makeCoordinator() -> ImagePickerCoordinator {
        ImagePickerCoordinator(picker: self)
    }    
}
