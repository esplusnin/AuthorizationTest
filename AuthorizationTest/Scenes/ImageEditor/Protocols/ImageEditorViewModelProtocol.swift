import SwiftUI
import PhotosUI

protocol ImageEditorViewModelProtocol: ObservableObject {
    var selectedItem: PhotosPickerItem? { get set }
    var processedImage: Image? { get set }
    var imageData: Data? { get set }
    var rotation: CGFloat { get set }
    var currentZoom: Double { get set }
    var totalZoom: Double { get set }
    
    func loadImage()
    func applyFilter(_ filter: CIFilter)
}
