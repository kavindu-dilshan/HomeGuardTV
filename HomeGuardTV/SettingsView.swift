import SwiftUI

struct SettingsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Settings")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("This is a placeholder settings screen.")
                .foregroundColor(Color(white: 0.8))

            Spacer()
        }
    }
}
