import SwiftUI

struct DashboardView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                HeaderRow()

                Divider().background(Color.white.opacity(0.06))

                VStack(alignment: .leading, spacing: 16) {
                    Text("Home Status")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    HStack(spacing: 20) {
                        StatusCard(
                            title: "Armed: Away",
                            subtitle: "All entry points secured",
                            systemImage: "shield.fill",
                            tone: .accent
                        )

                        StatusCard(
                            title: "Power",
                            subtitle: "Normal · Backup Ready",
                            systemImage: "bolt.fill",
                            tone: .neutral
                        )

                        StatusCard(
                            title: "Network",
                            subtitle: "Online",
                            systemImage: "wifi",
                            tone: .neutral
                        )
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Live Cameras")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    LazyVGrid(columns: Array(repeating: GridItem(.flexible(), spacing: 20), count: 2), spacing: 20) {
                        CameraTile(
                            name: "Front Door",
                            badges: [
                                .init(text: "Live", style: .danger),
                                .init(text: "Motion · 2m ago", style: .muted)
                            ]
                        )
                        CameraTile(
                            name: "Back Yard",
                            badges: [
                                .init(text: "Live", style: .danger),
                                .init(text: "Motion · 2m ago", style: .muted)
                            ]
                        )
                        CameraTile(
                            name: "Garage",
                            badges: [
                                .init(text: "Idle", style: .warning)
                            ]
                        )
                        CameraTile(
                            name: "Living Room",
                            badges: [
                                .init(text: "Live", style: .danger),
                                .init(text: "Motion · 2m ago", style: .muted)
                            ]
                        )
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Quick Actions")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    HStack(spacing: 16) {
                        QuickActionButton(title: "Arm Away", systemImage: "shield.fill", tint: Color("AccentGreen"))
                        QuickActionButton(title: "Arm Home", systemImage: "lock.fill", tint: Color("CardBackground").opacity(0.85))
                        QuickActionButton(title: "Disarm", systemImage: "lock.open.fill", tint: Color("DangerRed"))
                    }
                }

                VStack(alignment: .leading, spacing: 16) {
                    Text("Recent Alerts")
                        .font(.title2)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)

                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 16) {
                            AlertPill(icon: "dot.radiowaves.left.and.right", tint: Color("DangerRed"), textLeft: "Motion · Front Door", textRight: "2m ago")
                            AlertPill(icon: "dot.radiowaves.left.and.right", tint: Color("AccentGreen").opacity(0.8), textLeft: "Motion · Back Yard", textRight: "18m ago")
                            AlertPill(icon: "dot.radiowaves.left.and.right", tint: Color.white.opacity(0.7), textLeft: "Camera · Garage", textRight: "1h ago")
                        }
                    }
                }
            }
            .padding(32)
        }
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

private struct HeaderRow: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text("HomeGuard TV")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Live Security Overview")
                    .font(.subheadline)
                    .foregroundColor(Color.white.opacity(0.7))
            }
            Spacer()
            HStack(spacing: 16) {
                Text("06:43 PM")
                    .font(.subheadline)
                    .foregroundColor(.white)

                Text("Protected")
                    .font(.footnote)
                    .fontWeight(.semibold)
                    .foregroundColor(.white)
                    .padding(.horizontal, 12)
                    .padding(.vertical, 6)
                    .background(
                        Capsule().fill(Color("AccentGreen").opacity(0.9))
                    )

                Circle()
                    .fill(Color.white.opacity(0.15))
                    .frame(width: 40, height: 40)
                    .overlay(
                        Image(systemName: "person.crop.circle")
                            .resizable()
                            .scaledToFit()
                            .foregroundColor(.white)
                            .padding(6)
                    )
            }
        }
    }
}

private enum CardTone {
    case accent
    case neutral
}

private struct StatusCard: View {
    var title: String
    var subtitle: String
    var systemImage: String
    var tone: CardTone = .neutral

    var body: some View {
        HStack(alignment: .center, spacing: 14) {
            Image(systemName: systemImage)
                .font(.title3)
                .foregroundColor(tone == .accent ? .white : Color.white.opacity(0.9))
                .frame(width: 24)

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .font(.subheadline)
                    .foregroundColor(tone == .accent ? .white : .white)
                Text(subtitle)
                    .font(.footnote)
                    .foregroundColor(tone == .accent ? Color.white.opacity(0.9) : Color.white.opacity(0.7))
            }
            Spacer()
        }
        .padding(20)
        .background(
            RoundedRectangle(cornerRadius: 18, style: .continuous)
                .fill(tone == .accent ? Color("AccentGreen") : Color("CardBackground").opacity(0.6))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 16, style: .continuous)
                .stroke(Color.white.opacity(0.07), lineWidth: 2)
        )
    }
}

private struct BadgeSpec: Hashable {
    enum Style { case danger, warning, muted }
    var text: String
    var style: Style
}

private struct CameraTile: View {
    var name: String
    var badges: [BadgeSpec]

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            ZStack(alignment: .topLeading) {
                RoundedRectangle(cornerRadius: 18, style: .continuous)
                    .fill(Color.black)
                    .frame(height: 210)
                    .overlay(
                        RoundedRectangle(cornerRadius: 18, style: .continuous)
                            .stroke(Color.white.opacity(0.07), lineWidth: 2)
                    )

                HStack(spacing: 8) {
                    ForEach(badges, id: \.self) { badge in
                        Text(badge.text)
                            .font(.caption)
                            .fontWeight(.semibold)
                            .foregroundColor(.white)
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(badgeBackground(for: badge.style))
                            .clipShape(Capsule())
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

    private func badgeBackground(for style: BadgeSpec.Style) -> Color {
        switch style {
        case .danger: return Color("DangerRed")
        case .warning: return Color.yellow.opacity(0.9)
        case .muted: return Color.white.opacity(0.18)
        }
    }
}

private struct QuickActionButton: View {
    var title: String
    var systemImage: String
    var tint: Color

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: systemImage)
                .font(.callout)
                .foregroundColor(.white)
            Text(title)
                .font(.subheadline)
                .foregroundColor(.white)
        }
        .padding(.vertical, 14)
        .padding(.horizontal, 20)
        .background(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .fill(tint)
        )
        .overlay(
            RoundedRectangle(cornerRadius: 12, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 2)
        )
    }
}

private struct AlertPill: View {
    var icon: String
    var tint: Color
    var textLeft: String
    var textRight: String

    var body: some View {
        HStack(spacing: 10) {
            Image(systemName: icon)
                .foregroundColor(tint)
            Text(textLeft)
                .foregroundColor(.white)
                .font(.subheadline)
            Circle()
                .fill(Color.white.opacity(0.25))
                .frame(width: 4, height: 4)
            Text(textRight)
                .foregroundColor(Color.white.opacity(0.7))
                .font(.footnote)
        }
        .padding(.horizontal, 14)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color("CardBackground").opacity(0.7))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .stroke(Color.white.opacity(0.08), lineWidth: 2)
        )
    }
}
