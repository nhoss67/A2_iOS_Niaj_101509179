import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            BrowseView()
                .tabItem {
                    Label("Browse", systemImage: "house.fill")
                }

            ProductListView()
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            SearchView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
