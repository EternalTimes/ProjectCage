import SwiftUI

struct AppRootView: View {
    var body: some View {
        #if os(macOS)
        DashboardView(layout: .desktop)

        #elseif os(visionOS)
        DashboardView(layout: .spatial)

        #else
        AdaptiveMobileDashboard()
        #endif
    }
}

enum DashboardLayout {
    case phone
    case tablet
    case desktop
    case spatial
}