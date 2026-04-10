import SwiftUI
import CoreData

struct BrowseView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var currentIndex: Int = 0

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
                    let product = products[min(currentIndex, products.count - 1)]

                    VStack(spacing: 16) {
                        Text("Product \(currentIndex + 1) of \(products.count)")
                            .font(.caption)
                            .foregroundColor(.secondary)

                        Text(product.name ?? "Unknown")
                            .font(.title2)
                            .bold()

                        Text(String(format: "$%.2f", product.price))
                            .font(.title3)
                            .foregroundColor(.blue)
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color(.systemGray6))
                    .cornerRadius(12)
                    .padding()

                    Spacer()
                }
            }
            .navigationTitle("Browse Products")
        }
    }
}
