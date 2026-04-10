import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    var body: some View {
        NavigationView {
            VStack(spacing: 12) {
                Image(systemName: "tray")
                    .font(.system(size: 50))
                    .foregroundColor(.secondary)
                Text("No products yet.")
                    .font(.title3)
                    .foregroundColor(.secondary)
            }
            .navigationTitle("All Products")
        }
    }
}
