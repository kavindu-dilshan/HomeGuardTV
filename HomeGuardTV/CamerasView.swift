import SwiftUI

struct CamerasView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                CamerasHeaderRow()

                Divider().background(Color.white.opacity(0.06))

                // Controls row
                HStack(spacing: 12) {
                    ModePill(title: "Grid", selected: true)
                    ModePill(title: "List", selected: false)

                    Text("Filter:")
                        .foregroundColor(Color.white.opacity(0.85))
                        .font(.subheadline)
                        .padding(.leading, 12)

                    FilterDropdown(title: "All locations")

                    Spacer(minLength: 0)
                }

                // Grid of camera tiles (2 rows × 3 columns)
                LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 32), count: 3), spacing: 32) {
                    CameraGridTile(
                        name: "Front Door",
                        badges: [.init("Live", .danger), .init("Motion", .muted)]
                    )
                    CameraGridTile(
                        name: "Back Yard",
                        badges: [.init("Live", .danger), .init("Normal", .success)]
                    )
                    CameraGridTile(
                        name: "Garage",
                        badges: [.init("Offline", .mutedDot), .init("Check", .warning)]
                    )
                    CameraGridTile(
                        name: "Living Room",
                        badges: [.init("Live", .danger), .init("Sound", .info)]
                    )
                    CameraGridTile(
                        name: "Driveway",
                        badges: [.init("Live", .danger), .init("Normal", .success)]
                    )
                    CameraGridTile(
                        name: "Back Door",
                        badges: [.init("Live", .danger), .init("Motion", .muted)]
                    )
                }
            }
            .padding(.top, 32)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Header
private struct CamerasHeaderRow: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Cameras")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Tap a camera to view more details")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.subheadline)
            }
            Spacer()
            Text("6 cameras online")
                .foregroundColor(Color("AccentGreen"))
                .font(.subheadline)
        }
    }
}

// MARK: - Controls
private struct ModePill: View {
    var title: String
    var selected: Bool
    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 8)
            .background(
                Capsule().fill(selected ? Color("AccentGreen") : Color("CardBackground").opacity(0.85))
            )
    }
}

private struct FilterDropdown: View {
    var title: String
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            Image(systemName: "chevron.down")
                .font(.footnote)
                .foregroundColor(.white)
                .opacity(0.9)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("CardBackground").opacity(0.85))
        )
    }
}

// MARK: - Camera Tile
private struct CameraGridTile: View {
    struct Badge: Hashable { let text: String; let style: StatusChip.Style; init(_ t: String, _ s: StatusChip.Style) { text = t; style = s } }
    var name: String
    var badges: [Badge]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black)
                    .frame(height: 220)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.08), lineWidth: 2)
                    )

                HStack(spacing: 8) {
                    ForEach(badges, id: \.self) { item in
                        StatusChip(text: item.text, style: item.style)
                    }
                }
                .padding(10)
            }
            Text(name)
                .font(.subheadline)
                .foregroundColor(.white)
                .padding(.leading, 4)
        }
    }
}

private struct StatusChip: View {
    enum Style { case danger, success, info, warning, muted, mutedDot }
    var text: String
    var style: Style

    var body: some View {
        HStack(spacing: style == .mutedDot ? 6 : 0) {
            if style == .mutedDot {
                Circle()
                    .fill(Color.white.opacity(0.7))
                    .frame(width: 8, height: 8)
            }
            Text(text)
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundColor(.white)
                .padding(.horizontal, style == .mutedDot ? 10 : 12)
                .padding(.vertical, 6)
                .background(background)
                .clipShape(Capsule())
        }
    }

    private var background: Color {
        switch style {
        case .danger: return Color("DangerRed")
        case .success: return Color("AccentGreen")
        case .info: return Color.blue.opacity(0.85)
        case .warning: return Color.yellow.opacity(0.9)
        case .muted: return Color.white.opacity(0.18)
        case .mutedDot: return Color.white.opacity(0.18)
        }
    }
}
