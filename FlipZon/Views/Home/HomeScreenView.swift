
import SwiftUI

struct HomeScreenView: View {
    @StateObject var viewModel = HomeViewModel()
    @State private var searchText = ""
    var body: some View {
        ScrollView {
            VStack {
                Spacer().frame(height: 20)
                SearchBar(text: $searchText)
                    .padding([.leading, .trailing], 16)
                Spacer().frame(height: 20)
                Text("Products")
                    .font(.title)
                    .foregroundColor(.brown)
                    .fontWeight(.bold)
                    .padding(.horizontal, 16)
                    .frame(maxWidth: screenWidth, alignment: .leading)
                LazyVGrid(
                    columns: [
                        GridItem(.flexible()),
                        GridItem(.flexible()),
                    ],
                    spacing: 5
                ){
                    ForEach(filteredProducts){
                        product in
                        ProductCard(product: product)
                            .frame(height: 250)
                    }
                }
                .padding()
            }
            .navigationTitle("Home")
            .navigationBarTitleDisplayMode(.inline)
            
        }
        
    }
    
    var filteredProducts: [Product] {
            if searchText.isEmpty {
                return viewModel.products
            } else {
                return viewModel.products.filter {
                    $0.name.lowercased().contains(searchText.lowercased())
                }
            }
        }
}

#Preview {
    HomeScreenView()
}
