import Combine
import SwiftUI
import PhotosUI

final class ImageEditorViewModel: ImageEditorViewModelProtocol {
    
    // MARK: - Publishers:
    @Published var selectedImage: PhotosPickerItem?
    @Published var image: Image?
    
    // MARK: - Constans and Variables:
    private var cancellable = Set<AnyCancellable>()
    
    // MARK: - Lifecycle:
    init() {
        setupSelectedImageObserver()
    }
    
    // MARK: - Public Methods:
    func loadImage() {
        Task {
            if let loadedImage = try? await selectedImage?.loadTransferable(type: Image.self) {
                await setup(loadedImage)
            }
        }
    }
    
    // MARK: - Private Methods:
    private func setupSelectedImageObserver() {
        $selectedImage
            .sink { [weak self] _ in
                guard let self else { return }
                self.loadImage()
            }
            .store(in: &cancellable)
    }
    
    @MainActor
    private func setup(_ loadedImage: Image) {
        image = loadedImage
    }
}
