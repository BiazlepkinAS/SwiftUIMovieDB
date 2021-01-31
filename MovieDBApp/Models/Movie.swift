
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
    let releaseDate: String?
    
    let genres: [MovieGenre]?
    let credits: MovieCredit?
    let videos: MovieVodeoResponse?
    
    static private var yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    static private let durationFormatter: DateComponentsFormatter = {
        
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .full
        formatter.allowedUnits = [.hour, .minute]
        return formatter
    }()
    
    var backDropURL: URL {
        return URL(string: "https://image.tmbd.org/t/p/w500\(backdropPath ?? "")")!
    }
    
    var posterURL: URL {
        return URL(string: "https://image.tmbd.org/t/p/w500\(posterPath ?? "")")!
    }
    var genreText: String {
        genres?.first?.name ?? "n/a"
    }
    
    var raitingText: String {
        let rating = Int(voteAverage)
        let ratingText = (0..<rating).reduce("") { (acc, _) -> String in
            
            
            return acc + "⭐️"
    }
        return ratingText
    }
    
    var scoreText: String  {
        guard raitingText.count > 0 else {
            return "n/a"
        }
        return "\(raitingText.count)/10"
    }
    
    var yearText: String {
        guard let releaseDate = self.releaseDate, let date = Utilities.dateFormatter.date(from: releaseDate) else {
            return "n/a"
        }
        return Movie.yearFormatter.string(from: date)
    }
    
    var durationText: String {
        guard let runtime = self.runtime, runtime > 0 else {
            return "n/a"
        }
        return Movie.durationFormatter.string(from: TimeInterval(runtime) * 60) ?? "n/a"
        
    }
    var casts: [MovieCast]? {
        credits?.cast
    }
    var crew: [MovieCrew]? {
        credits?.crew
    }
    var directors: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "director"}
    }
    var produsers: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "produser"}
    }
    
    var screeWriter: [MovieCrew]? {
        crew?.filter { $0.job.lowercased() == "story"}
    }
    
    var youtubeTrailer: [MovieVideos]? {
        videos?.result.filter { $0.youtubeURL != nil  }
        
    }
    
}

struct MovieGenre: Decodable {
    let name: String
}

struct MovieCredit: Decodable {
    let cast: [MovieCast]
    let crew: [MovieCrew]
}

struct MovieCast: Decodable, Identifiable {
    let id: Int
    let character: String
    let name: String
}

struct MovieCrew: Decodable, Identifiable {
    let id: Int
    let job: String
    let name: String
}

struct MovieVodeoResponse: Decodable {
    let result: [MovieVideos]
}

struct  MovieVideos: Decodable, Identifiable {
    
    let id: String
    let key: String
    let name: String
    let site: String
    
    
    var youtubeURL: URL? {
        guard site == "YouTube" else {
            return nil
        }
        return URL(string: "https://youtube.com/watch?v=\(key)")
    }
    
    
}
