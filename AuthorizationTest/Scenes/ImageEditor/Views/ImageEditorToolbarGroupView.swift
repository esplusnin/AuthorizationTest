import SwiftUI

struct ImageEditorToolbarGroupView: View {
    
    // MARK: - Bindings:
    @Binding var rotation: CGFloat
    
    // MARK: - Constants and Variables:
    var action: () -> Void
    
    // MARK: - UI:
    var body: some View {
        HStack {
            Button {
                rotation += UIConstants.ImageEditorToolbarGroupView.rotateDegrees
            } label: {
                Image(systemName: Resources.Images.rotate)
            }
                        
            Button {
                action()
            } label: {
                Image(systemName: Resources.Images.camera)
            }
        }
        .font(.system(size: 20))
    }
}
