import SwiftUI

struct BaseButtonView: View {
    
    // MARK: - Constants and Variables:
    var title: String
    var isUnlocked: Bool
    var action: () -> Void
    
    // MARK: - UI:
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .frame(maxWidth: .infinity)
                .frame(height: UIConstants.BaseButtonView.height)
                .foregroundStyle(.universalWhite)
                .background(
                    RoundedRectangle(cornerRadius: UIConstants.BaseButtonView.cornerRadius)
                        .fill(.universalBlue)
                        .shadow(radius: UIConstants.BaseButtonView.shadowRadius)
                )
        }
        .opacity(isUnlocked ? 1 : 0.5)
        .allowsHitTesting(isUnlocked ? true : false)
    }
}

#Preview {
    BaseButtonView(title: "Создать новый аккаунт", isUnlocked: true, action: {})
}
