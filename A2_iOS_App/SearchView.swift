import SwiftUI
import CoreData

struct SearchView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var searchText = ""

    var filteredProducts: [Product] {
        if searchText.trimmingCharacters(in: .whitespaces).isEmpty {
            return Array(products)
        }
        let query = searchText.lowercased()
        return products.filter { product in
            let nameMatch = product.name?.lowercased().contains(query) ?? false
            let descMatch = product.productDescription?.lowercased().contains(query) ?? false
            return nameMatch || descMatch
        }
    }

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
                // Search bar
                HStack {
                    Image(systemName: "magnifyingglass")
                        .foregroundColor(.secondary)
                    TextField("Search by name or description…", text: $searchText)
                        .autocapitalization(.none)
                        .disableAutocorrection(true)
                    if !searchText.isEmpty {
                        Button(action: { searchText = "" }) {
                            Image(systemName: "xmark.circle.fill")
                                .foregroundColor(.secondary)
                        }
                    }
                }
                .padding(10)
                .background(Color(.systemGray6))
                .cornerRadius(10)
                .padding()

                if filteredProducts.isEmpty {
                    Spacer()
                    Image(systemName: "magnifyingglass")
                        .font(.system(size: 50))
                        .foregroundColor(.secondary)
                        .padding(.bottom, 8)
                    Text(searchText.isEmpty
                         ? "Start typing to search products."
                         : "No results for \"\(searchText)\".")
                        .font(.subheadline)
                        .foregroundColor(.secondary)
                        .multilineTextAlignment(.center)
                        .padding(.horizontal)
                    Spacer()
                } else {
                    List(filteredProducts) { product in
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
                }
            }
            .navigationTitle("Search Products")
        }
    }
}
