import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                
                
                if viewModel.isLoading {
                    ProgressView("Loading Products...")
                        .padding()
                } else if let error = viewModel.errorMessage {
                    VStack {
                        Text("Failed to load products")
                            .foregroundColor(.red)
                        Text(error)
                            .font(.caption)
                            .foregroundColor(.gray)
                    }
                    .padding()
                } else {
                    ScrollView {
                        SearchBar(text: $searchText)
                            .padding(.horizontal, 16)
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 16) {
                            ForEach(filteredProducts) { product in
                                ProductCard(product: product)
                                    .frame(height: 250)
                            }
                        }
                        .padding()
                    }
                }
            }
            .navigationBarTitle("Products")
            
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
