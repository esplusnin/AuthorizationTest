import SwiftUI

struct PasswordResetView<ViewModel>: View where ViewModel: PasswordResetViewModelProtocol {
    
    // MARK: - Environment:
    @Environment(\.dismiss) var dismiss
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @FocusState var isFocused: Bool
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            Color.universalWhite
                .ignoresSafeArea()
            
            if viewModel.isMessageSent {
                VStack(spacing: UIConstants.PasswordResetView.vStackSpacing) {
                    Text(Strings.PasswordResetView.messageDidSent)
                        .foregroundStyle(.universalBlack)
                        .font(.mediumLargeBoldFont)
                    
                    Button {
                        dismiss()
                    } label: {
                        Text(Strings.PasswordResetView.close)
                            .font(.mediumLargeBoldFont)
                            .foregroundStyle(.universalBlue)
                    }
                }
            } else {
                VStack {
                    Text(Strings.PasswordResetView.title)
                        .foregroundStyle(.universalBlue)
                        .font(.mediumLargeBoldFont)
                    
                    VStack(spacing: UIConstants.PasswordResetView.vStackSpacing) {
                        TextField("Enter info",
                                  text: $viewModel.email,
                                  prompt: Text(Strings.PasswordResetView.enterEmail)
                            .foregroundColor(.universalGray))
                        .foregroundStyle(.universalBlack)
                        .textInputAutocapitalization(.never)
                        .keyboardType(.emailAddress)
                        .focused($isFocused)
                        .clearButton(with: $viewModel.email)
                        
                        Divider()
                        
                        BaseButtonView(title: Strings.PasswordResetView.resetPassword,
                                       isUnlocked: viewModel.isUnlocked) {
                            viewModel.resetPassword()
                        }
                        
                        Spacer()
                    }
                    .padding(.vertical)
                }
                .padding()
            }
        }
        .animation(.default, value: viewModel.isMessageSent)
        .onTapGesture {
            isFocused.toggle()
        }
    }
}

#Preview {
    PasswordResetView(viewModel: PasswordResetViewModel(authorizationService: AuthorizationService()))
}
