import SwiftUI

struct AddProductView: View {
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var productDescription = ""
    @State private var priceText = ""
    @State private var provider = ""

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Product Information")) {
                    TextField("Product Name", text: $name)
                    TextField("Provider / Brand", text: $provider)
                    TextField("Price (e.g. 9.99)", text: $priceText)
                        .keyboardType(.decimalPad)
                }

                Section(header: Text("Description")) {
                    TextEditor(text: $productDescription)
                        .frame(minHeight: 100)
                }

                Section {
                    Button(action: {
                        // Save logic coming next
                    }) {
                        HStack {
                            Spacer()
                            Text("Add Product")
                                .bold()
                            Spacer()
                        }
                    }
                    .foregroundColor(.blue)
                }
            }
            .navigationTitle("Add Product")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") { dismiss() }
                }
            }
        }
    }
}
