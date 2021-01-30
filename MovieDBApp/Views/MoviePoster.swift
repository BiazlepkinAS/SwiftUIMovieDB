//
//  MoviePoster.swift
//  MovieDBApp
//
//  Created by Andrei Bezlepkin on 29.01.21.
//

import SwiftUI

struct MoviePoster: View {
    
    let movie: Movie
    @ObservedObject var imageLoader = ImageLoader()
    
    
    var body: some View {
        
        ZStack {
            
            if self.imageLoader.image != nil {
                Image(uiImage: self.imageLoader.image!)
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .cornerRadius(8)
                    .shadow(radius: 4)
                
            } else {
                Rectangle()
                    .fill(Color.gray.opacity(0.3))
                
                Text(movie.title)
                    .multilineTextAlignment(.center)
                
            }
        }
        .frame(width: 204, height: 306)
        .onAppear {
            self.imageLoader.loadImage(with: self.movie.posterURL)
        }
    }
}

struct MoviePoster_Previews: PreviewProvider {
    static var previews: some View {
        MoviePoster(movie: Movie.stubbedMovie)
    }
}
