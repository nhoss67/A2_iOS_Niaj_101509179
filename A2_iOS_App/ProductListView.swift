import SwiftUI
import CoreData

struct ProductListView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    var body: some View {
        NavigationView {
            Group {
                if products.isEmpty {
                    VStack(spacing: 12) {
                        Image(systemName: "tray")
                            .font(.system(size: 50))
                            .foregroundColor(.secondary)
                        Text("No products yet.")
                            .font(.title3)
                            .foregroundColor(.secondary)
                    }
                } else {
                    List {
                        ForEach(products) { product in
                            VStack(alignment: .leading, spacing: 4) {
                                Text(product.name ?? "Unknown")
                                    .font(.headline)
                                Text(product.productDescription ?? "")
                                    .font(.subheadline)
                                    .foregroundColor(.secondary)
                                    .lineLimit(2)
                                HStack {
                                    Text(String(format: "$%.2f", product.price))
                                        .font(.caption)
                                        .foregroundColor(.blue)
                                        .bold()
                                    Spacer()
                                    Text(product.provider ?? "")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                }
                            }
                            .padding(.vertical, 4)
                        }
                        .onDelete(perform: deleteProducts)
                    }
                }
            }
            .navigationTitle("All Products (\(products.count))")
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    EditButton()
                }
            }
        }
    }

    private func deleteProducts(offsets: IndexSet) {
        withAnimation {
            offsets.map { products[$0] }.forEach(viewContext.delete)
            try? viewContext.save()
        }
    }
}
