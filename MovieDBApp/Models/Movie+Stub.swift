

import Foundation

extension Movie {
    
    static var stubbedMovies: [Movie] {
        let response: MovieResponce? = try? Bundle.main.loadADecodeJSON(filename: "movie_list")
        return response!.result
    }
    
    static var stubbedMovie: Movie {
        stubbedMovies[0]
    }
    
}

extension Bundle {
    
    func loadADecodeJSON<D: Decodable>(filename: String) throws -> D? {
        
        guard let url = self.url(forResource: filename, withExtension: "json") else {
            return nil
        }
        let data = try Data(contentsOf: url)
        let jsonDecoder = Utilities.jsonDecoder
        let decodeModel = try jsonDecoder.decode(D.self, from: data)
        return decodeModel
        
    }
}
