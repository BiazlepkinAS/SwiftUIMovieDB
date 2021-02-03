
import SwiftUI
class MovieListState: ObservableObject {
    
    @Published var movies:  [Movie]?
    @Published var isLoading: Bool = false
    @Published var error: NSError?
    private let movieServise: MovieServices
    
    init(movieSetvice: MovieServices = MovieStore.shared) {
        self.movieServise = movieSetvice
    }
    
    func loadMovies(with endPoint: MovieListEndPoints) {
        self.movies = nil
        self.isLoading = false
        self.movieServise.fetchMovie(from: endPoint) { [weak self] (result) in
            guard let self = self else {return}
            self.isLoading = false
            
            switch result {
            case .success(let response):
                self.movies = response.result
            case .failure(let error):
                self.error = error as NSError
            }
        }
    }
}
