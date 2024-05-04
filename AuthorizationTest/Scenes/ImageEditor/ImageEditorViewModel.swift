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
    private var currentFilter: CIFilter?
    
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
                  let inputImage = UIImage(data: imageData)?.fixedOrientation else {
                await changeLoadingStatus()
                return
            }
            
            await setup(imageData)
            
            beginImage = CIImage(image: inputImage)
            
            if currentFilter != nil {
                currentFilter?.setValue(beginImage, forKey: kCIInputImageKey)
            } else {
                let processedImage = Image(uiImage: inputImage)
                await setup(processedImage)
            }
            
            await applyProcessing()
        }
    }
    
    func applyFilter(_ filter: CIFilter?) {
        currentFilter = filter
        loadImage()
    }
    
    func updateEdited(_ uiImage: UIImage) {
        let image = Image(uiImage: uiImage)
        let data = uiImage.pngData()
        imageData = data
        processedImage = image
    }
    
    // MARK: - Private Methods:
    @MainActor
    private func changeLoadingStatus() {
        isLoading.toggle()
    }
    
    @MainActor
    private func setup(_ imageData: Data) {
        self.imageData = imageData
    }
    
    @MainActor
    private func setup(_ processedImage: Image) {
        self.processedImage = processedImage
    }
    
    @MainActor
    private func applyProcessing() {
        changeLoadingStatus()

        if currentFilter != nil {
            guard let outputImage = currentFilter?.outputImage,
                  let cgImage = context.createCGImage(outputImage, from: outputImage.extent) else { return }
            
            let uiImage = UIImage(cgImage: cgImage)
            processedImage = Image(uiImage: uiImage)
            imageData = uiImage.pngData()
        }
    }
    
    private func setupSelectedImageObserver() {
        $selectedItem
            .receive(on: DispatchQueue.main)
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
