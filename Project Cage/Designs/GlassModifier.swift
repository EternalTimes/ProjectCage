//
//  GlassModifier.swift
//  Project Cage
//
//  Created by Predix on 5/9/26.
//


import SwiftUI

// MARK: - Liquid Glass Helpers

extension View {
    func projectGlassPanel(cornerRadius: CGFloat = 22) -> some View {
        self
            .glassEffect(.regular, in: .rect(cornerRadius: cornerRadius))
            .shadow(color: .black.opacity(0.055), radius: 24, y: 14)
    }

    func projectGlassCapsule() -> some View {
        self
            .glassEffect(.regular.interactive(), in: Capsule())
    }
}
