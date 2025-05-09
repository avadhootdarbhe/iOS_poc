import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
            NavigationView {
                ScrollView {
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 20)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(viewModel.products) { product in
                            ProductCard(product: product)
                                .onAppear {
                                    if product == viewModel.products[viewModel.products.count - 3] {
                                        viewModel.loadNextPage()
                                    }

                                }
                        }
                    }
                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .navigationTitle("Products")
                .navigationBarItems(trailing:
                                        NavigationLink(destination: SettingScreenView()) {
                                    Image(systemName: "gearshape.fill")
                                        .imageScale(.large)
                                }
                            )
            }
            .onAppear {
                viewModel.loadInitialProducts()
            }
        }

    var filteredProducts: [Product] {
        if searchText.isEmpty {
            return viewModel.products
        } else {
            return viewModel.products.filter {
                $0.title.lowercased().contains(searchText.lowercased())
            }
        }
    }
}

#Preview {
    HomeScreenView()
}
