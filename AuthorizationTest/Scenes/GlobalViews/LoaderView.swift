import SwiftUI

struct LoaderView: View {
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: UIConstants.LoaderView.cornerRadius)
                .frame(width: UIConstants.LoaderView.side,
                       height: UIConstants.LoaderView.side)
                .foregroundStyle(.universalGray)
                .opacity(UIConstants.LoaderView.opacity)
            
            
            ProgressView()
        }
    }
}

#Preview {
    LoaderView()
}
