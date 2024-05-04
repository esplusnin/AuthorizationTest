import SwiftUI

struct DrawingTextPanelView: View {
    
    // MARK: - Bindings:
    @Binding var textBox: TextBox
    @Binding var textBoxShow: Bool
    
    // MARK: - UI:
    var body: some View {
        Color.universalBlack.opacity(UIConstants.DrawingTextPanelView.opacity)
            .ignoresSafeArea()
        
        VStack {
            HStack {
                Button {
                    textBoxShow.toggle()
                } label: {
                    Text(Strings.DrawingTextPanel.add)
                        .foregroundStyle(.universalWhite)
                        .bold()
                }
                
                Spacer()
                
                Button {
                    withAnimation {
                        textBoxShow.toggle()
                        textBox.reset()
                    }
                } label: {
                    Text(Strings.DrawingTextPanel.cancel)
                        .foregroundStyle(.universalWhite)
                        .bold()
                }
            }
            .padding(.horizontal)
            .overlay {
                HStack(spacing: UIConstants.DrawingTextPanelView.hStackSpacing) {
                    ColorPicker("", selection: $textBox.textColor)
                        .labelsHidden()
                    
                    Picker("Choose font size", selection: $textBox.textSize) {
                        ForEach(UIConstants.DrawingTextPanelView.startRange...UIConstants.DrawingTextPanelView.endRande, id: \.self) { number in
                            Text(number.formatted())
                                .tag(number)
                        }
                    }
                }
            }
            
            Spacer()
            
            TextField(Strings.DrawingTextPanel.enterText, text: $textBox.text)
                .font(.system(size: UIConstants.DrawingTextPanelView.fontSize))
                .colorScheme(.dark)
                .foregroundStyle(textBox.textColor)
                .padding(.horizontal)
            
            Spacer()
        }
    }
}

#Preview {
    DrawingTextPanelView(textBox: .constant(TextBox(text: "", isBold: true)), textBoxShow: .constant(true))
}
