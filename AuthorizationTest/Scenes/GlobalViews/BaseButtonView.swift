import SwiftUI

struct BaseButtonView: View {
    
    var action: () -> Void
    var body: some View {
        Button {
            action()
        } label: {
            Text("Создать новый аккаунт")
                .frame(maxWidth: .infinity, maxHeight: 60)
                .background(.blue)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(.white)
        }
    }
}

#Preview {
    BaseButtonView(action: {})
}
