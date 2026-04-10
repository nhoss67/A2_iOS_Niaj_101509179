import CoreData

struct PersistenceController {
    static let shared = PersistenceController()

    static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        return result
    }()

    let container: NSPersistentContainer

    init(inMemory: Bool = false) {
        container = NSPersistentContainer(name: "ProductModel")
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.loadPersistentStores { _, error in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true

        let context = container.viewContext
        let fetchRequest: NSFetchRequest<Product> = Product.fetchRequest()
        let count = (try? context.count(for: fetchRequest)) ?? 0
        if count == 0 {
            seedProducts(context: context)
        }
    }

    private func seedProducts(context: NSManagedObjectContext) {
        let sampleData: [(String, String, Double, String)] = [
            ("iPhone 15 Pro",
             "Apple's flagship smartphone with titanium design and the powerful A17 Pro chip.",
             999.99, "Apple Inc."),
            ("Samsung Galaxy S24",
             "Android flagship with Snapdragon 8 Gen 3 processor and a versatile 200 MP camera system.",
             849.99, "Samsung Electronics"),
            ("MacBook Air M3",
             "Ultra-thin laptop powered by the Apple M3 chip offering up to 18-hour battery life.",
             1299.99, "Apple Inc."),
            ("Sony WH-1000XM5",
             "Industry-leading noise-cancelling wireless headphones with 30-hour battery and multipoint connection.",
             349.99, "Sony Corporation"),
            ("iPad Pro 12.9\"",
             "Professional tablet with the Apple M2 chip and a stunning Liquid Retina XDR display.",
             1099.99, "Apple Inc."),
            ("Dell XPS 15",
             "High-performance laptop featuring an OLED display and an Intel Core i9 processor.",
             1799.99, "Dell Technologies"),
            ("Nintendo Switch OLED",
             "Hybrid gaming console with a vibrant 7-inch OLED screen and enhanced audio.",
             349.99, "Nintendo Co., Ltd."),
            ("LG C3 OLED TV 55\"",
             "Premium OLED television with perfect blacks, Dolby Vision IQ, and a 120 Hz refresh rate.",
             1299.99, "LG Electronics"),
            ("Dyson V15 Detect",
             "Cordless vacuum with laser dust detection and powerful multi-surface suction technology.",
             699.99, "Dyson Ltd."),
            ("GoPro HERO12 Black",
             "Waterproof action camera with HyperSmooth 6.0 video stabilization and 5.3K video recording.",
             399.99, "GoPro Inc.")
        ]

        for data in sampleData {
            let product = Product(context: context)
            product.id = UUID()
            product.name = data.0
            product.productDescription = data.1
            product.price = data.2
            product.provider = data.3
        }

        try? context.save()
    }
}
