import SwiftUI

struct SettingsView: View {
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 28) {
                SettingsHeaderRow()

                Divider().background(Color.white.opacity(0.06))

                // Account
                SettingsSectionBox(title: "Account") {
                    SettingsRow(icon: "person.crop.circle", title: "Profile", value: "Kavindu D.")
                    SettingsRow(icon: "envelope", title: "Email", value: "user@example.com")
                    SettingsRow(icon: "icloud", title: "iCloud Sync", value: "Enabled")
                }

                // Notifications
                SettingsSectionBox(title: "Notifications") {
                    ToggleRow(icon: "video.circle", title: "Motion Alerts", isOn: .constant(true))
                    ToggleRow(icon: "door.left.hand.closed", title: "Door/Lock Alerts", isOn: .constant(true))
                    ToggleRow(icon: "speaker.wave.2", title: "Sound Alerts", isOn: .constant(false))
                    ToggleRow(icon: "bell", title: "System Alerts", isOn: .constant(true))
                }

                // Security
                SettingsSectionBox(title: "Security") {
                    SelectorRow(icon: "shield.lefthalf.fill", title: "Default Mode", options: ["Away", "Home", "Disarmed"], selectedIndex: 0)
                    ToggleRow(icon: "number.circle", title: "Two‑Factor Authentication", isOn: .constant(true))
                    ToggleRow(icon: "moon", title: "Auto‑Arm at Night", isOn: .constant(true))
                }

                // System
                SettingsSectionBox(title: "System") {
                    SelectorRow(icon: "paintbrush", title: "App Theme", options: ["Dark", "Auto"], selectedIndex: 0)
                    SelectorRow(icon: "camera.aperture", title: "Video Quality", options: ["High", "Medium"], selectedIndex: 0)
                    HStack {
                        SettingsRow(icon: "externaldrive", title: "Storage Used", value: "28.3 GB")
                        Spacer()
                        SmallCTAButton(title: "Manage", icon: "arrow.right")
                    }
                }

                // About
                SettingsSectionBox(title: "About") {
                    SettingsRow(icon: "info.circle", title: "Version", value: "1.0.0 (1)")
                    SettingsRow(icon: "doc.text", title: "Licenses", value: "Open Source")
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
private struct SettingsHeaderRow: View {
    var body: some View {
        HStack(alignment: .center) {
            VStack(alignment: .leading, spacing: 6) {
                Text("Settings")
                    .font(.title3)
                    .fontWeight(.bold)
                    .foregroundColor(.white)
                Text("Configure HomeGuard TV preferences")
                    .foregroundColor(Color.white.opacity(0.7))
                    .font(.subheadline)
            }
            Spacer()
            Text("Profile: Protected")
                .foregroundColor(Color("AccentGreen"))
                .font(.subheadline)
        }
    }
}

// MARK: - Sections & Rows
private struct SettingsSectionBox<Content: View>: View {
    var title: String
    var content: () -> Content
    init(title: String, @ViewBuilder content: @escaping () -> Content) {
        self.title = title
        self.content = content
    }
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .font(.subheadline)
                .fontWeight(.semibold)
                .foregroundColor(.white)
            VStack(spacing: 8) {
                content()
            }
            .padding(16)
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
}

private struct SettingsRow: View {
    var icon: String
    var title: String
    var value: String
    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 36, height: 36)
                .overlay(Image(systemName: icon).foregroundColor(.white))
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            Spacer()
            Text(value)
                .foregroundColor(Color.white.opacity(0.8))
                .font(.footnote)
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
    }
}

private struct ToggleRow: View {
    var icon: String
    var title: String
    @Binding var isOn: Bool
    init(icon: String, title: String, isOn: Binding<Bool>) {
        self.icon = icon
        self.title = title
        self._isOn = isOn
    }
    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 36, height: 36)
                .overlay(Image(systemName: icon).foregroundColor(.white))
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
    }
}

private struct SelectorRow: View {
    var icon: String
    var title: String
    var options: [String]
    var selectedIndex: Int
    var body: some View {
        HStack(spacing: 14) {
            Circle()
                .fill(Color.white.opacity(0.12))
                .frame(width: 36, height: 36)
                .overlay(Image(systemName: icon).foregroundColor(.white))
            Text(title)
                .foregroundColor(.white)
                .font(.subheadline)
            Spacer()
            HStack(spacing: 8) {
                ForEach(options.indices, id: \.self) { idx in
                    Text(options[idx])
                        .font(.footnote)
                        .fontWeight(.semibold)
                        .foregroundColor(.white)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 6)
                        .background(
                            Capsule().fill(idx == selectedIndex ? Color("AccentGreen") : Color("CardBackground").opacity(0.85))
                        )
                }
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 10)
        .background(
            RoundedRectangle(cornerRadius: 10, style: .continuous)
                .fill(Color.white.opacity(0.05))
        )
    }
}

private struct SmallCTAButton: View {
    var title: String
    var icon: String
    var body: some View {
        HStack(spacing: 8) {
            Text(title)
                .foregroundColor(.white)
                .font(.footnote)
            Image(systemName: icon)
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
