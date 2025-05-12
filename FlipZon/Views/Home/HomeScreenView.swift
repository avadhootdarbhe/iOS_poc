import SwiftUI

struct HomeScreenView: View {
    @EnvironmentObject var cartManager: CartManager
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    let columns = [GridItem(.flexible()), GridItem(.flexible())]
    var body: some View {
            NavigationView {
                ScrollView {
                    SearchBar(text: $searchText)
                        .padding(.horizontal, 20)
                    LazyVGrid(columns: columns, spacing: 16) {
                        ForEach(Array(viewModel.products.enumerated()), id: \.element.id) { index, product in
                            NavigationLink(destination: ProductDetailScreenView(product: product)) {
                                ProductCard(product: product)
                                    .onAppear {
                                        // Safe pagination trigger — when user scrolls near end
                                        if index == viewModel.products.count - 3 {
                                            viewModel.loadNextPage()
                                        }
                                    }
                            }
                            .buttonStyle(PlainButtonStyle())
                            
                        }
                    }

                    .padding()
                    
                    if viewModel.isLoading {
                        ProgressView()
                            .padding()
                    }
                }
                .navigationTitle("Products")
                .navigationBarBackButtonHidden(true)
                .toolbar {
                    ToolbarItemGroup(placement: .navigationBarTrailing) {
                        // Settings button
                        NavigationLink(destination: SettingScreenView()) {
                            Image(systemName: "gearshape.fill")
                                .imageScale(.large)
                        }
                        
                        // Cart button with badge
                        NavigationLink(destination: CartScreenView()) {
                            ZStack(alignment: .topTrailing) {
                                Image(systemName: "cart")
                                    .font(.title2)
                                
                                if cartManager.items.count > 0 {
                                    Text("\(cartManager.items.count)")
                                        .font(.caption2)
                                        .foregroundColor(.white)
                                        .padding(4)
                                        .background(Color.red)
                                        .clipShape(Circle())
                                        .offset(x: 10, y: -10)
                                }
                            }
                        }
                        
                    }
                }
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
