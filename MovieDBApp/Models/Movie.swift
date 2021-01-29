
import Foundation

struct MovieResponce: Decodable {
    
    let result: [Movie]
}

struct Movie: Decodable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage:Double
    let voteCount: Int
    let runtime: Int?
    
}
