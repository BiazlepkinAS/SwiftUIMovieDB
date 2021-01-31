//
//  MovieBAckCarousel.swift
//  MovieDBApp
//
//  Created by Andrei Bezlepkin on 29.01.21.
//

import SwiftUI

struct MovieBAckCarousel: View {
    
    let title: String
    let movies: [Movie]
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text(title)
                .font(.title)
                .fontWeight(.bold)
                .padding(.horizontal)
            
            
            ScrollView(.horizontal, showsIndicators: false) {
                HStack(alignment: .top, spacing: 16) {
                    ForEach(self.movies) { movie in
                        NavigationLink(destination: MovieDetails(movieID: movie.id)) {
                            MovieBackCard(movie: movie)
                                .frame(width: 272, height: 200)
                            
                        }
                        .buttonStyle(PlainButtonStyle())
                        .padding(.leading, movie.id == self.movies.first!.id ? 16 : 0)
                        .padding(.trailing, movie.id == self.movies.last!.id ? 16 : 0)
                    }
                }
            }
        }
    }
}

struct MovieBAckCarousel_Previews: PreviewProvider {
    static var previews: some View {
        MovieBAckCarousel(title: "Latest", movies: Movie.stubbedMovies)
    }
}
