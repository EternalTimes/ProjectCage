//
//  DshboardComponents.swift
//  Project Cage
//
//  Created by Predix on 5/9/26.
//

import SwiftUI

// MARK: - Status

struct StatusPill: View {
    let isRunning: Bool

    var body: some View {
        HStack(spacing: 8) {
            Circle()
                .fill(isRunning ? .green : .orange)
                .frame(width: 10, height: 10)

            Text(isRunning ? "Proxy is Running" : "Proxy is Stopped")
                .font(.system(size: 13, weight: .medium))
        }
        .padding(.horizontal, 16)
        .frame(height: 42)
        .projectGlassCapsule()
    }
}

// MARK: - Bottom Tab Bar

struct BottomTabBar: View {
    @Binding var selectedTab: AppTab

    var body: some View {
        HStack(spacing: 8) {
            ForEach(AppTab.allCases) { tab in
                Button {
                    withAnimation(.spring(response: 0.28, dampingFraction: 0.82)) {
                        selectedTab = tab
                    }
                } label: {
                    HStack(spacing: 8) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 16, weight: .semibold))

                        Text(tab.rawValue)
                            .font(.system(size: 13, weight: .semibold))
                    }
                    .foregroundStyle(selectedTab == tab ? .blue : .primary.opacity(0.72))
                    .frame(width: 132, height: 46)
                    .background {
                        if selectedTab == tab {
                            Capsule()
                                .fill(.blue.opacity(0.12))
                                .overlay {
                                    Capsule()
                                        .stroke(.white.opacity(0.55), lineWidth: 1)
                                }
                        }
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(8)
        .projectGlassCapsule()
        .shadow(color: .black.opacity(0.12), radius: 24, y: 12)
    }
}

// MARK: - Background

struct LiquidBackground: View {
    var body: some View {
        ZStack {
            LinearGradient(
                colors: [
                    Color.white,
                    Color(red: 0.965, green: 0.975, blue: 0.99),
                    Color(red: 0.945, green: 0.960, blue: 0.985)
                ],
                startPoint: .topLeading,
                endPoint: .bottomTrailing
            )

            Circle()
                .fill(.blue.opacity(0.08))
                .frame(width: 420, height: 420)
                .blur(radius: 80)
                .offset(x: -420, y: -260)

            Circle()
                .fill(.cyan.opacity(0.07))
                .frame(width: 520, height: 520)
                .blur(radius: 95)
                .offset(x: 440, y: 260)

            Circle()
                .fill(.purple.opacity(0.035))
                .frame(width: 360, height: 360)
                .blur(radius: 80)
                .offset(x: 120, y: -280)
        }
    }
}

// MARK: - Cards

struct GlassCard<Content: View>: View {
    let title: String
    let icon: String
    let content: Content

    init(title: String, icon: String, @ViewBuilder content: () -> Content) {
        self.title = title
        self.icon = icon
        self.content = content()
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack(spacing: 9) {
                Image(systemName: icon)
                    .font(.system(size: 15, weight: .semibold))

                Text(title)
                    .font(.system(size: 16, weight: .semibold))

                Spacer()
            }

            content
        }
        .padding(16)
        .projectGlassPanel(cornerRadius: 24)
    }
}

struct SubscriptionCard: View {
    var body: some View {
        GlassCard(title: "Subscription", icon: "wifi.router") {
            VStack(spacing: 13) {
                HStack {
                    RoundedIcon(systemName: "cloud.fill", tint: .blue)

                    Text("SakuraCat")
                        .font(.system(size: 15, weight: .semibold))

                    Image(systemName: "arrow.up.forward.square")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    Badge("Premium", tint: .blue)
                }

                InfoRow("Status", "Active", valueColor: .green)
                InfoRow("Expires", "May 21, 2026  (12 days left)")
                InfoRow("Data Usage", "80.4 GB / 480 GB  (17%)")

                ProgressView(value: 0.17)
                    .tint(.blue)

                InfoRow("Updated", "May 08, 2026 16:24")

                CardButton(title: "Manage Subscription", icon: "gearshape")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 220)
    }
}

struct CurrentNodeCard: View {
    var body: some View {
        GlassCard(title: "Current Node", icon: "location") {
            VStack(spacing: 13) {
                HStack {
                    Text("🇸🇬")

                    Text("Singapore – IEPL 02")
                        .font(.system(size: 15, weight: .semibold))

                    Spacer()

                    Badge("28 ms", tint: .green)
                }

                InfoRow("Protocol", "Trojan UDP")
                InfoRow("Node Type", "IEPL")
                InfoRow("IP Address", "103.18.45.67")
                InfoRow("Load", "23%")

                CardButton(title: "Select Node", icon: "list.bullet")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 220)
    }
}

struct NetworkAdapterCard: View {
    var body: some View {
        GlassCard(title: "Network Adapter", icon: "display") {
            VStack(spacing: 13) {
                HStack {
                    Text("Mode")
                        .font(.caption)
                        .foregroundStyle(.secondary)

                    Spacer()

                    HStack(spacing: 0) {
                        Text("System Proxy")
                            .font(.caption.weight(.semibold))
                            .foregroundStyle(.blue)
                            .padding(.horizontal, 16)
                            .frame(height: 28)
                            .background {
                                RoundedRectangle(cornerRadius: 9, style: .continuous)
                                    .fill(.blue.opacity(0.12))
                                    .overlay {
                                        RoundedRectangle(cornerRadius: 9, style: .continuous)
                                            .stroke(.blue.opacity(0.25), lineWidth: 1)
                                    }
                            }

                        Text("TUN Mode")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                            .padding(.horizontal, 16)
                            .frame(height: 28)
                    }
                    .padding(3)
                    .background {
                        RoundedRectangle(cornerRadius: 12, style: .continuous)
                            .fill(.black.opacity(0.045))
                    }
                }

                InfoRow("Interface", "utun3")
                InfoRow("IPv4", "10.0.0.2")
                InfoRow("Gateway", "10.0.0.1")
                InfoRow("DNS", "1.1.1.1, 8.8.8.8")

                CardButton(title: "Network Settings", icon: "gearshape")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 220)
    }
}

struct ProxyModeCard: View {
    @Binding var proxyMode: ProxyMode

    var body: some View {
        GlassCard(title: "Proxy Mode", icon: "circle.circle") {
            VStack(alignment: .leading, spacing: 14) {
                HStack(spacing: 0) {
                    ForEach(ProxyMode.allCases) { mode in
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.85)) {
                                proxyMode = mode
                            }
                        } label: {
                            HStack(spacing: 7) {
                                Image(systemName: mode.icon)
                                Text(mode.rawValue)
                            }
                            .font(.system(size: 13, weight: .medium))
                            .foregroundStyle(proxyMode == mode ? .blue : .primary)
                            .frame(maxWidth: .infinity)
                            .frame(height: 38)
                            .background {
                                if proxyMode == mode {
                                    RoundedRectangle(cornerRadius: 11, style: .continuous)
                                        .fill(.blue.opacity(0.12))
                                        .overlay {
                                            RoundedRectangle(cornerRadius: 11, style: .continuous)
                                                .stroke(.blue.opacity(0.35), lineWidth: 1)
                                        }
                                }
                            }
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(4)
                .background {
                    RoundedRectangle(cornerRadius: 14, style: .continuous)
                        .fill(.black.opacity(0.035))
                }

                Text("Use rules to determine proxy behavior.")
                    .font(.caption)
                    .foregroundStyle(.secondary)

                CardButton(title: "Manage Rules", icon: "list.bullet")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 170)
    }
}

struct TrafficStatisticsCard: View {
    private let upload: [CGFloat] = [
        2.1, 2.0, 2.2, 2.8, 2.5, 2.9, 2.6, 3.0,
        2.7, 2.8, 3.1, 2.6, 2.9, 3.2, 2.8, 2.7,
        3.0, 3.4, 3.2, 3.1, 2.8, 3.0, 2.9, 3.3, 3.1
    ]

    private let download: [CGFloat] = [
        1.4, 1.6, 1.8, 2.0, 1.9, 2.1, 1.7, 1.9,
        1.6, 1.8, 2.0, 1.9, 1.7, 2.1, 2.2, 1.8,
        1.7, 2.0, 1.9, 1.6, 1.8, 1.7, 1.9, 2.1, 1.8
    ]

    var body: some View {
        GlassCard(title: "Traffic Statistics", icon: "chart.line.uptrend.xyaxis") {
            VStack(spacing: 14) {
                HStack {
                    LegendDot(color: .blue, text: "Upload")
                    LegendDot(color: .green, text: "Download")

                    Spacer()

                    Text("Realtime")
                        .font(.caption)
                        .padding(.horizontal, 12)
                        .frame(height: 28)
                        .projectGlassCapsule()
                }

                ZStack {
                    VStack(spacing: 24) {
                        ForEach(0..<4, id: \.self) { _ in
                            Divider()
                                .opacity(0.45)
                        }
                    }

                    TrafficLine(values: upload, maxValue: 6)
                        .stroke(
                            .blue,
                            style: StrokeStyle(
                                lineWidth: 2,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )

                    TrafficLine(values: download, maxValue: 6)
                        .stroke(
                            .green,
                            style: StrokeStyle(
                                lineWidth: 2,
                                lineCap: .round,
                                lineJoin: .round
                            )
                        )
                }
                .frame(height: 118)

                HStack {
                    ForEach(["16:38", "16:40", "16:42", "16:44", "16:46", "16:48", "16:50"], id: \.self) { time in
                        Text(time)
                            .font(.caption2)
                            .foregroundStyle(.secondary)

                        if time != "16:50" {
                            Spacer()
                        }
                    }
                }

                HStack(spacing: 12) {
                    TrafficMetric(
                        title: "Upload",
                        value: "1.25 MB/s",
                        subtitle: "Total 12.6 GB",
                        icon: "arrow.up",
                        tint: .blue
                    )

                    TrafficMetric(
                        title: "Download",
                        value: "3.42 MB/s",
                        subtitle: "Total 38.7 GB",
                        icon: "arrow.down",
                        tint: .green
                    )

                    TrafficMetric(
                        title: "Total",
                        value: "53.3 GB",
                        subtitle: "Since May 08",
                        icon: "scope",
                        tint: .secondary
                    )
                }
            }
        }
        .frame(maxWidth: .infinity, minHeight: 330)
    }
}

struct QuickTestCard: View {
    var body: some View {
        GlassCard(title: "Quick Test", icon: "waveform.path.ecg") {
            VStack(spacing: 12) {
                TestRow(
                    icon: "G",
                    name: "Google",
                    domain: "www.google.com",
                    latency: "32 ms",
                    tint: .green
                )

                TestRow(
                    icon: "☁️",
                    name: "Cloudflare",
                    domain: "www.cloudflare.com",
                    latency: "28 ms",
                    tint: .green
                )

                TestRow(
                    icon: "▶",
                    name: "YouTube",
                    domain: "www.youtube.com",
                    latency: "48 ms",
                    tint: .orange
                )

                CardButton(title: "Run Test", icon: "play")
                    .padding(.top, 6)
            }
        }
        .frame(maxWidth: .infinity, minHeight: 250)
    }
}

struct ConnectionOverviewCard: View {
    var body: some View {
        GlassCard(title: "Connection Overview", icon: "point.3.connected.trianglepath.dotted") {
            VStack(spacing: 12) {
                HStack(spacing: 12) {
                    MetricTile(
                        title: "Connections",
                        value: "24",
                        subtitle: "Active",
                        icon: "person.2.fill",
                        tint: .blue
                    )

                    MetricTile(
                        title: "Success Rate",
                        value: "99.6%",
                        subtitle: "Last 24h",
                        icon: "checkmark.circle.fill",
                        tint: .green
                    )

                    MetricTile(
                        title: "Rejected",
                        value: "3",
                        subtitle: "Last 24h",
                        icon: "shield.fill",
                        tint: .secondary
                    )

                    MetricTile(
                        title: "Uptime",
                        value: "3d 14h",
                        subtitle: "Since Start",
                        icon: "clock.fill",
                        tint: .secondary
                    )
                }

                CardButton(title: "View Connections", icon: "list.bullet")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 180)
    }
}

struct IPInformationCard: View {
    var body: some View {
        GlassCard(title: "IP Information", icon: "location.circle") {
            VStack(spacing: 12) {
                HStack {
                    Text("🇺🇸")

                    Text("United States")
                        .font(.system(size: 14, weight: .semibold))

                    Spacer()

                    Badge("IPv4", tint: .green)
                }

                InfoRow("IP Address", "104.16.85.29")
                InfoRow("ISP", "Cloudflare, Inc.")
                InfoRow("ASN", "AS13335")
                InfoRow("Location", "San Francisco, California")

                CardButton(title: "Refresh", icon: "arrow.clockwise")
            }
        }
        .frame(maxWidth: .infinity, minHeight: 180)
    }
}

// MARK: - Small Components

struct InfoRow: View {
    let label: String
    let value: String
    let valueColor: Color

    init(_ label: String, _ value: String, valueColor: Color = .primary) {
        self.label = label
        self.value = value
        self.valueColor = valueColor
    }

    var body: some View {
        HStack {
            Text(label)
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()

            Text(value)
                .font(.caption)
                .foregroundStyle(valueColor)
                .monospacedDigit()
        }
    }
}

struct Badge: View {
    let text: String
    let tint: Color

    init(_ text: String, tint: Color) {
        self.text = text
        self.tint = tint
    }

    var body: some View {
        Text(text)
            .font(.caption.weight(.semibold))
            .foregroundStyle(tint)
            .padding(.horizontal, 10)
            .frame(height: 24)
            .background {
                Capsule()
                    .fill(tint.opacity(0.12))
            }
    }
}

struct RoundedIcon: View {
    let systemName: String
    let tint: Color

    var body: some View {
        Image(systemName: systemName)
            .font(.system(size: 15, weight: .semibold))
            .foregroundStyle(tint)
            .frame(width: 34, height: 34)
            .background {
                RoundedRectangle(cornerRadius: 11, style: .continuous)
                    .fill(tint.opacity(0.12))
            }
    }
}

struct CardButton: View {
    let title: String
    let icon: String

    var body: some View {
        Button {} label: {
            Label(title, systemImage: icon)
                .font(.system(size: 13, weight: .medium))
                .frame(maxWidth: .infinity)
                .frame(height: 40)
        }
        .buttonStyle(.glass)
    }
}

struct LegendDot: View {
    let color: Color
    let text: String

    var body: some View {
        HStack(spacing: 6) {
            Circle()
                .fill(color)
                .frame(width: 7, height: 7)

            Text(text)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
    }
}

struct TrafficMetric: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let tint: Color

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: icon)
                .font(.system(size: 16, weight: .bold))
                .foregroundStyle(tint)
                .frame(width: 34, height: 34)
                .background {
                    Circle()
                        .fill(tint.opacity(0.12))
                }

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.caption2)
                    .foregroundStyle(.secondary)

                Text(value)
                    .font(.system(size: 15, weight: .bold))
                    .monospacedDigit()

                Text(subtitle)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()
        }
        .padding(12)
        .projectGlassPanel(cornerRadius: 16)
    }
}

struct MetricTile: View {
    let title: String
    let value: String
    let subtitle: String
    let icon: String
    let tint: Color

    var body: some View {
        VStack(alignment: .leading, spacing: 7) {
            Image(systemName: icon)
                .foregroundStyle(tint)

            Text(title)
                .font(.caption2)
                .foregroundStyle(.secondary)

            Text(value)
                .font(.system(size: 19, weight: .bold))
                .monospacedDigit()

            Text(subtitle)
                .font(.caption2)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(12)
        .projectGlassPanel(cornerRadius: 16)
    }
}

struct TestRow: View {
    let icon: String
    let name: String
    let domain: String
    let latency: String
    let tint: Color

    var body: some View {
        HStack(spacing: 11) {
            Text(icon)
                .font(.system(size: 19, weight: .bold))
                .frame(width: 28, height: 28)

            VStack(alignment: .leading, spacing: 2) {
                Text(name)
                    .font(.system(size: 13, weight: .semibold))

                Text(domain)
                    .font(.caption2)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Badge(latency, tint: tint)
        }
    }
}

// MARK: - Drawing

struct TrafficLine: Shape {
    let values: [CGFloat]
    let maxValue: CGFloat

    func path(in rect: CGRect) -> Path {
        var path = Path()

        guard values.count > 1 else {
            return path
        }

        let step = rect.width / CGFloat(values.count - 1)

        for index in values.indices {
            let x = rect.minX + CGFloat(index) * step
            let normalized = min(max(values[index] / maxValue, 0), 1)
            let y = rect.maxY - normalized * rect.height
            let point = CGPoint(x: x, y: y)

            if index == values.startIndex {
                path.move(to: point)
            } else {
                path.addLine(to: point)
            }
        }

        return path
    }
}

