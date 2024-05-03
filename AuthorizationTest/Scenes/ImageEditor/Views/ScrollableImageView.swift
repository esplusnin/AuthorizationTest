import SwiftUI

struct ScrollableImageView<Content>: View where Content: View {
    
    // MARK: - Bindings:
    @Binding var currentZoom: Double
    @Binding var totalZoom: Double
    
    // MARK: - UI:
    var content: () -> Content
    
    var body: some View {
        content()
            .scaleEffect(currentZoom + totalZoom)
            .gesture(
                MagnificationGesture()
                    .onChanged { value in
                        currentZoom = value.magnitude - 1
                    }
                    .onEnded { value in
                        totalZoom += currentZoom
                        currentZoom = 0
                    }
            )
            .accessibilityZoomAction { action in
                if action.direction == .zoomIn {
                    totalZoom += 1
                } else {
                    totalZoom -= 1
                }
            }
    }
}
