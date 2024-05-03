import SwiftUI
import PhotosUI

struct ImageEditorView<ViewModel>: View where ViewModel: ImageEditorViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @State var showCamera = false
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            Color(showCamera ? .universalBlack : .universalWhite)
                .ignoresSafeArea()
                .animation(.default, value: showCamera)
            
            VStack {
                PhotosPicker(selection: $viewModel.selectedImage) {
                    if let image = viewModel.image {
                        image
                            .resizable()
                            .scaledToFill()
                            .clipped()
                    } else {
                        VStack(spacing: UIConstants.ImageEditorViewController.vStackSpacing) {
                            Image(systemName: Resources.Images.photo)
                                .font(.system(size: UIConstants.ImageEditorViewController.systemImageFont))
                            
                            Text(Strings.ImageEditor.choosePhoto)
                                .foregroundStyle(.universalBlue)
                                .bold()
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showCamera.toggle()
                } label: {
                    Image(systemName: Resources.Images.camera)
                        .font(.system(size: UIConstants.ImageEditorViewController.navbarImageFont))
                }
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            AccessCameraView(selectedImage: $viewModel.image)
        }
    }
}

#Preview {
    ImageEditorView(viewModel: ImageEditorViewModel())
}
