//
//  DashboardView.swift
//  Project Cage
//
//  Created by Predix on 5/9/26.
//

import SwiftUI

struct DashboardView: View {
    let layout: DashboardLayout

    @State private var selectedTab: AppTab = .dashboard
    @State private var isProxyRunning = false
    @State private var proxyMode: ProxyMode = .rule

    var body: some View {
        ZStack(alignment: .bottom) {
            LiquidBackground()
                .ignoresSafeArea()

            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: spacing) {
                    DashboardHeader(isProxyRunning: $isProxyRunning)

                    dashboardGrid
                }
                .padding(.horizontal, horizontalPadding)
                .padding(.top, topPadding)
                .padding(.bottom, 96)
            }

            BottomTabBar(selectedTab: $selectedTab)
                .padding(.bottom, bottomBarPadding)
        }
        #if os(macOS)
        .frame(minWidth: 1180, minHeight: 760)
        #endif
    }

    private var dashboardGrid: some View {
        LazyVGrid(columns: columns, spacing: spacing) {
            SubscriptionCard()
            CurrentNodeCard()
            NetworkAdapterCard()
            ProxyModeCard(proxyMode: $proxyMode)

            TrafficStatisticsCard()
                .gridCellColumns(trafficGridSpan)

            QuickTestCard()
            ConnectionOverviewCard()
            IPInformationCard()
        }
    }

    private var columns: [GridItem] {
        switch layout {
        case .phone:
            return [
                GridItem(.flexible(), spacing: spacing)
            ]

        case .tablet, .spatial:
            return [
                GridItem(.flexible(), spacing: spacing),
                GridItem(.flexible(), spacing: spacing)
            ]

        case .desktop:
            return [
                GridItem(.flexible(), spacing: spacing),
                GridItem(.flexible(), spacing: spacing),
                GridItem(.flexible(), spacing: spacing)
            ]
        }
    }

    private var trafficGridSpan: Int {
        switch layout {
        case .phone:
            return 1
        case .tablet, .spatial, .desktop:
            return 2
        }
    }

    private var horizontalPadding: CGFloat {
        switch layout {
        case .phone: return 16
        case .tablet: return 24
        case .desktop: return 28
        case .spatial: return 32
        }
    }

    private var topPadding: CGFloat {
        switch layout {
        case .phone: return 18
        case .tablet: return 24
        case .desktop: return 26
        case .spatial: return 32
        }
    }

    private var spacing: CGFloat {
        switch layout {
        case .phone: return 14
        case .tablet: return 16
        case .desktop: return 16
        case .spatial: return 20
        }
    }

    private var bottomBarPadding: CGFloat {
        switch layout {
        case .phone: return 10
        case .tablet: return 16
        case .desktop: return 22
        case .spatial: return 28
        }
    }
}
