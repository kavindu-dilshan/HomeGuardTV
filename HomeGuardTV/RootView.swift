import SwiftUI

struct RootView: View {
    enum HomeSection: CaseIterable {
        case dashboard
        case cameras
        case alerts
        case settings
    }

    @State private var selected: HomeSection = .dashboard
    private let sidebarWidth: CGFloat = 360

    var body: some View {
        HStack(spacing: 0) {
            SidebarView(selected: $selected, width: sidebarWidth)
                .frame(width: sidebarWidth)
                .background(Color(white: 0.10))

            ZStack {
                LinearGradient(
                    gradient: Gradient(colors: [Color(white: 0.12), Color(white: 0.08)]),
                    startPoint: .top, endPoint: .bottom
                )
                contentView
                    .padding(.top, 40)
                    .padding(.trailing, 40)
                    .padding(.bottom, 40)
                    .padding(.leading, 32)
            }
        }
        .ignoresSafeArea() // replaces the black background
    }

    @ViewBuilder
    private var contentView: some View {
        switch selected {
        case .dashboard:
            DashboardView()
        case .cameras:
            CamerasView()
        case .alerts:
            AlertsView()
        case .settings:
            SettingsView()
        }
    }
}
