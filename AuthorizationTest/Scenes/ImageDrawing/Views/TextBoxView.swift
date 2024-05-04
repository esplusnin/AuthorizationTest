import SwiftUI

struct TextBoxView: View {
    
    // MARK: - Bindings:
    @Binding var textBox: TextBox
    
    // MARK: - UI
    var body: some View {
        Text(textBox.text)
            .font(.system(size: CGFloat(textBox.textSize)))
            .bold(textBox.isBold)
            .foregroundStyle(textBox.textColor)
            .offset(textBox.offset)
            .gesture(
                DragGesture()
                    .onChanged { value in
                        let current = value.translation
                        let lastOffset = textBox.lastOffset
                        let newTranslation = CGSize(
                            width: lastOffset.width + current.width,
                            height: lastOffset.height + current.height)
                        textBox.offset = newTranslation
                    }
            )
    }
}

#Preview {
    TextBoxView(textBox: .constant(TextBox(text: "", isBold: true)))
}
