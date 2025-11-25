import SwiftUI

struct SidebarView: View {
    @Binding var selected: RootView.HomeSection
    let width: CGFloat

    @State private var focusedIndex: Int = 0

    private struct Item: Identifiable {
        let section: RootView.HomeSection
        let title: String
        let systemImage: String
        var id: RootView.HomeSection { section }
    }

    private let items: [Item] = [
        Item(section: .dashboard, title: "Dashboard", systemImage: "house"),
        Item(section: .cameras,   title: "Cameras",   systemImage: "camera"),
        Item(section: .alerts,    title: "Alerts",    systemImage: "bell"),
        Item(section: .settings,  title: "Settings",  systemImage: "gear")
    ]

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("HomeGuard")
                .font(.title3)
                .fontWeight(.semibold)
                .foregroundColor(Color.green)
                .lineLimit(1)
                .minimumScaleFactor(0.9)
                .padding(.top, 48)
                .padding(.horizontal, 24)
                .padding(.bottom, 24)

            VStack(alignment: .leading, spacing: 16) {
                ForEach(Array(items.enumerated()), id: \.element.id) { idx, item in
                    SidebarItemButton(
                        title: item.title,
                        systemImage: item.systemImage,
                        isSelected: selected == item.section
                    ) {
                        selected = item.section
                        focusedIndex = idx
                    }
                }
            }
            .padding(.horizontal, 12)
            .padding(.bottom, 24)

            Spacer(minLength: 0)
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .background(Color(white: 0.10))
        .onAppear {
            if let start = items.firstIndex(where: { $0.section == selected }) {
                focusedIndex = start
            }
        }
        .onChange(of: selected) { newValue in
            if let idx = items.firstIndex(where: { $0.section == newValue }) {
                focusedIndex = idx
            }
        }
        .onMoveCommand { direction in
            switch direction {
            case .up:
                focusedIndex = max(0, focusedIndex - 1)
                selected = items[focusedIndex].section
            case .down:
                focusedIndex = min(items.count - 1, focusedIndex + 1)
                selected = items[focusedIndex].section
            default:
                break
            }
        }
    }
}

private struct SidebarItemButton: View {
    let title: String
    let systemImage: String
    let isSelected: Bool
    let action: () -> Void

    @Environment(\.isFocused) private var isFocused: Bool

    private let highlightFill = Color.white.opacity(0.08)
    private let selectedFill = Color.green.opacity(0.18)
    private let textColor = Color(white: 0.85)
    private let iconColor = Color(white: 0.85)
    private let selectedTextColor = Color.white
    private let accentGreen = Color.green

    var body: some View {
        Button(action: action) {
            HStack(spacing: 16) {
                Image(systemName: systemImage)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(isSelected ? accentGreen : iconColor)
                    .frame(width: 44, alignment: .center)

                Text(title)
                    .font(.system(size: 28, weight: .semibold))
                    .foregroundColor(isSelected ? selectedTextColor : textColor)
                    .lineLimit(1)
                    .minimumScaleFactor(0.95)

                Spacer(minLength: 0)
            }
            .padding(.vertical, 18)
            .padding(.horizontal, 12)
            .frame(maxWidth: .infinity, minHeight: 72)
            .background(
                RoundedRectangle(cornerRadius: 16, style: .continuous)
                    .fill(isSelected ? selectedFill : (isFocused ? highlightFill : Color.clear))
            )
            .overlay(
                Rectangle()
                    .fill(accentGreen)
                    .frame(width: isSelected ? 6 : 0)
                    .cornerRadius(3)
                    .opacity(isSelected ? 1 : 0)
                , alignment: .trailing
            )
            .contentShape(Rectangle())
        }
        .buttonStyle(PlainButtonStyle())
        .focusable(true)
        .padding(.horizontal, 4)
        .onChange(of: isFocused) { focused in
            if focused { action() }
        }
        .animation(.easeOut(duration: 0.15), value: isSelected)
        .animation(.easeOut(duration: 0.15), value: isFocused)
    }
}
