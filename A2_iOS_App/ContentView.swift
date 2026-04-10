import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            Text("Browse")
                .tabItem {
                    Label("Browse", systemImage: "house.fill")
                }

            Text("Products")
                .tabItem {
                    Label("Products", systemImage: "list.bullet")
                }

            Text("Search")
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
        }
    }
}
