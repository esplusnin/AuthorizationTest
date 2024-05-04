import SwiftUI
import PencilKit

struct ImageDrawingView<ViewModel>: View where ViewModel: ImageDrawingViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Constants and Variables:
    var imageData: Data?
    
    var body: some View {
        ZStack {
            VStack {
                TextAdditionalView(textBoxShow: $viewModel.textBoxShow) {
                    saveDrawing()
                }
                
                GeometryReader { proxy -> AnyView in
                    
                    let rect = proxy.frame(in: .global)
                    
                    DispatchQueue.main.async {
                        viewModel.rect = rect
                    }
                    
                    return AnyView(
                        FullDrawingTextedCanvasView(canvas: $viewModel.canvas,
                                                    isDrawing: $viewModel.isDrawing,
                                                    pencilType: $viewModel.pencilType,
                                                    color: $viewModel.color,
                                                    textBox: $viewModel.textBox,
                                                    imageData: imageData,
                                                    rect: rect,
                                                    isShow: viewModel.textBox.text != "" && !viewModel.textBoxShow)                        )
                }
                
                DrawingToolsView(isDrawing: $viewModel.isDrawing,
                                 pencilType: $viewModel.pencilType,
                                 colorPicker: $viewModel.colorPicker,
                                 color: $viewModel.color)
            }
            
            if viewModel.textBoxShow {
                DrawingTextPanelView(textBox: $viewModel.textBox, textBoxShow: $viewModel.textBoxShow)
            }
        }
        .alert(Strings.ImageDrawing.imageSaved, isPresented: $viewModel.showAlert) {}
    }
    
    // MARK: - Private Methods:
    private func saveDrawing() {
        UIGraphicsBeginImageContextWithOptions(viewModel.rect.size, false, 0)
        viewModel.canvas.drawHierarchy(in: CGRect(origin: .zero, size: viewModel.rect.size),
                                       afterScreenUpdates: true)
        
        let generatedImage = UIGraphicsGetImageFromCurrentImageContext()
        
        let swiftUIView = ZStack {
            Text(viewModel.textBox.text)
                .font(.system(size: CGFloat(viewModel.textBox.textSize)))
                .bold(viewModel.textBox.isBold)
                .foregroundStyle(viewModel.textBox.textColor)
                .offset(viewModel.textBox.offset)
        }
        
        if let controller = UIHostingController(rootView: swiftUIView).view {
            controller.frame = viewModel.rect
            controller.drawHierarchy(in: CGRect(origin: .zero, size: viewModel.rect.size),
                                     afterScreenUpdates: true)
            
            controller.backgroundColor = .clear
            viewModel.canvas.backgroundColor = .clear
            
            UIGraphicsEndImageContext()
            
            if let generatedImage {
                viewModel.showAlert.toggle()
                viewModel.savedImage = generatedImage
                UIImageWriteToSavedPhotosAlbum(generatedImage, nil, nil, nil)
            }
        }
    }
}

#Preview {
    ImageDrawingView(viewModel: ImageDrawingViewModel(action: { _ in } ), imageData: Data())
}
