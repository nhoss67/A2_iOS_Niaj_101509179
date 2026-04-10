import SwiftUI
import CoreData

struct BrowseView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            VStack {
                if products.isEmpty {
                    Spacer()
                    Image(systemName: "cube.box")
                        .font(.system(size: 60))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 12)
                    Text("No products available.")
                        .font(.title3)
                        .foregroundColor(.secondary)
                    Spacer()
                } else {
                    Text("Products loaded: \(products.count)")
                        .font(.title3)
                        .padding()
                }
            }
            .navigationTitle("Browse Products")
        }
    }
}
