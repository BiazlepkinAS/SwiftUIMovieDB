
import SwiftUI

struct MovieLIst: View {
    
    @ObservedObject private var nowPlayingState = MovieListState()
    @ObservedObject private var upCommingState = MovieListState()
    @ObservedObject private var topRatedState = MovieListState()
    @ObservedObject private var popularState = MovieListState()
    
    var body: some View {
        
        NavigationView {
            List {
                Group {
                    if nowPlayingState.movies != nil {
                        MoviePosterCarousel(title: "Now playing", movies: nowPlayingState.movies!)
                    } else {
                        LoadView(isLoading: nowPlayingState.isLoading, error: nowPlayingState.error) {
                            self.nowPlayingState.loadMovies(with: .nowPlaying)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                Group {
                    if upCommingState.movies != nil {
                        MovieBAckCarousel(title: "Upcoming", movies: upCommingState.movies!)
                    } else {
                        LoadView(isLoading: upCommingState.isLoading, error: upCommingState.error) {
                            self.upCommingState.loadMovies(with: .upComing)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 16, leading: 0, bottom:16, trailing: 0))
                Group {
                    if topRatedState.movies != nil {
                        MovieBAckCarousel(title: "Top raited", movies: topRatedState.movies!)
                    } else {
                        LoadView(isLoading: topRatedState.isLoading, error: topRatedState.error) {
                            self.topRatedState.loadMovies(with: .topRated)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 8, trailing: 0))
                Group {
                    if popularState.movies != nil {
                        MovieBAckCarousel(title: "Popular", movies: popularState.movies!)
                    } else {
                        LoadView(isLoading: popularState.isLoading, error: popularState.error) {
                            self.popularState.loadMovies(with: .popular)
                        }
                    }
                }
                .listRowInsets(EdgeInsets(top: 8, leading: 0, bottom: 16, trailing: 0))
            }
            .navigationBarTitle("MovieDB")
        }
        .onAppear {
            self.nowPlayingState.loadMovies(with: .nowPlaying)
            self.upCommingState.loadMovies(with: .upComing)
            self.topRatedState.loadMovies(with: .topRated)
            self.popularState.loadMovies(with: .popular)
        }
    }
}

struct MovieLIst_Previews: PreviewProvider {
    static var previews: some View {
        MovieLIst()
    }
}
