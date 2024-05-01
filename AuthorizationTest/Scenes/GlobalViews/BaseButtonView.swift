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
                .frame(maxWidth: .infinity, maxHeight: 60)
                .foregroundStyle(.white)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .fill(.universalBlue)
                        .shadow(radius: 3)
                )
        }
    }
}

#Preview {
    BaseButtonView(action: {})
}
