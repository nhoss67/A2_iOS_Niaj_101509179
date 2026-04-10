import SwiftUI

struct AddProductView: View {
    @Environment(\.managedObjectContext) private var viewContext
    @Environment(\.dismiss) private var dismiss

    @State private var name = ""
    @State private var productDescription = ""
    @State private var priceText = ""
    @State private var provider = ""
    @State private var showingAlert = false
    @State private var alertMessage = ""

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
                    Button(action: saveProduct) {
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
            .alert("Invalid Input", isPresented: $showingAlert) {
                Button("OK") {}
            } message: {
                Text(alertMessage)
            }
        }
    }

    private func saveProduct() {
        let trimmedName = name.trimmingCharacters(in: .whitespaces)
        guard !trimmedName.isEmpty else {
            alertMessage = "Please enter a product name."
            showingAlert = true
            return
        }

        guard let price = Double(priceText.trimmingCharacters(in: .whitespaces)), price >= 0 else {
            alertMessage = "Please enter a valid price (e.g. 9.99)."
            showingAlert = true
            return
        }

        let newProduct = Product(context: viewContext)
        newProduct.id = UUID()
        newProduct.name = trimmedName
        newProduct.productDescription = productDescription.trimmingCharacters(in: .whitespaces)
        newProduct.price = price
        newProduct.provider = provider.trimmingCharacters(in: .whitespaces)

        do {
            try viewContext.save()
            dismiss()
        } catch {
            alertMessage = "Failed to save: \(error.localizedDescription)"
            showingAlert = true
        }
    }
}
