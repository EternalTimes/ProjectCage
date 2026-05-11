import SwiftUI

extension View {
    func projectGlassPanel(cornerRadius: CGFloat = 24) -> some View {
        self
            .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.06), radius: 22, y: 12)
    }

    func projectGlassCapsule() -> some View {
        self
            .glassEffect(.regular.interactive(), in: Capsule())
            .shadow(color: .black.opacity(0.08), radius: 18, y: 8)
    }
}