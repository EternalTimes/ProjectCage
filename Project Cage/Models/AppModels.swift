//
//  AppTab.swift
//  Project Cage
//
//  Created by Predix on 5/9/26.
//


import SwiftUI

enum AppTab: String, CaseIterable, Identifiable {
    case dashboard = "Dashboard"
    case rules = "Rules"
    case settings = "Settings"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .dashboard:
            return "square.grid.2x2.fill"
        case .rules:
            return "list.bullet"
        case .settings:
            return "gearshape.fill"
        }
    }
}

enum ProxyMode: String, CaseIterable, Identifiable {
    case rule = "Rule"
    case global = "Global"
    case direct = "Direct"

    var id: String { rawValue }

    var icon: String {
        switch self {
        case .rule:
            return "square.grid.2x2.fill"
        case .global:
            return "globe"
        case .direct:
            return "paperplane.fill"
        }
    }
}

enum DashboardLayout {
    case phone
    case tablet
    case desktop
    case spatial
}