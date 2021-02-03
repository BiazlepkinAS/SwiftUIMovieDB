
import SwiftUI

struct MoviePosterCarousel: View {
    let title: String
    let movies: [Movie]
    
    var body: some View {
        
        VStack(alignment: .leading, spacing: 16) {
            Text(title)
                .font(.title)
                .fontWeight(.heavy)
                .padding(.horizontal)
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetails(movieID: movie.id)) {
                            MoviePoster(movie: movie)
                        } .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct MoviePOsterCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MoviePosterCarousel(title: "Now playing", movies: Movie.stubbedMovies)
        
    }
}
