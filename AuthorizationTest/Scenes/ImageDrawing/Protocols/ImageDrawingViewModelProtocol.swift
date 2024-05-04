import SwiftUI
import PencilKit

protocol ImageDrawingViewModelProtocol: ObservableObject {
    var canvas: PKCanvasView { get set }
    var isDrawing: Bool { get set }
    var pencilType: PKInkingTool.InkType { get set }
    var color: Color { get set }
    var colorPicker: Bool { get set }
    var textBox: TextBox { get set }
    var textBoxShow: Bool { get set }
    var rect: CGRect { get set }
    var showAlert: Bool { get set }
    var savedImage: UIImage? { get set }
}
