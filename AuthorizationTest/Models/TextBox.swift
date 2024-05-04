import SwiftUI

struct TextBox: Identifiable {
    var id = UUID().uuidString
    var text: String
    var isBold: Bool
    var offset: CGSize = .zero
    var lastOffset: CGSize = .zero
    var textColor: Color = .universalBlack
    var textSize: Int = 10
    
    mutating func reset() {
        text = ""
        isBold = false
        offset = .zero
        lastOffset = .zero
        textColor = .universalBlack
    }
}
