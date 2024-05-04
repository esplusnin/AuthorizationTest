import SwiftUI

struct TextAdditionalView: View {
    
    // MARK: - Environment:
    @Environment(\.dismiss) private var dismiss
    
    // MARK: - Bindings:
    @Binding var textBoxShow: Bool
    
    // MARK: - Constants and Variables:
    var action: () -> Void
    
    var body: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text(Strings.ImageDrawing.cancel)
                    .font(.system(size: UIConstants.ImageDrawingView.font))
                    .bold()
            }
            
            Spacer()
            
            HStack(spacing: UIConstants.TextAdditionalView.hStackSpacing) {
                Button {
                    withAnimation {
                        textBoxShow.toggle()
                    }
                } label: {
                    Image(systemName: Resources.Images.plus)
                        .font(.system(size: UIConstants.ImageDrawingView.font))
                }
                
                Button {
                    action()
                    
                } label: {
                    Text(Strings.ImageDrawing.save)
                        .font(.system(size: UIConstants.ImageDrawingView.font))
                }
            }
        }
        .padding(.horizontal)
    }
}


#Preview {
    TextAdditionalView(textBoxShow: .constant(true), action: {})
}
