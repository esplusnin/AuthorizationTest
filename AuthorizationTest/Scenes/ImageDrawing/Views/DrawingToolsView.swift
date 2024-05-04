import SwiftUI
import PencilKit

struct DrawingToolsView: View {
    
    // MARK: - Environment:
    @Environment(\.undoManager) private var undoManager

    // MARK: - Bindings:
    @Binding var isDrawing: Bool
    @Binding var pencilType: PKInkingTool.InkType
    @Binding var colorPicker: Bool
    @Binding var color: Color

    var body: some View {
        HStack(spacing: UIConstants.DrawingToolsView.hStackSpacing) {
            Button {
                isDrawing = false
            } label: {
                Image(systemName: Resources.Images.eraser)
            }
            
            Button {
                isDrawing = true
                pencilType = .pencil
            } label: {
                Image(systemName: Resources.Images.pencil)
            }
            
            Button {
                isDrawing = true
                pencilType = .pen
            } label: {
                Image(systemName: Resources.Images.applepencil)
            }
            
            Button {
                isDrawing = true
                pencilType = .marker
            } label: {
                Image(systemName: Resources.Images.paintbrush)
            }
            
            Button {
                colorPicker.toggle()
            } label: {
                Image(systemName: Resources.Images.paintpalette)
            }
            
            Spacer()
            
            Button {
                undoManager?.undo()
            } label: {
                Image(systemName: Resources.Images.turnBackward)
            }
            .sheet(isPresented: $colorPicker) {
                ColorPicker("Pick color", selection: $color)
                    .padding()
                    .presentationDetents([.fraction(UIConstants.DrawingToolsView.fractionValue)])
            }
        }
        .padding(.horizontal)
        .font(.system(size: UIConstants.DrawingToolsView.font))
    }
}
