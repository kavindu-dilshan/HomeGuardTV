import SwiftUI

struct AlertsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 24) {
                AlertsHeaderRow()

                Divider().background(Color.white.opacity(0.06))

                // Filter pills row
                HStack(spacing: 12) {
                    FilterPill(title: "All", selected: true)
                    FilterPill(title: "Motion", selected: false)
                    FilterPill(title: "Door/Lock", selected: false)
                    FilterPill(title: "Sound", selected: false)
                    FilterPill(title: "System", selected: false)
                    Spacer()
                }

                // Date range row (segment-like)
                HStack(spacing: 12) {
                    SegButton(title: "Today", selected: true, selectedTint: Color("DangerRed"))
                    SegButton(title: "Yesterday", selected: false, selectedTint: Color("DangerRed"))
                    SegButton(title: "Last 7 Days", selected: false, selectedTint: Color("DangerRed"))
                    Spacer()
                }

                // Alert list
                VStack(spacing: 14) {
                    AlertRowView(
                        icon: "waveform.path.ecg",
                        title: "Motion detected at Front Door",
                        subtitle: "Today · 18:42",
                        severity: .high,
                        actionTitle: "View Clip"
                    )

                    AlertRowView(
                        icon: "shippingbox",
                        title: "Package detected at Front Door",
                        subtitle: "Today · 17:10",
                        severity: .medium,
                        actionTitle: "View"
                    )

                    AlertRowView(
                        icon: "door.left.hand.closed",
                        title: "Back Door opened",
                        subtitle: "Today · 13:06",
                        severity: .high,
                        actionTitle: "View Clip"
                    )

                    AlertRowView(
                        icon: "wifi.exclamationmark",
                        title: "Garage Camera disconnected",
                        subtitle: "Today · 09:22",
                        severity: .system,
                        actionTitle: "Details"
                    )
                }
                .padding(.top, 4)
            }
            .padding(.top, 32)
            .padding(.horizontal, 40)
            .padding(.bottom, 40)
        }
        .background(Color("MainBackground").edgesIgnoringSafeArea(.all))
    }
}

// MARK: - Header
private struct AlertsHeaderRow: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 2) {
                EmptyView()
                Text("Alerts")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("View and review recent security events")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.subheadline)
            }
            .frame(maxWidth: .infinity, alignment: .leading)

            SmallActionButton(icon: "trash", title: "Clear All")
        }
    }
}

// MARK: - Controls
private struct FilterPill: View {
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

private struct SegButton: View {
    var title: String
    var selected: Bool
    var selectedTint: Color

    var body: some View {
        Text(title)
            .font(.subheadline)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 14)
            .padding(.vertical, 10)
            .frame(maxWidth: 260, alignment: .leading)
            .background(
                RoundedRectangle(cornerRadius: 10, style: .continuous)
                    .fill(selected ? selectedTint : Color("CardBackground").opacity(0.9))
            )
    }
}

// MARK: - Rows
private struct AlertRowView: View {
    enum Severity { case high, medium, system }
    var icon: String
    var title: String
    var subtitle: String
    var severity: Severity
    var actionTitle: String

    var body: some View {
        HStack(alignment: .center, spacing: 16) {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 44, height: 44)
                .overlay(
                    Image(systemName: icon)
                        .foregroundColor(.white)
                )

            VStack(alignment: .leading, spacing: 6) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.subheadline)
                Text(subtitle)
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.footnote)
            }

            Spacer()

            SeverityPill(severity: severity)

            SmallActionButton(icon: nil, title: actionTitle)
        }
        .padding(.horizontal, 16)
        .padding(.vertical, 14)
        .background(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .fill(Color("CardBackground").opacity(0.9))
        )
        .overlay(
            RoundedRectangle(cornerRadius: 14, style: .continuous)
                .stroke(Color.white.opacity(0.06), lineWidth: 2)
        )
    }
}

private struct SeverityPill: View {
    var severity: AlertRowView.Severity
    var body: some View {
        Text(text)
            .font(.footnote)
            .fontWeight(.semibold)
            .foregroundColor(.white)
            .padding(.horizontal, 12)
            .padding(.vertical, 6)
            .background(Capsule().fill(color))
    }

    private var text: String {
        switch severity {
        case .high: return "High"
        case .medium: return "Medium"
        case .system: return "System"
        }
    }

    private var color: Color {
        switch severity {
        case .high: return Color("AccentGreen")
        case .medium: return Color.yellow.opacity(0.9)
        case .system: return Color.white.opacity(0.2)
        }
    }
}

private struct SmallActionButton: View {
    var icon: String?
    var title: String

    var body: some View {
        HStack(spacing: 8) {
            if let icon = icon {
                Image(systemName: icon)
                    .foregroundColor(.white)
            }
            Text(title)
                .foregroundColor(.white)
                .font(.footnote)
            Image(systemName: "chevron.right")
                .foregroundColor(.white)
                .font(.footnote)
        }
        .padding(.horizontal, 12)
        .padding(.vertical, 8)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.opacity(0.12))
        )
    }
}
