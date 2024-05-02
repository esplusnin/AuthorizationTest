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
                    .frame(width: UIConstants.GoogleSignInButton.imageSide,
                           height: UIConstants.GoogleSignInButton.imageSide)
                
                Text(Strings.Registration.signInWithGoogle)
                    .background(.universalWhite)
                    .foregroundStyle(.universalBlack)
            }
            .frame(maxWidth: .infinity)
            .frame(height: UIConstants.GoogleSignInButton.height)
            .background(
                RoundedRectangle(cornerRadius: UIConstants.GoogleSignInButton.cornerRadius)
                    .fill(.universalWhite)
                    .shadow(radius: UIConstants.GoogleSignInButton.shadowRadius)
            )
        }
    }
}

#Preview {
    GoogleSignInButton(action: {})
}
