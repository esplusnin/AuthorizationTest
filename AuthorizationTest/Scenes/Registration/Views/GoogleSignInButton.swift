import SwiftUI

struct GoogleSignInButton: View {
    
    // MARK: - Constants and Variables:
    var action: () -> Void
    
    // MARK: - UI:
    var body: some View {
        Button {
            action()
        } label: {
            HStack {
                Image(.googleLogo)
                    .resizable()
                    .frame(width: 30, height: 30)
                
                Text("Войти с помощью Google")
                    .background(.universalWhite)
                    .foregroundStyle(.universalBlack)
            }
            .frame(maxWidth: .infinity, maxHeight: 60)
            .background(
                RoundedRectangle(cornerRadius: 10)
                    .fill(.universalWhite)
                    .shadow(radius: 3)
            )
        }
    }
}

#Preview {
    GoogleSignInButton(action: {})
}
