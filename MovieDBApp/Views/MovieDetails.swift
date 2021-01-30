
import SwiftUI

struct MovieDetails: View {
    
    let movieID: Int
    @ObservedObject private var movieDetailsState = MOvieDetailState()
    
    
    
    
    var body: some View {
        ZStack{
            LoadView(isLoading: self.movieDetailsState.isLoading, error: self.movieDetailsState.error) {
                self.movieDetailsState.loadMovie(id: self.movieID)
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
