import SwiftUI

struct PasswordResetView: View {
    
    // MARK: - Environment:
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            Color.universalWhite
                .ignoresSafeArea()
            
            VStack {
                Text("Введите email для сброса пароля, пожалуйста")
                    .font(.mediumLargeBoldFont)
                    .foregroundStyle(.universalBlue)
            }
        }
    }
}

#Preview {
    PasswordResetView()
}
