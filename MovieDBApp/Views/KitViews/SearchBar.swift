
import SwiftUI

struct SearchBar: UIViewRepresentable {'
    
    let placeholder: String
    @Binding var text: String
    
    
    func makeUIView(context: Context) -> UISearchBar {
        
        let searchBar = UISearchBar(frame: .zero)
        searchBar.placeholder = placeholder
        searchBar.searchBarStyle = .minimal
        
    }
    
}
