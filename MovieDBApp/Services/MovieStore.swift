
import Foundation

class MovieStore: MovieServices {
    
    
    static let shared = MovieStore()
    private init() {}
    
    private let apiKey = "9d82ef2d5ffc63b8ed6871d61e7944f2"
    private let  baseApiURL = "https:// api.themoviedb.org/3"
    private let urlSession = URLSession.shared
    private let jsonDecoder = Utilities.jsonDecoder
    
    
    func fetchMovie(from endpoint: MovieListEndPoints, completion: @escaping (Result<MovieResponce, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseApiURL)/movie/\(endpoint.rawValue)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDecode(url: url, completion: completion)
    }
    
    func fetchMovie(id: Int, completion: @escaping (Result<Movie, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseApiURL)/movie/\(id)") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDecode(url: url, parametrs: ["append_to_response":"videos, credits"], completion: completion)
    }
    
    
    func searchingMovie(query: String, completion: @escaping (Result<MovieResponce, MovieError>) -> ()) {
        guard let url = URL(string: "\(baseApiURL)/search/movie") else {
            completion(.failure(.invalidEndPoint))
            return
        }
        self.loadURLandDecode(url: url, parametrs: ["language":"en-EN", "include_adult": "false", "region": "US", "query": query] , completion: completion) // change to RU
    }
    
    
    private func loadURLandDecode<D: Decodable>(url: URL, parametrs: [String: String]? = nil, completion: @escaping(Result<D, MovieError>) -> ()) {
        guard var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        var queryItems = [URLQueryItem(name: "api_key", value: apiKey)]
        if let parametrs = parametrs {
            queryItems.append(contentsOf: parametrs.map { URLQueryItem(name: $0.key, value: $0.value) })
        }
        
        urlComponents.queryItems = queryItems
        
        guard let finalURL = urlComponents.url else {
            completion(.failure(.invalidEndPoint))
            return
        }
        
        urlSession.dataTask(with: finalURL) { [weak self](data, response, error) in
            guard let self = self else { return }
            if error != nil {
                self.executeCompletionHandinMainThread(with: .failure(.apiError), completion: completion)
                completion(.failure(.apiError))
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                self.executeCompletionHandinMainThread(with: .failure(.invalideResponse), completion: completion)
                return
            }
            
            guard let data = data else {
                self.executeCompletionHandinMainThread(with: .failure(.noData), completion: completion)
                return
            }
            do {
                let decodeResponse = try self.jsonDecoder.decode(D.self, from: data)
                self.executeCompletionHandinMainThread(with: .success(decodeResponse), completion: completion)
                
            } catch {
                self.executeCompletionHandinMainThread(with: .failure(.serializationError), completion: completion)
            }
        }.resume()
    }
    
    private func executeCompletionHandinMainThread<D: Decodable>( with result: Result<D, MovieError>, completion: @escaping(Result<D, MovieError>) -> ()) {
     
        DispatchQueue.main.async {
            completion(result)
        }
        
    }
    
}
