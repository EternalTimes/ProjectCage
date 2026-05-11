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
        case .tablet, .spatial:
            return 2
        case .desktop:
            return 2
        }
    }

    private var horizontalPadding: CGFloat {
        switch layout {
        case .phone: 16
        case .tablet: 24
        case .desktop: 28
        case .spatial: 32
        }
    }

    private var topPadding: CGFloat {
        switch layout {
        case .phone: 18
        case .tablet: 24
        case .desktop: 26
        case .spatial: 32
        }
    }

    private var spacing: CGFloat {
        switch layout {
        case .phone: 14
        case .tablet: 16
        case .desktop: 16
        case .spatial: 20
        }
    }

    private var bottomBarPadding: CGFloat {
        switch layout {
        case .phone: 10
        case .tablet: 16
        case .desktop: 22
        case .spatial: 28
        }
    }
}