import SwiftUI
import PencilKit

final class ImageDrawingViewModel: ImageDrawingViewModelProtocol {
    
    // MARK: - Bindings:
    @Published var canvas = PKCanvasView()
    @Published var isDrawing = true
    @Published var pencilType: PKInkingTool.InkType = .pencil
    @Published var color: Color = .black
    @Published var colorPicker = false
    @Published var textBox = TextBox(text: "", isBold: false)
    @Published var textBoxShow = false
    @Published var rect: CGRect = .zero
    @Published var showAlert = false
    
    // MARK: - Constants and Variables:
    var savedImage: UIImage?
    
    // MARK: - Constants and Variables:
    var updateImageAction: (UIImage) -> Void
    
    // MARK: - Lifecycle:
    init(action: @escaping (UIImage) -> Void) {
        self.updateImageAction = action
    }
    
    deinit {
        if let savedImage {
            updateImageAction(savedImage)
        }
    }
}
