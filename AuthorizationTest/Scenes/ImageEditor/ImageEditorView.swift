import SwiftUI
import PhotosUI

struct ImageEditorView<ViewModel>: View where ViewModel: ImageEditorViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @State var showCamera = false
    @State var showFilters = false
    
    // MARK: - UI:
    var body: some View {
        ZStack {
            Color(showCamera ? .universalBlack : .universalWhite)
                .ignoresSafeArea()
                .animation(.default, value: showCamera)
            
            VStack {
                Spacer()
                
                PhotosPicker(selection: $viewModel.selectedItem) {
                    if let image = viewModel.processedImage {
                        ScrollableImageView(currentZoom: $viewModel.currentZoom,
                                            totalZoom: $viewModel.totalZoom) {
                            image
                                .resizable()
                                .scaledToFit()
                                .rotationEffect(.degrees(viewModel.rotation))
                                .animation(.default, value: viewModel.rotation)
                        }
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
                
                Spacer()
                
                if let image = viewModel.processedImage {
                    HStack {
                        Button {
                            showFilters.toggle()
                        } label: {
                            Image(systemName: "camera.filters")
                                .font(.system(size: UIConstants.ImageEditorViewController.navbarImageFont))
                        }
                        
                        Spacer()
                        
                        ShareLink(item: image,
                                  preview: SharePreview("billede", image: image)) {
                            Label("Share Image", systemImage: "square.and.arrow.up")
                        }
                    }
                }
            }
            .padding(.horizontal)
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItemGroup {
                ImageEditorToolbarGroupView(rotation: $viewModel.rotation) {
                    showCamera.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            AccessCameraView(selectedImage: $viewModel.processedImage)
        }
        .confirmationDialog("Filters", isPresented: $showFilters) {
            Button("Crystallize") { viewModel.applyFilter(.crystallize()) }
            Button("Edges") { viewModel.applyFilter(.edges()) }
            Button("colorClamp") { viewModel.applyFilter(.colorClamp()) }
            Button("bloom") { viewModel.applyFilter(.bloom()) }
            Button("toneCurve") { viewModel.applyFilter(.toneCurve()) }
            Button("Gaussian Blur") { viewModel.applyFilter(.gaussianBlur()) }
            Button("Pixellate") { viewModel.applyFilter(.pixellate()) }
            Button("Sepia Tone") { viewModel.applyFilter(.sepiaTone()) }
            Button("Unsharp Mask") { viewModel.applyFilter(.unsharpMask()) }
            Button("Vignette") { viewModel.applyFilter(.vignette()) }
            Button("Cancel", role: .cancel) {}
        }
    }
}


#Preview {
    ImageEditorView(viewModel: ImageEditorViewModel())
}
