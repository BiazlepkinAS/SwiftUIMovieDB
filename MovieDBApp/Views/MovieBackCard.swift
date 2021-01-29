
import SwiftUI

struct MovieBackCard: View {
    
    let movie: Movie
    
    @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        VStack(alignment: .leading) {
            ZStack {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                if self.imageLoader.image != nil {
                    Image(uiImage: self.imageLoader.image!)
                        .resizable()
                }
            }
            
            Text(movie.title)
        }
    }
}

struct MovieBackCard_Previews: PreviewProvider {
    static var previews: some View {
        MovieBackCard(movie: Movie.stubbedMovie)
    }
}
