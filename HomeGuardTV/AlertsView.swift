import SwiftUI

struct AlertsView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Alerts")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("This is a placeholder alerts screen.")
                .foregroundColor(Color(white: 0.8))

            Spacer()
        }
    }
}
