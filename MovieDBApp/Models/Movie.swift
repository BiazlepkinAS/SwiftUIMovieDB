
import Foundation

struct MovieResponce: Decodable {
    
    let result: [Movie]
}

struct Movie: Decodable, Identifiable {
    
    let id: Int
    let title: String
    let backdropPath: String?
    let posterPath: String?
    let overview: String
    let voteAverage:Double
    let voteCount: Int
    let runtime: Int?
    
    var backDropURL: URL {
        return URL(string: "https://image.tmbd.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmbd.org/t/p/w500\(posterPath ?? "")")!
    }
    
}
