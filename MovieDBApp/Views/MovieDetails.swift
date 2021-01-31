
import SwiftUI

struct MovieDetails: View {
    let movieID: Int
    @ObservedObject private var movieDetailsState = MovieDetailState()
    
    var body: some View {
        ZStack {
            LoadView(isLoading: self.movieDetailsState.isLoading, error: self.movieDetailsState.error) {
                self.movieDetailsState.loadMovie(id: self.movieID)
            }
            if movieDetailsState.movie != nil {
                MovieDetailListView(movie: self.movieDetailsState.movie!)
                   
            }
        }
        .navigationBarTitle(movieDetailsState.movie?.title ?? "" )
        .onAppear {
            self.movieDetailsState.loadMovie(id: self.movieID)
        }
    }
}

struct MovieDetailListView: View {
    
    let movie: Movie
    
    var body: some View {
        List {
            MovieDetailImage(imageURL: self.movie.backDropURL)
                .listRowInsets(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0))
            
            HStack {
                Text(movie.genreText)
                Text(".")
                Text(movie.yearText)
                Text(movie.durationText)
            }
            Text(movie.overview)
            HStack {
                if movie.raitingText.isEmpty {
                    Text(movie.durationText).foregroundColor(.yellow)
                }
                Text(movie.scoreText)
            }
            Divider()
        }
    }
}

struct MovieDetailImage: View {
    
    @ObservedObject private var imageLoader = ImageLoader()
    let imageURL: URL
    
    var body: some View {
        ZStack {
            Rectangle().fill(Color.gray.opacity(0.3))
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
            }
        }
        .aspectRatio(16/9, contentMode: .fit)
        .onAppear {
            self.imageLoader.loadImage(with: self.imageURL)
        }
    }
}

struct MovieDetails_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MovieDetails(movieID: Movie.stubbedMovie.id)
        }
    }
}
