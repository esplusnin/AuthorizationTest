import Combine
import SwiftUI
import PhotosUI
import CoreImage
import CoreImage.CIFilterBuiltins

final class ImageEditorViewModel: ImageEditorViewModelProtocol {
    
    // MARK: - Publishers:
    @Published var isLoading = false

    @Published var selectedItem: PhotosPickerItem?
    @Published var processedImage: Image?
    @Published var imageData: Data?
    
    @Published var rotation: CGFloat = 0
    @Published var currentZoom = 0.0
    @Published var totalZoom = 1.0
    
    // MARK: - Constans and Variables:
    private var cancellable = Set<AnyCancellable>()
    
    private let context = CIContext()
    private var beginImage: CIImage?
    private var currentFilter: CIFilter = .bloom()
    
    // MARK: - Lifecycle:
    init() {
        setupSelectedImageObserver()
        setupImagesObserver()
    }
    
    // MARK: - Public Methods:
    func loadImage() {
        Task {
            await changeLoadingStatus()
            guard let imageData = try await selectedItem?.loadTransferable(type: Data.self),
                  let inputImage = UIImage(data: imageData) else {
                await changeLoadingStatus()
                return
            }
            
            self.imageData = imageData
            beginImage = CIImage(image: inputImage)
            
            currentFilter.setValue(beginImage, forKey: kCIInputImageKey)
            await applyProcessing()
        }
    }
    
    func applyFilter(_ filter: CIFilter) {
        currentFilter = filter
        loadImage()
    }
    
    // MARK: - Private Methods:
    @MainActor
    private func changeLoadingStatus() {
        isLoading.toggle()
    }
    
    @MainActor
    private func applyProcessing() {
        changeLoadingStatus()

        guard let outputImage = currentFilter.outputImage,
              let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }

        let uiImage = UIImage(cgImage: cgImage)
        processedImage = Image(uiImage: uiImage)
    }
    
    private func setupSelectedImageObserver() {
        $selectedItem
            .sink { [weak self] item in
                guard let self else { return }
                if item != nil {
                    self.loadImage()
                }
            }
            .store(in: &cancellable)
    }
    
    private func setupImagesObserver() {
        $processedImage
            .sink { [weak self] _ in
                guard let self else { return }
                self.totalZoom = 1.0
                self.rotation = 0
            }
            .store(in: &cancellable)
    }
}
