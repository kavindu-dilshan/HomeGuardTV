import SwiftUI

struct CamerasView: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 24) {
            Text("Cameras")
                .font(.largeTitle)
                .fontWeight(.bold)
                .foregroundColor(.white)

            Text("This is a placeholder cameras screen.")
                .foregroundColor(Color(white: 0.8))

            Spacer()
        }
    }
}
