import SwiftUI

struct SearchBar: View {
    @Binding var text: String
    
    var body: some View {
        HStack{
            Image(systemName: "magnifyingglass")
                .foregroundColor(.gray)

            TextField("Search", text: $text)
                .keyboardType(.emailAddress)
                .autocapitalization(.none)
                .disableAutocorrection(true)
        }
        .padding(.horizontal)
        .frame(height: 50)  // Consistent height
        .background(Color(.secondarySystemBackground))
        .cornerRadius(8)
    }
}
