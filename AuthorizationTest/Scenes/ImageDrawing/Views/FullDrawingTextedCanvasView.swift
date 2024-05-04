import SwiftUI
import PencilKit

struct FullDrawingTextedCanvasView: View {
    
    // MARK: - Bindings:
    @Binding var canvas: PKCanvasView
    @Binding var isDrawing: Bool
    @Binding var pencilType: PKInkingTool.InkType
    @Binding var color: Color
    @Binding var textBox: TextBox
    
    // MARK: - Constants and Variables:
    var imageData: Data?
    var rect: CGRect
    var isShow: Bool
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            DrawingViewRepresentable(canvas: $canvas,
                                     isDrawing: $isDrawing,
                                     pencilType: $pencilType,
                                     color: $color,
                                     imageData: imageData,
                                     rect: rect)
            
            if isShow {
                TextBoxView(textBox: $textBox)
            }
        }
    }
}
