
import Foundation


protocol MovieServices {
    func fetchMovie(from endpoint: MovieListEndPoints, completion: @escaping (Result<MovieResponce, MovieError>) -> ())
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) ->())
    func searchingMovi(query: String, completion: @escaping (Result<MovieResponce, MovieError>) -> ())

}

enum MovieListEndPoints: String, CaseIterable, Identifiable {
    var id: String { rawValue }
    
    case nowPlaying = "now_playing"
    case upComing
    case topRated = "top_rated"
    case popular
    
    var description: String {
        switch self {
        case .nowPlaying: return "Now playing"
        case .upComing: return "Upcoming"
        case .topRated: return "Top Rated"
        case .popular: return "Popular"
            
        }
    }
}


enum MovieError: Error , CustomNSError{
    case apiError
    case invalidEndPoint
    case invalideResponse
    case noData
    case serializationError
    
    var localizationDescription: String {
        switch self {
        case .apiError: return "Failed fetch Data"
        case .invalidEndPoint: return "Invaled endPoint"
        case .invalideResponse: return "Invaled response"
        case .serializationError: return "Failed to decode"
        case .noData: return "No Data"
        }
    }
    var errorUserInfo: [String : Any] {
        [NSLocalizedDescriptionKey: localizationDescription]
    }
}
