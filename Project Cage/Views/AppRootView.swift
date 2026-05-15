//
//  AppRootView.swift
//  Project Cage
//
//  Created by Predix on 5/9/26.
//


import SwiftUI

struct AppRootView: View {
    var body: some View {
        #if os(macOS)
        DashboardView(layout: DashboardLayout.desktop)

        #elseif os(visionOS)
        DashboardView(layout: DashboardLayout.spatial)

        #else
        AdaptiveMobileDashboard()
        #endif
    }
}

struct AdaptiveMobileDashboard: View {
    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            DashboardView(layout: DashboardLayout.phone)
        } else {
            DashboardView(layout: DashboardLayout.tablet)
        }
    }
}
