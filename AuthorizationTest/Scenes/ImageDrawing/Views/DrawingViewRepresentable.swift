import SwiftUI
import PencilKit

struct DrawingViewRepresentable: UIViewRepresentable {
    
    // MARK: - Bindings:
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    @Binding var pencilType: PKInkingTool.InkType
    @Binding var color: Color
    @Binding var imageData: Data?
    
    // MARK: - Constants and Variables:
    let eraser = PKEraserTool(.bitmap)
    let rect: CGRect
    
    var ink: PKInkingTool {
        PKInkingTool(pencilType, color: UIColor(color))
    }
    
    // MARK: - Public Methods:
    func makeUIView(context: Context) -> PKCanvasView {
        canvas.isOpaque = false
        canvas.backgroundColor = .clear
        canvas.drawingPolicy = .anyInput
        canvas.tool = isDrawing ? ink : eraser
        
        if let imageData,
           let image = UIImage(data: imageData) {
            let imageView = UIImageView(image: image)
            imageView.frame = CGRect(x: 0, y: 0, width: rect.width, height: rect.height)
            imageView.contentMode = .scaleAspectFit
            imageView.clipsToBounds = true
            
            let subview = canvas.subviews[0]
            subview.addSubview(imageView)
            subview.sendSubviewToBack(imageView)
            subview.contentMode = .scaleAspectFit
        }
        
        let toolPicker = PKToolPicker.init()
        toolPicker.setVisible(true, forFirstResponder: canvas)
        toolPicker.addObserver(canvas)
        canvas.becomeFirstResponder()
        
        return canvas
    }
    
    func updateUIView(_ uiView: PKCanvasView, context: Context) {
        uiView.tool = isDrawing ? ink : eraser
    }
}
