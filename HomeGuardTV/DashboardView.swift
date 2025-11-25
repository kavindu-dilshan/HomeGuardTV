import SwiftUI

struct DashboardView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Dashboard")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("This is a placeholder dashboard screen.")
                .foregroundColor(Color(white: 0.8))

            Spacer()
        }
    }
}
