struct DashboardHeader: View {
    @Binding var isProxyRunning: Bool

    @Environment(\.horizontalSizeClass) private var horizontalSizeClass

    var body: some View {
        if horizontalSizeClass == .compact {
            compactHeader
        } else {
            regularHeader
        }
    }

    private var regularHeader: some View {
        HStack {
            titleBlock

            Spacer()

            StatusPill(isRunning: isProxyRunning)

            startButton
        }
    }

    private var compactHeader: some View {
        VStack(alignment: .leading, spacing: 14) {
            titleBlock

            HStack {
                StatusPill(isRunning: isProxyRunning)

                Spacer()

                startButton
            }
        }
    }

    private var titleBlock: some View {
        VStack(alignment: .leading, spacing: 5) {
            Text("Dashboard")
                .font(.system(size: 30, weight: .bold, design: .rounded))

            Text("Monitor your proxy network and connection status.")
                .font(.system(size: 13))
                .foregroundStyle(.secondary)
        }
    }

    private var startButton: some View {
        Button {
            withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
                isProxyRunning.toggle()
            }
        } label: {
            Label(
                isProxyRunning ? "Stop" : "Start",
                systemImage: isProxyRunning ? "stop.fill" : "play.fill"
            )
            .frame(minWidth: 112)
        }
        .buttonStyle(.glassProminent)
        .tint(isProxyRunning ? .red : .blue)
    }
}