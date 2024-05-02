import SwiftUI

struct ClearButtonModifier: ViewModifier {
    
    // MARK: - Constants and Variables:
    @Binding var inputText: String
    
    // MARK: - Public Methods:
    func body(content: Content) -> some View {
        HStack {
            content
            
            if !inputText.isEmpty {
                Spacer()
                
                Button {
                    inputText = ""
                } label: {
                    Circle()
                        .frame(width: UIConstants.ClearButtonModifier.circleSide,
                               height: UIConstants.ClearButtonModifier.circleSide)
                        .foregroundStyle(.universalGray)
                        .overlay {
                            Image(systemName: Resources.Images.multiply)
                                .font(.regularMediumFont)
                                .foregroundStyle(.universalWhite)
                        }
                        .padding(.trailing, UIConstants.ClearButtonModifier.trailingPadding)
                }
            }
        }
    }
}

// MARK: - Extension modifier:
extension View {
    func clearButton(with text: Binding<String>) -> some View {
        modifier(ClearButtonModifier(inputText: text))
    }
}
