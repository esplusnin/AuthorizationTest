import SwiftUI

extension LinearGradient {
    static let backgroundGradient = LinearGradient(stops: [.init(color: .blue.opacity(0.8), location: 0.1),
                                                           .init(color: .blue.opacity(0.3), location: 0.3),
                                                           .init(color: .white, location: 1)],
                                                   startPoint: .top, endPoint: .bottomTrailing)
}
