import SwiftUI

struct ImageEditorToolbarGroupView: View {
    
    // MARK: - Bindings:
    @Binding var rotation: CGFloat
    
    // MARK: - Constants and Variables:
    var action: () -> Void
    
    var body: some View {
        Button {
            rotation += UIConstants.ImageEditorToolbarGroupView.rotateDegrees
        } label: {
            Image(systemName: Resources.Images.rotate)
                .font(.system(size: UIConstants.ImageEditorViewController.navbarImageFont))
        }
        
        Spacer()
        
        Button {
            action()
        } label: {
            Image(systemName: Resources.Images.camera)
                .font(.system(size: UIConstants.ImageEditorViewController.navbarImageFont))
        }
    }
}
