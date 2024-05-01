import SwiftUI

struct BaseButtonView: View {
    
    // MARK: - Constants and Variables:
    var action: () -> Void
    
    // MARK: - UI:
    var body: some View {
        Button {
            action()
        } label: {
            Text("Создать новый аккаунт")
                .frame(maxWidth: .infinity,
                       maxHeight: UIConstants.BaseButtonView.height)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: UIConstants.BaseButtonView.cornerRadius)
                        .fill(.universalBlue)
                        .shadow(radius: UIConstants.BaseButtonView.shadowRadius)
                )
        }
    }
}

#Preview {
    BaseButtonView(action: {})
}
