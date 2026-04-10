import SwiftUI
import CoreData

struct SearchView: View {
    @State private var searchText = ""

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

                Spacer()
                Text("Start typing to search products.")
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                Spacer()
            }
            .navigationTitle("Search Products")
        }
    }
}
