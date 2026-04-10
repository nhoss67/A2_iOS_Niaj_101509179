import SwiftUI
import CoreData

struct BrowseView: View {
    @Environment(\.managedObjectContext) private var viewContext

    @FetchRequest(
        sortDescriptors: [NSSortDescriptor(keyPath: \Product.name, ascending: true)],
        animation: .default
    ) private var products: FetchedResults<Product>

    @State private var currentIndex: Int = 0
    @State private var showingAddProduct = false

    var body: some View {
        NavigationView {
            VStack(spacing: 0) {
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

                    ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                            // Header card
                            HStack(alignment: .top) {
                                VStack(alignment: .leading, spacing: 4) {
                                    Text("Product \(currentIndex + 1) of \(products.count)")
                                        .font(.caption)
                                        .foregroundColor(.secondary)
                                    Text(product.name ?? "Unknown")
                                        .font(.title2)
                                        .bold()
                                        .fixedSize(horizontal: false, vertical: true)
                                }
                                Spacer()
                                Image(systemName: "cube.box.fill")
                                    .font(.system(size: 44))
                                    .foregroundColor(.blue)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)

                            // Details card
                            VStack(alignment: .leading, spacing: 12) {
                                InfoRow(label: "Product ID",
                                        value: product.id?.uuidString.prefix(8).description ?? "N/A")
                                Divider()
                                InfoRow(label: "Provider",
                                        value: product.provider ?? "N/A")
                                Divider()
                                InfoRow(label: "Price",
                                        value: String(format: "$%.2f", product.price))
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)

                            // Description card
                            VStack(alignment: .leading, spacing: 8) {
                                Text("Description")
                                    .font(.headline)
                                Text(product.productDescription ?? "No description available.")
                                    .foregroundColor(.secondary)
                                    .fixedSize(horizontal: false, vertical: true)
                            }
                            .padding()
                            .background(Color(.systemGray6))
                            .cornerRadius(12)
                        }
                        .padding()
                    }

                    // Navigation buttons
                    HStack(spacing: 12) {
                        Button(action: {
                            withAnimation { currentIndex -= 1 }
                        }) {
                            HStack {
                                Image(systemName: "chevron.left")
                                Text("Previous")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(currentIndex > 0 ? Color.blue : Color.gray.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(currentIndex == 0)

                        Button(action: {
                            withAnimation { currentIndex += 1 }
                        }) {
                            HStack {
                                Text("Next")
                                Image(systemName: "chevron.right")
                            }
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 12)
                            .background(currentIndex < products.count - 1 ? Color.blue : Color.gray.opacity(0.4))
                            .foregroundColor(.white)
                            .cornerRadius(10)
                        }
                        .disabled(currentIndex == products.count - 1)
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 12)
                }
            }
            .navigationTitle("Browse Products")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: { showingAddProduct = true }) {
                        Image(systemName: "plus")
                    }
                }
            }
            .sheet(isPresented: $showingAddProduct) {
                AddProductView()
            }
        }
    }
}

struct InfoRow: View {
    let label: String
    let value: String

    var body: some View {
        HStack {
            Text(label)
                .font(.subheadline)
                .foregroundColor(.secondary)
                .frame(width: 110, alignment: .leading)
            Text(value)
                .font(.subheadline)
                .bold()
            Spacer()
        }
    }
}
