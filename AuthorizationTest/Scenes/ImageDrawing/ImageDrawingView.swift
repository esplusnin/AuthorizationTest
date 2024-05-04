import SwiftUI
import PencilKit

struct ImageDrawingView<ViewModel>: View where ViewModel: ImageDrawingViewModelProtocol {
    
    // MARK: - Dependencies:
    @ObservedObject var viewModel: ViewModel
    
    // MARK: - Bindings:
    @Binding var imageData: Data?
    
    // MARK: - UI:
    @State var canvas = PKCanvasView()
    
    var body: some View {
        ZStack {
            VStack {
                TextAdditionalView(textBoxShow: $viewModel.textBoxShow) {
                    saveDrawing()
                }
                
                GeometryReader { proxy -> AnyView in
                    
                    let size = proxy.frame(in: .global)
                    
                    DispatchQueue.main.async {
                        if viewModel.rect == .zero {
                            viewModel.rect = size
                        }
                    }
                    
                    return AnyView(
                        ZStack {
                            DrawingViewRepresentable(canvas: $canvas,
                                                     isDrawing: $viewModel.isDrawing,
                                                     pencilType: $viewModel.pencilType,
                                                     color: $viewModel.color,
                                                     imageData: $imageData,
                                                     rect: size)
                            
                            if viewModel.textBox.text != "" && !viewModel.textBoxShow {
                                TextBoxView(textBox: $viewModel.textBox)
                            }
                        })
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
    }
    
    // MARK: - Private Methods:
    private func saveDrawing() {
        UIGraphicsBeginImageContextWithOptions(viewModel.rect.size, false, 0)
        canvas.drawHierarchy(in: CGRect(origin: .zero, size: viewModel.rect.size),
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
            canvas.backgroundColor = .clear
            
            UIGraphicsEndImageContext()
            
            if let generatedImage {
                UIImageWriteToSavedPhotosAlbum(generatedImage, nil, nil, nil)
            }
        }
    }
}

#Preview {
    ImageDrawingView(viewModel: ImageDrawingViewModel(), imageData: .constant(Data()))
}
