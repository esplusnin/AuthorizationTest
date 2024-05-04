import SwiftUI
import PhotosUI

struct ImageEditorView<ViewModel>: View where ViewModel: ImageEditorViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @State var showCamera = false
    @State var showFilters = false
    @State var showImageDrawer = false
    
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
                            Image(systemName: Resources.Images.filters)
                                .font(.system(size: UIConstants.ImageEditorViewController.navbarImageFont))
                        }
                        
                        Spacer()
                        
                        ShareLink(item: image,
                                  preview: SharePreview("", image: image)) {
                            Label(Strings.ImageEditor.share, 
                                  systemImage: Resources.Images.shareLink)
                        }
                    }
                }
            }
            .padding(.horizontal)
            
            if viewModel.isLoading {
                LoaderView()
            }
        }
        .navigationBarBackButtonHidden()
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button {
                    showImageDrawer.toggle()
                } label: {
                    Image(systemName: Resources.Images.paintpalette)
                }
            }
            
            ToolbarItemGroup {
                ImageEditorToolbarGroupView(rotation: $viewModel.rotation) {
                    showCamera.toggle()
                }
            }
        }
        .fullScreenCover(isPresented: $showCamera) {
            AccessCameraView(selectedImage: $viewModel.processedImage)
        }
        .fullScreenCover(isPresented: $showImageDrawer) {
            let imageViewModel = ImageDrawingViewModel { image in
                viewModel.updateEdited(image)
            }
            
            ImageDrawingView(viewModel: imageViewModel, imageData: $viewModel.imageData)
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
            Button(Strings.ImageEditor.resetFilters) { viewModel.applyFilter(nil) }
            Button(Strings.ImageEditor.cancel, role: .cancel) {}
        }
    }
}


#Preview {
    ImageEditorView(viewModel: ImageEditorViewModel())
}
