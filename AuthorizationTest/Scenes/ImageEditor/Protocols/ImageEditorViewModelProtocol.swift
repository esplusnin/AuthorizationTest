import SwiftUI
import PhotosUI

protocol ImageEditorViewModelProtocol: ObservableObject {
    var selectedImage: PhotosPickerItem? { get set }
    var image: Image? { get set }
    
    func loadImage()
}
